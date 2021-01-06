<template>
  <ion-page>
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title size="large">Self Coron</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content  >
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Self Coron</ion-title>
        </ion-toolbar>
      </ion-header>
      <ExploreContainer name="" />
      <section class = "home-container">
        <div class="row icon-row">

          <div class="col">

            <h1 class="text-white text-center">Bienvenue sur</h1>

            <h4 class ="text-white text-center ">Self Corona</h4>
          </div>
        </div>


        <div class="row icon-row">

          <div class="col ">
            <a class="text-white text-center" href="#" onclick="window.open('http://members.000webhost.com/login.php?'); return false;">
              <h5 class ="text-white text-center ">Connecter</h5></a>
          </div>


          <router-link to="/patients/"><ion-button >Nos Patients</ion-button></router-link>
        </div>
      </section>

    </ion-content>
  </ion-page>
</template>



<style scoped>
ion-content {
  --ion-background-color: rgba(10, 10, 10, 0.89);
  background: url('https://image.freepik.com/vecteurs-libre/fond-ecran-illustre-du-concept-coronavirus_23-2148482240.jpg');
  background-position:center;
}

img{
  position:absolute;
  left: 0;
  right: 0;
  margin:0 auto;
  top:50%;
  transform:translateY(-50%);
  height:120pt;
}
col{
  position:absolute;
  left: 0;
  right: 0;
  top:50%;
  transform:translateY(-50%);
  height:10pt;
}
h1,h4{
  margin-top: 10pt;
  text-align: center;
  font-style:bold;
  font-weight: bold;
  font-family: 'Lato-Light';
  color:white;

}
h5 {
  margin-top: 300pt;
  text-align: center;

  font-family: 'Roboto-Light';
}
body {
  background-image: url("https://image.freepik.com/vecteurs-libre/fond-ecran-illustre-du-concept-coronavirus_23-2148482240.jpg'");
}
</style>

<script lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent } from '@ionic/vue';
import ExploreContainer from '@/components/ExploreContainer.vue';
export default  {
  name: 'Tab2',
  components: { ExploreContainer, IonHeader, IonToolbar, IonTitle, IonContent, IonPage }
}
</script>
