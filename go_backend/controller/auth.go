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
	"time"
)

type controllerOptions struct {
	email    string
	password string
	token    string
}

func init() {
	log.Println("Auth Controller init()")
	booksAPI := app.App.Party("/auth")

	booksAPI.Use(middleware.Logger())

	protected := booksAPI.Party("/")
	protected.Use(middleware.AuthRequired())

	booksAPI.Post("/login", login)
	booksAPI.Post("/register", register)
	booksAPI.Post("/logout", middleware.AuthRequired(), logout)
	booksAPI.Post("/user", middleware.AuthRequired(), getUser)

}

func login(ctx iris.Context) {
	email := ctx.PostValue("email")
	password := ctx.PostValue("password")
	var user User
	result := configs.DB.Where(&User{Email: email, Password: password}).First(&user)

	if result.Error != nil && errors.Is(result.Error, gorm.ErrRecordNotFound) {
		ctx.StopWithJSON(http.StatusUnauthorized, ErrorModel{
			Error:      "Wrong credential",
			Suggestion: "Verify email and password then try again",
		})
	}

	token := Tokens{
		Token:  "0x0x0x0x0x1234",
		User:   user,
		UserID: user.ID,
	}

	configs.DB.Create(&token)

	ctx.StopWithJSON(200, token)
}

func register(ctx iris.Context) {
	var user User
	ctx.ReadBody(&user)

	result := configs.DB.Create(&user)

	if result.Error != nil {
		ctx.StopWithJSON(500, ErrorModel{
			Error:      "Could not save user : " + result.Error.Error(),
			Suggestion: "Please contact the site admin",
		})
		return
	}

	ctx.StopWithJSON(200, user)
}

func logout(ctx iris.Context) {

}

func getUser(ctx iris.Context) {
	ctx.StopWithJSON(http.StatusOK, ctx.User())
}

func authDependency(ctx iris.Context) controllerOptions {
	var options controllerOptions

	options.email = ctx.PostValue("email")
	options.password = ctx.PostValue("password")

	return options
}

func protectedDependency(ctx iris.Context) controllerOptions {
	var options controllerOptions

	options.token = ctx.Values().GetStringTrim("token")

	log.Println("Hello there")

	return options
}

type AuthController struct {
	options controllerOptions
	ctx     iris.Context
}

type ProtectedController struct {
	options controllerOptions
	ctx     iris.Context
}

func (c *ProtectedController) Get() User {
	return User{
		ID:        0,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
		Name:      "Test",
		Email:     "Test",
		Password:  "Test",
	}
}

// POST: http://localhost:8080/books
func (c *AuthController) PostLogin(b Book) int {
	log.Println("Options ")
	log.Println(c.options)

	log.Println(c.ctx)
	return iris.StatusCreated
}

func (c *AuthController) PostLogout() int {
	return iris.StatusUnauthorized
}

func (c *AuthController) PostRegister() int {
	return iris.StatusUnauthorized
}
