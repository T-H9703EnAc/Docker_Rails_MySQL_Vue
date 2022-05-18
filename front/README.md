########## Vue Routerの追加 ##########

(1) vueのコンテナ(front)に入る 
```:実行コマンド
(実行コマンド)

docker exec -it front /bin/bash
```

(2) Vue Router のインストール
```:実行コマンド
(実行コマンド)

npm install vue-router@4

added 2 packages, and audited 941 packages in 21s

1 package is looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

(3)./front/vue_project/vue.config.js の修正 (EsLintの対策)
```:vue.config.js
(vue.config.js)

const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
})
```

(4) ./front/vue_project/src/router/router.js の追加 (フォルダ構成やファイル名は任意でOK)(中身は後ほど作成)
```:実行コマンド
(実行コマンド)

mkdir ./src/router
touch ./src/router/router.js
```

(5) src/main.jsの修正
```:修正前
(修正前 main.js)

import { createApp } from 'vue'
import App from './App.vue'

createApp(App).mount('#app')
```

```:修正後
(修正後 main.js)

import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router.js'

createApp(App).use(router).mount('#app')
```

(6)動作確認用の画面を作成(Home.vue と Hello.vue)
```:実行コマンド
(実行コマンド)

mkdir ./src/pages
touch ./src/pages/Home.vue
mkdir ./src/pages/hello
touch ./src/pages/hello/Hello.vue
```

```:Home.vue
(Home.vue)

<template>
    <h1>Home</h1>
</template>
```
```:Hello.vue
(Hello.vue)

<template>
    <h1>Hello</h1>
</template>
```

(7) ./front/vue_project/src/router/router.js の修正
```:router.js
(router.js)

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
(App.vue)

<template>
  <router-view></router-view>
</template>
```
(9) Vue Routerの動作確認
```:実行コマンド
(実行コマンド)

npm run serve
http://localhost:8080/
http://localhost:8080/hello
```

########## Vue Routerここまで ##########

********** BootStrap5の追加 **********
(1) BootStrap5のインストール
```:実行コマンド
(実行コマンド)

npm install vue bootstrap-vue bootstrap

npm WARN deprecated popper.js@1.16.1: You can find the new Popper v2 at @popperjs/core, this package is dedicated to the legacy v1

added 17 packages, and audited 958 packages in 2m

7 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

```

(2)./front/vue_project/vue.config.js の修正 (警告メッセージの対策)
```:修正前
(修正前vue.config.js)

const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
})
```
```:修正後
(修正後vue.config.js)

const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
  configureWebpack: {
    devtool: 'source-map',
  },
})
```


(3) src/main.js の修正
```:修正前
(修正前 main.js)

import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router.js'

createApp(App).use(router).mount('#app')
```

```:修正後
import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router.js'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap/dist/js/bootstrap.js"

createApp(App).use(router).mount('#app')
```

(4) 動作確認用の画面を作成(Header.vue)
```:実行コマンド
(実行コマンド)

touch ./src/components/Header.vue
```

```:Header.vue
(Header.vue)

<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
            <a class="nav-link active" aria-current="page" href="/">Home</a>
            <a class="nav-link" href="/hello">hello</a>
            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </div>
        </div>
    </div>
    </nav>
</template>
```

(5) ./front/vue_project/src/App.vue の修正
```:App.vue
(App.vue)

<template>
    <div id="app">
      <Header/>
      <router-view name="Header"></router-view>
      <router-view></router-view>
    </div>
</template>

<script>
  import Header from './components/Header'
  export default {
    name: 'App',
    components: {
      Header
    }
  }
</script>
```


(6) BootStrap5の動作確認
```:実行コマンド
(実行コマンド)

npm run serve
http://localhost:8080/
http://localhost:8080/hello
```

(※7)以下の警告メッセージが出た場合
```:警告メッセージ
 (警告メッセージ)

 WARNING  Compiled with 1 warning                                                                                                 5:52:56 PM

 warning  in ./node_modules/bootstrap/dist/css/bootstrap.min.css

Module Warning (from ./node_modules/postcss-loader/dist/cjs.js):
Warning

(6:29521) autoprefixer: Replace color-adjust to print-color-adjust. The color-adjust shorthand is currently deprecated.
```
```:実行コマンド
(実行コマンド)

npm install autoprefixer@10.4.5 --save-exact

changed 1 package, and audited 958 packages in 14s

8 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

npm run serve
http://localhost:8080/
http://localhost:8080/hello
```

********** BootStrap5ここまで **********

////////// axiosの追加 //////////
(1) axiosのインストール
```:実行コマンド
(実行コマンド)

npm install axios

added 5 packages, changed 373 packages, and audited 963 packages in 6m

8 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```
(2) 動作確認用の画面を作成(Search.vue)
```:実行コマンド
(実行コマンド)

mkdir ./src/pages/search
touch ./src/pages/search/Search.vue
```

```:Search.vue
(Search.vue)
<template>
    <div>
        <button @click="search" type="button" class="btn btn-primary">検索</button>
        <table class="table">
            <thead>
                <tr>
                <th scope="col">ID</th>
                <th scope="col">ユーザ名</th>
                </tr>
            </thead>
            <tbody>   
                <tr  v-for="item in items" :key="item.message">
                    <th scope="row">{{item.id}}</th>
                    <td>{{item.name}}</td>
                </tr>   
            </tbody>
        </table>
    </div>
</template>
<script>
    import axios from 'axios';
    export default {
        data(){
            return{
                items: []
            }
        },
        methods: {
            search (){
                axios
                .get('http://localhost:8080/search')
                .then(
                    response => {
                        for (let i=0; i<response.data.length; i++) {
                            this.items.push(response.data[i]);
                        }
                        console.log(this.items);
                    } 
                ).catch(
                    error => {
                        let errorData1 = {id: 2, name: "Jirou"};
                        let errorData2 = {id: 3, name: "Saburou"};
                        this.items.push(errorData1);
                        this.items.push(errorData2);
                    }
                );
            }
        }
    }
</script>

```
(3)  ./front/vue_project/src/router/router.js の修正
```:router.js
(修正前 router.js)

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

```:router.js
(修正後 router.js)

import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Hello from '../pages/hello/Hello.vue'
import Search from '../pages/search/Search.vue'

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
    },
    {
        path: '/search', 
        name: 'Search',
        component: Search
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
```

(4) ./front/vue_project/src/components/Header.vue の修正
```:Header.vue
(修正前 Header.vue)

<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
            <a class="nav-link active" aria-current="page" href="/">Home</a>
            <a class="nav-link" href="/hello">hello</a>
            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </div>
        </div>
    </div>
    </nav>
</template>
```

```:Header.vue
(修正後 Header.vue)

<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
            <a class="nav-link active" aria-current="page" href="/">Home</a>
            <a class="nav-link" href="/hello">hello</a>
            <a class="nav-link" href="/search">search</a>
            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </div>
        </div>
    </div>
    </nav>
</template>
```


(5) axiosの動作確認
```:実行コマンド
(実行コマンド)

npm run serve
http://localhost:8080/
http://localhost:8080/search
```