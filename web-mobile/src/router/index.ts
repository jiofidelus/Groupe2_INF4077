import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';
import Tabs from '../views/Tabs.vue'
import Login from '../views/Login.vue'
import Patient from '../views/Patient.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/login/'
  },
  {
    path:'/login/',
    component: Login
  },
  {
    path:'/patients/',
    component: Patient
  },
  {
    path: '/tabs/',
    component: Tabs,
    children: [
      {
        path: '',
        redirect: 'tab1'
      },
      {
        path: 'tab1',
        component: () => import('@/views/Tab1.vue')
      },
      {
        path: 'tab2',
        component: () => import('@/views/Tab2.vue')
      },
      {
        path: 'tab3',
        component: () => import('@/views/Tab3.vue')
      },
      {
        path: 'tab4',
        component: () => import('@/views/Patient.vue')
      },
      {
        path: 'tab5',
        component: () => import('@/views/Nouveau.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
