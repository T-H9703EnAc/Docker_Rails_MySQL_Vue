########## Vue Routerの追加 ##########

(1) vueのコンテナ(front)に入る 
```:実行コマンド
docker exec -it front /bin/bash
```

(2) Vue Router のインストール
```:実行コマンド
npm install vue-router@4

added 2 packages, and audited 941 packages in 21s

1 package is looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

(3)./front/vue_project/vue.config.js の修正 (EsLintの対策)
```:vue.config.js
const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
})
```

(4) ./front/vue_project/src/router/router.js の追加 (フォルダ構成やファイル名は任意でOK)(中身は後ほど作成)
```:実行コマンド
mkdir ./src/router
touch ./src/router/router.js
```

(5) src/main.jsの修正
```:修正前
import { createApp } from 'vue'
import App from './App.vue'

createApp(App).mount('#app')
```

```:修正後
import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router.js'

createApp(App).use(router).mount('#app')
```

(6)動作確認用の画面を作成(Home.vue と Hello.vue)
```:実行コマンド
mkdir ./src/pages
touch ./src/pages/Home.vue
mkdir ./src/pages/hello
touch ./src/pages/hello/Hello.vue
```

```:Home.vue
<template>
    <h1>Home</h1>
</template>
```
```:Hello.vue
<template>
    <h1>Hello</h1>
</template>
```

(7) ./front/vue_project/src/router/router.js の修正
```:router.js
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Hello from '../pages/hello/Hello.vue'

const routes = [
    { 
        path: '/', 
        name: 'Home',
        component: Home
    },
    { 
        path: '/hello', 
        name: 'Hello',
        component: Hello
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
```

(8) ./front/vue_project/src/App.vue の修正
```:App.vue
<template>
  <router-view></router-view>
</template>
```
(9) Vue Routerの動作確認
```:実行コマンド
npm run serve
http://localhost:8080/
http://localhost:8080/hello
```

########## Vue Routerここまで ##########
