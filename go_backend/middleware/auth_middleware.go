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

type tokenHeader struct {
	Token string `header:"Authorization,required"`
}

func AuthRequired() iris.Handler {
	return func(ctx iris.Context) {

		var authHeader tokenHeader

		// Trying to get headers
		if err := ctx.ReadHeaders(&authHeader); err != nil {
			ctx.StopWithJSON(http.StatusUnauthorized, iris.Map{"error": err.Error(), "suggestion": "We could not find Authorization as part of your headers, Please add it with your token"})
			return
		}

		// Checking the token in the database
		token := strings.TrimSpace(strings.Split(authHeader.Token, "Bearer")[1])
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
