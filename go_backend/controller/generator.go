package controller

import (
	"backend/app"
	"backend/configs"
	"backend/middleware"
	. "backend/models"
	"backend/templates"
	"bytes"
	"errors"
	"fmt"
	"github.com/kataras/iris/v12"
	"gorm.io/gorm"
	"log"
	"net/http"
	"os"
	"os/exec"
	"strings"
	"text/template"
)

func init() {
	log.Println("Generator Controller init()")
	booksAPI := app.App.Party("/generator")

	booksAPI.Use(middleware.Logger())

	booksAPI.Post("/", generateApp)
	booksAPI.Get("/download", serveApp)

}

func serveApp(ctx iris.Context) {
	if !fileExist("../compiled/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk") {
		ctx.StopWithJSON(http.StatusBadRequest, ErrorModel{
			Error:      "No application found",
			Suggestion: "Please generate an application before downloading",
		})
		return
	}

	err := ctx.SendFile("../compiled/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk", ctx.URLParamDefault("name", "groupe2.apk"))
	if err != nil {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      err.Error(),
			Suggestion: "Could not return your application for some reasons",
		})
	}
	ctx.StopExecution()
}

func generateApp(ctx iris.Context) {

	//Opening files
	yamlf, err := os.Create("pubspec.yaml")
	if err != nil {
		log.Fatal(err)
	}

	mainf, err := os.Create("../compiled/lib/main.dart")
	if err != nil {
		log.Fatal(err)
	}

	homef, err := os.Create("../compiled/lib/presentation/home/home_screen.dart")
	if err != nil {
		log.Fatal(err)
	}

	locf, err := os.Create("../compiled/lib/domain/locations/location-model.dart")
	if err != nil {
		log.Fatal(err)
	}

	disf, err := os.Create("../compiled/lib/domain/disease/disease-model.dart")
	if err != nil {
		log.Fatal(err)
	}

	// Form struct
	data := struct {
		App      Application `json:"app" binding:"required"`
		Disease  Disease     `json:"disease" binding:"required"`
		Symptoms []Symptom   `json:"symptoms" binding:"required"`
		Results  []Results   `json:"results" binding:"required"`
		Regions  []Region    `json:"regions" binding:"required"`
	}{}

	err = ctx.ReadBody(&data)

	if err != nil {
		ctx.StopWithJSON(http.StatusBadRequest, ErrorModel{
			Error:      err.Error(),
			Suggestion: "Try fixing then retry",
		})
		return
	}

	//Verifying id does not exist
	var existInstance Application
	exist := configs.DB.Where(&Application{ID: data.App.ID}).First(&existInstance)
	if exist.Error != nil && errors.Is(exist.Error, gorm.ErrRecordNotFound) {

	} else {
		ctx.StopWithJSON(http.StatusBadRequest, ErrorModel{Error: "App with id already exist", Suggestion: "Try changing the app id"})
		return
	}

	//Template binding
	yamlTmp := template.Must(template.New("pubspec.yaml").Parse(templates.Yaml))
	mainTmp := template.Must(template.New("main.dart").Parse(templates.MainApp))
	homeTmp := template.Must(template.New("home_screen.dart").Parse(templates.Home))
	disTmp := template.Must(template.New("disease.dart").Parse(templates.Disease))
	locTmp := template.Must(template.New("location.dart").Parse(templates.Regions))

	_ = yamlTmp.Execute(yamlf, data)
	_ = mainTmp.Execute(mainf, data)
	_ = homeTmp.Execute(homef, data)
	_ = disTmp.Execute(disf, data)
	_ = locTmp.Execute(locf, data)

	_ = disf.Close()
	_ = mainf.Close()
	_ = locf.Close()
	_ = yamlf.Close()
	_ = homef.Close()

	log.Println("Entering application to generate")
	_ = executeCommand("ls", "../compiled")
	if err := executeCommand("flutter build apk --split-per-abi", "../compiled"); err != nil {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      err.Error(),
			Suggestion: "No idea",
		})
		return
	}

	// Storing the app in the database
	result := configs.DB.Create(&(data.App))

	if result.Error != nil {
		ctx.StopWithJSON(http.StatusBadRequest, ErrorModel{
			Error:      result.Error.Error(),
			Suggestion: "Unknown",
		})
		return
	}

	ctx.StopWithJSON(http.StatusCreated, iris.Map{"link": "generator/download/?name=" + data.App.ID + "v" + data.App.Version + ".apk"})

}

func executeCommand(command string, directory string) error {
	commands := strings.Split(strings.TrimSpace(command), " ")
	log.Println("Executing : " + command)
	cmd := exec.Command(commands[0], commands[1:]...)

	cmd.Dir = string(directory)

	cmdOutput := &bytes.Buffer{}
	cmdError := &bytes.Buffer{}
	cmd.Stdout = cmdOutput
	cmd.Stderr = cmdError

	if err := cmd.Run(); err != nil {
		fmt.Print(string(cmdOutput.Bytes()))
		fmt.Print(string(cmdError.Bytes()))
		return err
	}

	fmt.Print(string(cmdOutput.Bytes()))
	return nil
}

func fileExist(name string) bool {
	if _, err := os.Stat(name); err != nil {
		if os.IsNotExist(err) {
			return false
		}
	}
	return true
}
