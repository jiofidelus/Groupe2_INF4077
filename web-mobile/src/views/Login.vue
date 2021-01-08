<template>
  <ion-page>
    <form @submit.prevent="login" class="flex flex-col items-center max-w-xl px-4 mx-auto mt-4 lg:px-0 py-8" style='font-family: ProximaNova, "Helvetica Neue", Helvetica, Arial, sans-serif;'>
    <p class="text-xl font-bold text-purple-500 uppercase">Login</p>
    <div class="w-full p-8 mt-12 text-black bg-gray-800 rounded-lg">
      <div class="flex flex-col">
        <label class='text-white' for="email">Email</label>
        <input v-model="form.email" type="email" required class="w-full p-2 mt-4" id="email" name="email" placeholder="Email">
      </div>
      <div class="flex flex-col mt-8">
        <label class='text-white' for="password">Password</label>
        <input v-model="form.password" type="password" required class="w-full p-2 mt-4" id="password" name="password" placeholder="Password">
      </div>

      <div class="flex flex-col mt-8">
        <button class="rell-button" type="submit">Login</button>
      </div>



    </div>

    </form>
  </ion-page>
</template>

<script lang="ts">
import {
  IonPage,
  IonCard,
  IonItem,
  IonLabel,
  IonButton,
  IonInput,
  alertController,
  IonIcon,
  IonRow,
  IonCol, IonText
} from '@ionic/vue'
import {logIn, personAdd} from 'ionicons/icons';
import {mapActions, mapGetters} from "vuex"
import {useRouter} from 'vue-router';
import {
  UserService
} from "@/services/user_service.ts";
import router from "@/router";

export default {
  name: "Login",
  components: {IonPage},
  setup() {
    const router = useRouter();
    return {
      router,
      logIn,
      personAdd
    };
  },
  data() {
    return {
      failed: false,
      form: {
        email: "aszymoni0@furl.net",
        password: "password"
      }
    };
  },
  computed: {

  },
  methods: {
    login() {
      this.failed = false;
      const u = UserService.login(this.form.email, this.form.password);
      if(u){
        router.replace('/tabs/home')
        return
      }
      this.failed = true;
    },
  }
}
</script>

<style scoped>

</style>
