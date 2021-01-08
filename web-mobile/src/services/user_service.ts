import {users} from "@/assets/mocks/users.ts"

export interface UserI {
    id: number;
    name: string;
    picture: string;
    email: string;
}

export class UserService {
    static users: UserI[] = users;

    // Login with email and password
    static login(email: string, password: string): UserI {
        return this.users.find(e => e.email === email);
    }
}
