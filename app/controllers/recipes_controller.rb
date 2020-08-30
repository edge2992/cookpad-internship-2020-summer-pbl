class RecipesController < ApplicationController
    def new
        before = Rails.application.routes.recognize_path(request.referer)
        if before[:uuid].blank?
            flash.now[:alert] = 'セッティングされた飲み会が無効です'
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        else
            session[:uuid] = before[:uuid]
            @recipe_form = RecipeCreateForm.new
        end
    end

    def poll
        unless params[:uuid].blank?
            zoom = ZoomSchedule.find_by!(uuid: params[:uuid])
            unless params[:id].blank?
                Recipe.find(params[:id]).increment!(:frequency, 1)
                zoom.zoom_recipes.where(recipe_id: params[:id]).first.increment!(:frequency, 1)
                redirect_to "/zooms/list/#{zoom.uuid}", notice: 'みんなとおつまみ作成予定を共有しました'
                return
            else
                redirect_back(fallback_location: new_zoom_url, alert: "投票失敗")
            end
        else
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        end
    end


    def create
        @recipe_form = RecipeCreateForm.new
        @recipe_form.apply(recipe_form_params)

        unless session[:uuid].blank?
            if @recipe_form.valid?
                #TODO: すでにとうろくされているかどうかを確認する
                @recipe = Recipe.find_by(@recipe_form.to_attributes)
                @zoom = ZoomSchedule.find_by(uuid: session[:uuid])

                logger.debug(@recipe)
                if @recipe.blank?
                    #　登録がなかった場合
                    @recipe = Recipe.new(@recipe_form.to_attributes)
                    @recipe.save   
                end
                @recipe.zoom_schedules = [@zoom]
                session[:uuid].clear
                redirect_to "/zooms/list/#{@zoom.uuid}", notice: 'みんなとレシピを共有しました'
            else
                redirect_to "/zooms/list/#{session[:uuid]}", alert: '入力が無効です'
            end
        else
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        end
    end

    def index
        @recipes = Recipe.order(frequency: :desc).paginate(page: params[:page], per_page: 3)
    end

    private
    def recipe_form_params
        params.require(:recipe).permit(:url)
    end

    private
    def get_uuid_from_referer
        before = Rails.application.routes.recognize_path(request.referer)
        if before[:uuid].blank?
            flash.now[:alert] = 'セッティングされた飲み会が無効です'
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        else
            before[:uuid]
        end
    end
end
