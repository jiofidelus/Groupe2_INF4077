package models

import (
	. "backend/configs"
	"log"
)

type Application struct {
	ID           string `json:"identifier" gorm:"unique primaryKey"`
	Name         string `json:"name"`
	Version      string `json:"version"`
	PrimaryColor string `json:"primary_color"`
	AccentColor  string `json:"accent_color"`
}

func init() {
	log.Println("Running Auto Migration for Applications Model")
	_ = DB.AutoMigrate(&Application{})
}
