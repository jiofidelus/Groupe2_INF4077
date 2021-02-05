package models

import (
	"gorm.io/gorm"
	"time"
)

type Patient struct {
	ID        uint           `gorm:"primaryKey unique autoIncrement" json:"id"`
	CreatedAt time.Time      `json:"created_at"`
	UpdatedAt time.Time      `json:"updated_at"`
	DeletedAt gorm.DeletedAt `gorm:"index" json:"deleted_at"`
	Name      string         `json:"name"`
	Phone     string         `json:"phone"`
	Birthday  time.Time      `form:"birthday" time_format:"2006-01-02" time_utc:"1" json:"birthday" url:"birthday" msgpack:"birthday"`
	CityID    int            `json:"city_id"`

	Application   Application `json:"application"`
	ApplicationID string      `json:"application_id"`
}
