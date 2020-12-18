<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Statistiques</ion-title>
        <ion-buttons slot="primary">

        </ion-buttons>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Tab 1</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-title>{{msg}}</ion-title>
      <ExploreContainer name="Tab 1 page" />
    </ion-content>
  </ion-page>
</template>

<script lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonIcon, IonButtons, IonButton } from '@ionic/vue';
import { logOut } from 'ionicons/icons';
import ExploreContainer from '@/components/ExploreContainer.vue';
import {mapActions} from "vuex";
import { useRouter } from 'vue-router';

export default  {
  name: 'Tab1',
  components: { ExploreContainer, IonHeader, IonToolbar, IonTitle, IonContent, IonPage, IonButtons },
  data() {
    return {
      msg: " "
    }
  },
  setup() {
    const router = useRouter();
    return {
      router,
      logOut
    };
  },
  methods: {
    ...mapActions("auth", ["signOut"]),
    ...mapActions("home", ["loadSecretArea"]),
   /* async handleSignOut() {
      await this.signOut().then(() => {
        this.router.push("/login");
      });
    },*/
    async loadHomeData() {
      await this.loadSecretArea().then((res: any) => {
       // this.msg = res.data;
      });
    },
    ionViewWillEnter() {
      this.loadHomeData();
    }
  }
}
</script>
