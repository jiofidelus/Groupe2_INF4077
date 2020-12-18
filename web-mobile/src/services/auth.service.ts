import ApiService from "./api.service";
import { TokenService } from "./token.service";
import { AxiosRequestConfig } from "axios";
import qs from "qs";

class AuthenticationError extends Error {
  errorCode: any;
  constructor(errorCode: any, message: string | undefined) {
    super(message);
    this.name = this.constructor.name;
    if (message != null) {
      this.message = message;
    }
    this.errorCode = errorCode;
  }
}

const AuthService = {
  signIn: async function(signInData: any) {
    const requestData: AxiosRequestConfig = {
      method: "post",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        //Authorization: 'Basic ' + btoa(process.env.VUE_APP_CLIENT_ID + ':' + process.env.VUE_APP_CLIENT_SECRET)
      },
      url: "/auth/login",
      data: qs.stringify({
        "grant_type": "password",
        email: signInData.email,
        password: signInData.password
      })
    };

    try {
      const response = await ApiService.customRequest(requestData);
      TokenService.saveToken(response.data.token);
      TokenService.saveUser(JSON.stringify(response.data.user));
      ApiService.setHeader();

      ApiService.mount401Interceptor();

      return response.data.access_token;
    } catch (error) {
      this.catchError(error);
    }
  },

  catchError: function(error: any) {
    let status;
    let description;

    if (error.response === undefined) {
      status = error.message;
      description = error.message;
    } else {
      status = error.response.status;
      description = error.response.data.error_description;
    }

    throw new AuthenticationError(status, description);
  }
}


export {AuthService, AuthenticationError}
