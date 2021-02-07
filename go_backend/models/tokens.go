package models

import (
	. "backend/configs"
	"gorm.io/gorm"
	"log"
	"time"
)

type Tokens struct {
	ID        uint           `gorm:"primaryKey unique autoIncrement" json:"id"`
	CreatedAt time.Time      `json:"created_at"`
	UpdatedAt time.Time      `json:"updated_at"`
	DeletedAt gorm.DeletedAt `gorm:"index" json:"deleted_at"`
	Token     string         `json:"token"`
	User      User           `json:"user"`
	UserID    uint           `json:"user_id"`
}

func init() {
	log.Println("Running Auto Migration for Tokens Model")
	_ = DB.AutoMigrate(&Tokens{})
}
