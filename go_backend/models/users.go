package models

import (
	. "backend/configs"
	"gorm.io/gorm"
	"log"
	"time"
)

type User struct {
	ID        uint           `gorm:"primaryKey unique autoIncrement" json:"id"`
	CreatedAt time.Time      `json:"created_at"`
	UpdatedAt time.Time      `json:"updated_at"`
	DeletedAt gorm.DeletedAt `gorm:"index" json:"deleted_at"`
	Name      string         `json:"name"`
	Email     string         `json:"email" gorm:"unique"`
	Password  string         `json:"password"`
}

func (u User) GetRaw() (interface{}, error) {
	return u, nil
}

func (u User) GetAuthorization() (string, error) {
	return "Nothing to show", nil
}

func (u User) GetAuthorizedAt() (time.Time, error) {
	return time.Now(), nil
}

func (u User) GetID() (string, error) {
	return string(u.ID), nil
}

func (u User) GetUsername() (string, error) {
	return u.Name, nil
}

func (u User) GetPassword() (string, error) {
	return u.Password, nil
}

func (u User) GetEmail() (string, error) {
	return u.Email, nil
}

func (u User) GetRoles() ([]string, error) {
	return []string{}, nil
}

func (u User) GetToken() ([]byte, error) {
	return []byte{}, nil
}

func (u User) GetField(key string) (interface{}, error) {
	return nil, nil
}

func init() {
	log.Println("Running Auto Migration for Users Model")
	_ = DB.AutoMigrate(&User{})

}
