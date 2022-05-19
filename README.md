(1)最低限のファイルの作成(Dockerfileなど)

(2)Railsプロジェクトの作成
```:実行コマンド
(実行コマンド)

docker-compose run back rails new . --force --database=mysql --api
```
(3)CORSの設定
Gemfile の修正
```:Gemfile
(Gemfile一部抜粋)
...
gem 'rack-cors' #コメントアウト解除
...
```
```:実行コマンド
(実行コマンド)

docker-compose run back bundle install
```

./back/rails_project/config/initializers/cors.rb の修正
```:cors.rb
(cors.rb)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8080'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

(4)./back/rails_project/config/database.yml の修正
```:database.yml
(database.yml)

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: root # 追加
  host: db # 修正
```

(5)イメージ作成
```:実行コマンド
(実行コマンド)
docker-compose build
```
※以下のようなエラーが出た場合は再度buildを実施
```:エラーメッセージ
(エラーメッセージ)

=> ERROR [3/3] RUN npm install -g npm &&     npm install -g @vue/cli                                                                                                                   432.4s
=> ERROR [3/3] RUN npm install -g npm &&     npm install -g @vue/cli                                                                                                                   432.4s
------                                                                                                                                                                                         
 > [3/3] RUN npm install -g npm &&     npm install -g @vue/cli:                                                                                                                                
#6 32.52 /usr/local/bin/npx -> /usr/local/lib/node_modules/npm/bin/npx-cli.js                                                                                                                  
#6 32.53 /usr/local/bin/npm -> /usr/local/lib/node_modules/npm/bin/npm-cli.js                                                                                                                  
#6 32.72 + npm@8.10.0                                                                                                                                                                          
#6 32.72 added 63 packages from 18 contributors, removed 299 packages and updated 138 packages in 28.164s                                                                                      
#6 361.1 npm WARN deprecated source-map-url@0.4.1: See https://github.com/lydell/source-map-url#deprecated
#6 361.5 npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
#6 361.7 npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
#6 368.2 npm WARN deprecated source-map-resolve@0.5.3: See https://github.com/lydell/source-map-resolve#deprecated
#6 385.6 npm WARN deprecated apollo-tracing@0.15.0: The `apollo-tracing` package is no longer part of Apollo Server 3. See https://www.apollographql.com/docs/apollo-server/migration/#tracing for details
#6 386.2 npm WARN deprecated graphql-extensions@0.15.0: The `graphql-extensions` API has been removed from Apollo Server 3. Use the plugin API instead: https://www.apollographql.com/docs/apollo-server/integrations/plugins/
#6 387.7 npm WARN deprecated uuid@3.4.0: Please upgrade  to version 7 or higher.  Older versions may use Math.random() in certain circumstances, which is known to be problematic.  See https://v8.dev/blog/math-random for details.
#6 387.8 npm WARN deprecated apollo-cache-control@0.14.0: The functionality provided by the `apollo-cache-control` package is built in to `apollo-server-core` starting with Apollo Server 3. See https://www.apollographql.com/docs/apollo-server/migration/#cachecontrol for details.
#6 390.4 npm WARN deprecated subscriptions-transport-ws@0.9.19: The `subscriptions-transport-ws` package is no longer maintained. We recommend you use `graphql-ws` instead. For help migrating Apollo software to `graphql-ws`, see https://www.apollographql.com/docs/apollo-server/data/subscriptions/#switching-from-subscriptions-transport-ws    For general help using `graphql-ws`, see https://github.com/enisdenjo/graphql-ws/blob/master/README.md
#6 401.1 npm WARN deprecated graphql-tools@4.0.8: This package has been deprecated and now it only exports makeExecutableSchema.\nAnd it will no longer receive updates.\nWe recommend you to migrate to scoped packages such as @graphql-tools/schema, @graphql-tools/utils and etc.\nCheck out https://www.graphql-tools.com to learn what package you should use instead
#6 431.7 npm ERR! code ERR_SOCKET_TIMEOUT
#6 431.7 npm ERR! network Socket timeout
#6 431.7 npm ERR! network This is a problem related to network connectivity.
#6 431.7 npm ERR! network In most cases you are behind a proxy or have bad network settings.
#6 431.7 npm ERR! network 
#6 431.7 npm ERR! network If you are behind a proxy, please make sure that the
#6 431.7 npm ERR! network 'proxy' config is set properly.  See: 'npm help config'
#6 431.8 
#6 431.8 npm ERR! A complete log of this run can be found in:
#6 431.8 npm ERR!     /root/.npm/_logs/2022-05-16T14_46_49_260Z-debug-0.log
------
executor failed running [/bin/sh -c npm install -g npm &&     npm install -g @vue/cli]: exit code: 1
ERROR: Service 'front' failed to build : Build failed
```

(5) DBの作成
```:実行コマンド
(実行コマンド)

docker-compose run back rails db:create
```
※./back/rails_project/db/mysql_data/... が作成されていない場合は以下のコマンドで再度実行する
```:実行コマンド
(実行コマンド)

docker-compose down
docker-compose up -d
```
※以下のようなエラーが出た場合は、./back/rails_project/config/database.yml の修正に誤りがあるかも・・・

```:エラーメッセージ
(エラーメッセージ)

