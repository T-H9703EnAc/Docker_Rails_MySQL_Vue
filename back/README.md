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