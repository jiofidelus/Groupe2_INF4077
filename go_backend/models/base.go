package models

import (
	"gorm.io/gorm"
	"time"
)

type baseModel struct {
	ID        uint           `gorm:"primaryKey unique autoIncrement" json:"id"`
	CreatedAt time.Time      `json:"created_at"`
	UpdatedAt time.Time      `json:"updated_at"`
	DeletedAt gorm.DeletedAt `gorm:"index" json:"deleted_at"`
}
