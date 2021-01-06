const TOKEN_KEY = "access_token";
const USER_KEY = "user";

const TokenService = {
  getToken() {
    return localStorage.getItem(TOKEN_KEY);
  },

  saveToken(accessToken: string) {
    localStorage.setItem(TOKEN_KEY, accessToken);
  },

  removeToken() {
    localStorage.removeItem(TOKEN_KEY);
  },

  getUser() {
    return JSON.parse(localStorage.getItem(USER_KEY)!);
  },

  saveUser(refreshToken: string) {
    localStorage.setItem(USER_KEY, refreshToken);
  },

  removeUser() {
    localStorage.removeItem(USER_KEY);
  }
}


export { TokenService };
