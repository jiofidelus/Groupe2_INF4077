package models

import (
	. "backend/configs"
	"log"
)

type Book struct {
	Title string `json:"title"`
}

func init() {
	log.Println("Running Auto Migration for Books Model")
	_ = DB.AutoMigrate(&Book{})
}
