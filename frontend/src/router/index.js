import Vue from 'vue'
import Router from 'vue-router'

import showFur from "../views/showFur"
import showCus from "../views/showCus"
import inBound from "../views/inBound"
import outBound from "../views/outBound"

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'showFur',
      component: showFur
    },
    {
      path: '/showCus',
      component: showCus
    },
    {
      path: '/ib',
      component: inBound
    },
    {
      path: '/ob',
      component: outBound
    }
  ]
})