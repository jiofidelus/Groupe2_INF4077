package controller

import (
	"backend/app"
	"backend/configs"
	"backend/middleware"
	. "backend/models"
	"backend/templates"
	"bytes"
	"fmt"
	"github.com/kataras/iris/v12"
	"log"
	"net/http"
	"os"
	"os/exec"
	"text/template"
)

func init() {
	log.Println("Generator Controller init()")
	booksAPI := app.App.Party("/generator")

	booksAPI.Use(middleware.Logger())

	booksAPI.Post("/", generateApp)

}

func generateApp(ctx iris.Context) {

	//Opening files
	yamlf, err := os.Create("pubspec.yaml")
	if err != nil {
		log.Fatal(err)
	}

	mainf, err := os.Create("lib/main.dart")
	if err != nil {
		log.Fatal(err)
	}

	locf, err := os.Create("lib/domain/locations/location-model.dart")
	if err != nil {
		log.Fatal(err)
	}

	disf, err := os.Create("lib/domain/disease/disease-model.dart")
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

	//Creating the application in the database
	result := configs.DB.Create(&(data.App))

	if result.Error != nil {
		ctx.StopWithJSON(http.StatusBadRequest, ErrorModel{
			Error:      result.Error.Error(),
			Suggestion: "Unknown",
		})
		return
	}

	//Template binding
	yamlTmp := template.Must(template.New("pubspec.yaml").Parse(templates.Yaml))
	mainTmp := template.Must(template.New("main.dart").Parse(templates.MainApp))
	disTmp := template.Must(template.New("disease.dart").Parse(templates.Disease))
	locTmp := template.Must(template.New("location.dart").Parse(templates.Regions))

	yamlTmp.Execute(yamlf, data)
	mainTmp.Execute(mainf, data)
	disTmp.Execute(disf, data)
	locTmp.Execute(locf, data)

	disf.Close()
	mainf.Close()
	locf.Close()
	yamlf.Close()

	log.Println("Running flutter build")
	cmd2 := exec.Command("flutter", "build", "apk", "--split-per-abi")
	cmdOutput := &bytes.Buffer{}
	cmd2.Stdout = cmdOutput
	err2 := cmd2.Run()
	if err2 != nil {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      err2.Error(),
			Suggestion: "No idea",
		})
		return
	}
	fmt.Print(string(cmdOutput.Bytes()))
	ctx.StatusCode(http.StatusCreated)
	ctx.SendFile("build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk", data.App.ID+"v"+data.App.Version+".apk")
	ctx.StopExecution()

}
