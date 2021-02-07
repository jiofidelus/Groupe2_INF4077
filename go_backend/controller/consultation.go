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
	booksAPI := app.App.Party("/consultation")

	booksAPI.Use(middleware.Logger())
	booksAPI.Use(middleware.AuthRequired())

	booksAPI.Get("/", allConsultation)
	booksAPI.Post("/", newConsultation)

}

func allConsultation(ctx iris.Context) {

	var consultations []Consultation
	result := configs.DB.Find(&consultations)

	if result.Error != nil && errors.Is(result.Error, gorm.ErrRecordNotFound) {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      "Unknown : " + result.Error.Error(),
			Suggestion: "Some error happened",
		})
	}

	ctx.StopWithJSON(200, consultations)
}

func newConsultation(ctx iris.Context) {
	var consultation Consultation
	err := ctx.ReadBody(&consultation)

	if err != nil {
		ctx.StopWithJSON(500, err)
		return
	}
	consultation.ApplicationID = ctx.GetHeader("ApplicationID")

	configs.DB.Where(&Patient{ID: consultation.PatientID}).First(&consultation.Patient)
	configs.DB.Where(&Application{ID: consultation.ApplicationID}).First(&consultation.Application)

	result := configs.DB.Create(&consultation)

	if result.Error != nil {
		ctx.StopWithJSON(500, ErrorModel{
			Error:      "Could not save user : " + result.Error.Error(),
			Suggestion: "Please contact the site admin",
		})
		return
	}

	ctx.StopWithJSON(200, consultation)
}
