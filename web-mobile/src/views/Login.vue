<template>
  <ion-page>
    <form @submit.prevent="handleLogin">
      <ion-card div="centerLogin pa-4" style="max-width: 500px; margin-right: auto; margin-left: auto">

        <ion-grid>

          <ion-row>
            <ion-col>
              <ion-list style="text-align:center">
                SELF CORONA LOGIN
              </ion-list>
            </ion-col>
          </ion-row>


          <ion-row>
            <ion-col>
              <ion-item>
                <ion-label position="floating"><h2>Login</h2></ion-label>
                <ion-input type="email" placeholder="votre email" required v-model="form.email"></ion-input>
              </ion-item>
            </ion-col>
          </ion-row>


          <ion-row>
            <ion-col>
              <ion-item>
                <ion-label position="floating"><h2>Mot de passe</h2></ion-label>
                <ion-input type="password" placeholder="votre mot de passe" required
                           v-model="form.password"></ion-input>
              </ion-item>
            </ion-col>
          </ion-row>
          <ion-row>
            <ion-col>
              <ion-item lines="none">
                <ion-button href="#" slot="end" fill="clear">Mot de passe oublié ?</ion-button>
              </ion-item>
            </ion-col>
          </ion-row>

          <ion-row>
            <ion-col>
              <ion-list style="text-align:center">
                <ion-button size="default" color="tertiary" type="submit" shape="round" text-center @click="login">
                  Connexion
                </ion-button>
              </ion-list>
            </ion-col>
          </ion-row>

        </ion-grid>

      </ion-card>
    </form>
  </ion-page>
</template>

<script lang="ts">
import {IonPage, IonCard, IonItem, IonLabel, IonButton, IonInput, alertController, IonIcon} from '@ionic/vue'
import {logIn, personAdd} from 'ionicons/icons';
import {mapActions, mapGetters} from "vuex"
import {useRouter} from 'vue-router';
import {
  UserService
} from "@/services/user_service.ts";

export default {
  name: "Login",
  components: {IonPage, IonCard, IonItem, IonLabel, IonButton, IonInput},
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
      form: {
        email: "hiro@test.com",
        password: "password"
      }
    };
  },
  computed: {
    ...mapGetters("auth", [
      "authenticating",
      "authenticationError",
      "authenticationErrorCode"
    ])
  },
  methods: {
    login() {
      UserService.login("", "");
    },
  }
}
</script>

<style scoped>

</style>