Creating docker_rails_mysql_vue_back_run ... done
Running via Spring preloader in process 19
Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)
Couldn't create 'app_development' database. Please check your configuration.
rake aborted!
ActiveRecord::ConnectionNotEstablished: Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:45:in `rescue in new_client'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:39:in `new_client'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:23:in `mysql2_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:882:in `public_send'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:882:in `new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:926:in `checkout_new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:905:in `try_to_checkout_new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:866:in `acquire_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:588:in `checkout'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:428:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:1128:in `retrieve_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_handling.rb:327:in `retrieve_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_handling.rb:283:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/mysql_database_tasks.rb:8:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/mysql_database_tasks.rb:21:in `create'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:133:in `create'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:193:in `block in create_current'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:506:in `block (2 levels) in each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:503:in `each'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:503:in `block in each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:502:in `each'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:502:in `each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:193:in `create_current'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/railties/databases.rake:45:in `block (2 levels) in <main>'
/usr/local/bundle/gems/bootsnap-1.11.1/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:39:in `load'
/usr/local/bundle/gems/bootsnap-1.11.1/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:39:in `load'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:10:in `block in fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:8:in `fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:8:in `fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:27:in `fork'
-e:1:in `<main>'

Caused by:
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)
/usr/local/bundle/gems/mysql2-0.5.4/lib/mysql2/client.rb:95:in `connect'
/usr/local/bundle/gems/mysql2-0.5.4/lib/mysql2/client.rb:95:in `initialize'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:40:in `new'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:40:in `new_client'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/mysql2_adapter.rb:23:in `mysql2_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:882:in `public_send'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:882:in `new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:926:in `checkout_new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:905:in `try_to_checkout_new_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:866:in `acquire_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:588:in `checkout'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:428:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_adapters/abstract/connection_pool.rb:1128:in `retrieve_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_handling.rb:327:in `retrieve_connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/connection_handling.rb:283:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/mysql_database_tasks.rb:8:in `connection'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/mysql_database_tasks.rb:21:in `create'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:133:in `create'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:193:in `block in create_current'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:506:in `block (2 levels) in each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:503:in `each'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:503:in `block in each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:502:in `each'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:502:in `each_current_configuration'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/tasks/database_tasks.rb:193:in `create_current'
/usr/local/bundle/gems/activerecord-6.1.6/lib/active_record/railties/databases.rake:45:in `block (2 levels) in <main>'
/usr/local/bundle/gems/bootsnap-1.11.1/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:39:in `load'
/usr/local/bundle/gems/bootsnap-1.11.1/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:39:in `load'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/command_wrapper.rb:40:in `call'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application.rb:217:in `block in serve'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:10:in `block in fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:8:in `fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:8:in `fork'
/usr/local/bundle/gems/activesupport-6.1.6/lib/active_support/fork_tracker.rb:27:in `fork'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application.rb:181:in `serve'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application.rb:144:in `block in run'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application.rb:138:in `loop'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application.rb:138:in `run'
/usr/local/bundle/gems/spring-4.0.0/lib/spring/application/boot.rb:19:in `<top (required)>'
-e:1:in `<main>'
Tasks: TOP => db:create
(See full trace by running task with --trace)
ERROR: 1
```

(6) Railsの動作確認
http://localhost:3000/

(7)Vue.js 環境の作成
```:実行コマンド
(実行コマンド)

docker exec -it front /bin/bash
root@796814ea4e34:/app# 

vue create .
?  Your connection to the default yarn registry seems to be slow.
   Use https://registry.npmmirror.com for faster installation? (Y/n) Y
  
Vue CLI v5.0.4
? Generate project in current directory? (Y/n) Y

Vue CLI v5.0.4
? Please pick a preset: (Use arrow keys)
❯ Default ([Vue 3] babel, eslint) 
  Default ([Vue 2] babel, eslint) 
  Manually select features 

Vue CLI v5.0.4
? Please pick a preset: Default ([Vue 3] babel, eslint)
? Pick the package manager to use when installing dependencies: 
  Use Yarn 
❯ Use NPM 


?  Your connection to the default yarn registry seems to be slow.
   Use https://registry.npmmirror.com for faster installation? Yes


Vue CLI v5.0.4
? Generate project in current directory? Yes


Vue CLI v5.0.4
? Please pick a preset: Default ([Vue 3] babel, eslint)
? Pick the package manager to use when installing dependencies: NPM


Vue CLI v5.0.4
✨  Creating project in /app.
🗃  Initializing git repository...
⚙️  Installing CLI plugins. This might take a while...


added 843 packages in 8m
🚀  Invoking generators...
📦  Installing additional dependencies...


added 95 packages in 1m
⚓  Running completion hooks...

📄  Generating README.md...

🎉  Successfully created project app.
👉  Get started with the following commands:

 $ npm run serve

 WARN  Skipped git commit due to missing username and email in git config, or failed to sign commit.
       You will need to perform the initial commit yourself.
```

(9) Vue.jsの動作確認
http://localhost:8080/ 


#################### 開発時によく使用するコマンド一覧 ####################

・Dockerの起動・停止
```:実行コマンド
(実行コマンド)

docker-compose down
docker-compose up -d
docker system prune -a
```

・Docker使用時のRailsコマンド
```:実行コマンド
(実行コマンド)

#コントローラの作成
docker-compose run back rails g controller コントローラー名 メソッド名1 メソッド名2 ...

#コントローラの削除
docker-compose run back rails d controller コントローラー名

#モデルの作成
docker-compose run back rails g model モデル名 カラム名1:カラムの型 カラム名2:カラムの型 ...

#モデルの削除
docker-compose run back rails d model モデル名

# マイグレーションファイルの実行
docker-compose run back rails db:migrate

#routeの確認
docker-compose run back rails routes

#seed.rbの実行
docker-compose run back rails db:seed
```

・Vueコンテナに入る
```:実行コマンド
(実行コマンド)

docker exec -it front /bin/bash
```