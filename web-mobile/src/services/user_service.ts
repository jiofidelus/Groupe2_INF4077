import {users} from "@/assets/mocks/users.ts"



export class UserService {
  static users = users;
  // Login with email and password
  static login(email: string, password: string){
    console.log(this.users)
    console.log(email, password)
    return this.users[1];
  }
}
