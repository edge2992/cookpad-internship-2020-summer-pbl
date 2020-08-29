class RecipesController < ApplicationController
    def new
        #TODO:: zoomのuuidがないときはnewページに遷移しないように設定する
        before = Rails.application.routes.recognize_path(request.referer)
        if before[:uuid].blank?
            redirect_to "/zooms/new", notice: 'セッティングされた飲み会が無効です'
        end
        @uuid = before[:uuid]
        @recipe_form = RecipeCreateForm.new
    end

    def poll
        unless params[:uuid].blank?
            zoom = ZoomSchedule.find_by!(uuid: params[:uuid])
            unless params[:id].blank?
                Recipe.find(params[:id]).increment!(:frequency, 1)
                zoom.zoom_recipes.where(recipe_id: params[:id]).first.increment!(:frequency, 1)
                redirect_to "/zoom/list/#{zoom.uuid}", notice: 'みんなとおつまみ作成予定を共有しました'
                return
            end
        end
        redirect_back(fallback_location: new_zoom_url)
    end


    def create
        @recipe_form = RecipeCreateForm.new
        @recipe_form.apply(recipe_form_params)

        if params[:recipe][:uuid].blank?
            #TODO: hidden valueでzoom uuidを持っているのは戻るボタンなどに対応できない
            redirect_to "zooms/new", notice: 'created error no zoom page'
        end

        if @recipe_form.valid?
            @recipe = Recipe.new(@recipe_form.to_attributes.merge(frequency: 0))
            #TODO: refも更新しているのでそれも考慮する
            Recipe.transaction do
                @recipe.save!
                @zoom = ZoomSchedule.find_by!(uuid: params[:recipe][:uuid])
                @recipe.zoom_schedules = [@zoom]
            end
            redirect_to "/zoom/list/#{@zoom.uuid}", notice: 'Recipe was successfully created.'
        else
            #TODO: uuid情報消えているのでよくない
            render :new
        end
    end

    def index
        @recipes = Recipe.all.order(frequency: "DESC")
    end

    private
    def recipe_form_params
        params.require(:recipe).permit(:title, :url)
    end
end
