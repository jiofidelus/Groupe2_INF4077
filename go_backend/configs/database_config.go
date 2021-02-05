package configs

import (
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"log"
)

var DB *gorm.DB

func init() {
	log.Println("Database config init()")
	var err error
	DB, err = gorm.Open(sqlite.Open("databse.BD"), &gorm.Config{})

	if err != nil {
		panic("Failed to connect to database")
	}

	log.Println("Database successfully init")
	log.Println("Migration should now be running ...")
}
