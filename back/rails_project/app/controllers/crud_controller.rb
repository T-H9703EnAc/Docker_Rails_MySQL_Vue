class CrudController < ApplicationController
  def search
    # user = [{id: 1, name: "Tarou"}, {id: 4, name: "Sirou"}]
    user = User.all
    render json: user
  end
end
