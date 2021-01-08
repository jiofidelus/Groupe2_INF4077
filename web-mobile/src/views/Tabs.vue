<template>
  <ion-page>
    <ion-tabs>
      <ion-tab-bar slot="bottom">
        <ion-tab-button tab="tab5" href="/tabs/patients/new">
          <ion-icon :icon="add"></ion-icon>
          <ion-label>Ajouter</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="tab1" href="/tabs/stats">
          <ion-icon :icon="statsChartOutline"></ion-icon>
          <ion-label>Statistique</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="tab2" href="/tabs/home">
          <ion-icon :icon="homeOutline" />
          <ion-label>Home</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="tab3" href="/tabs/checker">
          <ion-icon :icon="medkitOutline"></ion-icon>
          <ion-label>Consultation</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="tab4" href="/tabs/patients">
          <ion-icon :icon="person"></ion-icon>
          <ion-label>Patients</ion-label>
        </ion-tab-button>
      </ion-tab-bar>
    </ion-tabs>
  </ion-page>
</template>

<script lang="ts">
import { IonTabBar, IonTabButton, IonTabs, IonLabel, IonIcon, IonPage } from '@ionic/vue';
import { ellipse, square, triangle, medkitOutline, statsChartOutline, homeOutline, add, person } from 'ionicons/icons';

export default {
  name: 'Tabs',
  components: { IonLabel, IonTabs, IonTabBar, IonTabButton, IonIcon, IonPage },
  setup() {
    return {
      ellipse,
      square,
      triangle,
     medkitOutline,
      statsChartOutline,
      homeOutline,
      add,
      person

    }
  }
}
</script>
