package middleware

import (
	"backend/configs"
	"backend/models"
	"errors"
	"github.com/kataras/iris/v12"
	"gorm.io/gorm"
	"log"
	"net/http"
	"strings"
)

type appHeader struct {
	Token string `header:"Application"`
}

func AppMiddleWare() iris.Handler {
	return func(ctx iris.Context) {

		var appHeader appHeader

		// Trying to get headers
		if err := ctx.ReadHeaders(&appHeader); err != nil {
			ctx.StopWithJSON(http.StatusUnauthorized, iris.Map{"error": err.Error(), "suggestion": "We could not find Application as part of your headers, Please add it with your token"})
			return
		}

		// Checking the token in the database
		token := strings.TrimSpace(strings.Split(appHeader.Token, "Bearer")[1])
		log.Println("User token is :", token)

		var dbToken models.Tokens
		result := configs.DB.Where(&models.Tokens{Token: token}).First(&dbToken)

		if result.Error != nil && errors.Is(result.Error, gorm.ErrRecordNotFound) {
			ctx.StopWithJSON(http.StatusUnauthorized, models.ErrorModel{
				Error:      "Token Expired",
				Suggestion: "Your token has expired or you are not logged in, please login to continue",
			})
			return
		}

		ctx.SetUser(dbToken.User)
		_, _ = ctx.Values().Set("token", token)

		log.Println(dbToken)

		// continue with the request
		ctx.Next()

	}
}
