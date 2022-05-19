########## RailsとVuwの連携 ##########
(1) Controllerの作成
```:実行コマンド
(実行コマンド)

docker-compose run back rails g controller crud search
Creating docker_rails_mysql_vue_back_run ... done
Running via Spring preloader in process 21
      create  app/controllers/crud_controller.rb
       route  get 'crud/search'
      invoke  test_unit
      create    test/controllers/crud_controller_test.rb
```

(2) ./back/rails_project/app/controllers/crud_controller.rb の実装
```:crud_controller.rb
(修正後 crud_controller.rb)

class CrudController < ApplicationController
  def search
    user = [{id: 1, name: "Tarou"}, {id: 4, name: "Sirou"}]
    render json: user
  end
end
```

```:crud_controller.rb
(修正後 crud_controller.rb)

class CrudController < ApplicationController
  def search
    user = [{id: 1, name: "Tarou"}, {id: 4, name: "Sirou"}]
    render json: user
  end
end
```

(3) ./back/rails_project/config/routes.rb の確認
```:routes.rb
(routes.rb)

Rails.application.routes.draw do
  get 'crud/search'
end
```

(4) 動作確認
```:実行コマンド
(実行コマンド)

#コンテナを起動していない場合は
docker-compose up -d

#vueのコンテナに入っていない場合は
docker exec -it front /bin/bash

npm run serve

http://localhost:8080/search
```

########## RailsとVuwの連携 ここまで ##########

********** RailsとMySQLの連携 **********

(1) Modelの作成
```:実行コマンド
(実行コマンド)

docker-compose run back rails g model Users name:string

Creating docker_rails_mysql_vue_back_run ... done
Running via Spring preloader in process 20
[WARNING] The model name 'Users' was recognized as a plural, using the singular 'User' instead. Override with --force-plural or setup custom inflection rules for this noun before running the generator.
      invoke  active_record
      create    db/migrate/20220519152716_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```

(2) マイグレーションファイルの確認
```:???_create_users.rb
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

(3) マイグレーションの実行
```:実行コマンド
(実行コマンド)

docker-compose run back rails db:migrate

Creating docker_rails_mysql_vue_back_run ... done
Running via Spring preloader in process 19
== 20220519152716 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.3420s
== 20220519152716 CreateUsers: migrated (0.3430s) =============================
```

(4) ./back/rails_project/app/controllers/crud_controller.rb の修正
```:crud_controller.rb
(修正前 crud_controller.rb)

class CrudController < ApplicationController
  def search
    user = [{id: 1, name: "Tarou"}, {id: 4, name: "Sirou"}]
    render json: user
  end
end
```

```:crud_controller.rb
(修正後 crud_controller.rb)

class CrudController < ApplicationController
  def search
    user = User.all
    render json: user
  end
end
```

(5) データの投入
./back/rails_project/db/seeds.rb で追加

```:seeds.rb 
User.create(
    name: "Tarou"
)

User.create(
    name: "Jirou"
)

User.create(
    name: "Saburou"
)
```

```:実行コマンド
(実行コマンド)

docker-compose run back rails db:seed

Creating docker_rails_mysql_vue_back_run ... done
Running via Spring preloader in process 19
```