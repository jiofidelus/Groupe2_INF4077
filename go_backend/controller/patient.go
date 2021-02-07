package controller

import (
	"backend/app"
	"backend/configs"
	"backend/middleware"
	. "backend/models"
	"errors"
	"github.com/kataras/iris/v12"
	"gorm.io/gorm"
	"log"
	"net/http"
)

func init() {
	log.Println("Patient Controller init()")
	booksAPI := app.App.Party("/patients")

	booksAPI.Use(middleware.Logger())
	booksAPI.Use(middleware.AuthRequired())

	booksAPI.Get("/", allPatient)
	booksAPI.Post("/", newPatient)

}

func allPatient(ctx iris.Context) {

	var patients []Patient
	result := configs.DB.Find(&patients)

	if result.Error != nil && errors.Is(result.Error, gorm.ErrRecordNotFound) {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      "Unknown",
			Suggestion: "Some error happened",
		})
	}

	ctx.StopWithJSON(200, patients)
}

func newPatient(ctx iris.Context) {
	var patient Patient
	ctx.ReadBody(&patient)
	patient.ApplicationID = ctx.GetHeader("ApplicationID")

	result := configs.DB.Create(&patient)

	if result.Error != nil {
		ctx.StopWithJSON(500, ErrorModel{
			Error:      "Could not save user : " + result.Error.Error(),
			Suggestion: "Please contact the site admin",
		})
		return
	}

	ctx.StopWithJSON(200, patient)
}
