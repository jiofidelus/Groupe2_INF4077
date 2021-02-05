package models

import (
	. "backend/configs"
	"gorm.io/gorm"
	"log"
	"time"
)

type Consultation struct {
	ID          uint           `gorm:"primaryKey unique autoIncrement" json:"id"`
	CreatedAt   time.Time      `json:"created_at"`
	UpdatedAt   time.Time      `json:"updated_at"`
	DeletedAt   gorm.DeletedAt `gorm:"index" json:"deleted_at"`
	LocationID  int            `json:"location_id"`
	Result      int            `json:"result"`
	ConsultedBy int            `json:"consulted_by"`

	Patient       Patient     `json:"patient"`
	PatientID     uint        `json:"patient_id"`
	Application   Application `json:"application"`
	ApplicationID string      `json:"application_id"`
}

func init() {
	log.Println("Running Auto Migration for Patients Model")
	_ = DB.AutoMigrate(&Patient{})

	log.Println("Running Auto Migration for Consultation Model")
	_ = DB.AutoMigrate(&Consultation{})
}
