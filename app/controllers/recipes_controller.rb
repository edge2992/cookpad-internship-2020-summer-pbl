class RecipesController < ApplicationController
    def new
        #TODO:: zoomのuuidがないときはnewページに遷移しないように設定する
        before = Rails.application.routes.recognize_path(request.referer)
        if before[:uuid].blank?
            redirect_to "/zooms/new"
        end
        @uuid = before[:uuid]
        @recipe_form = RecipeCreateForm.new
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
            Recipe.transaction do
                @recipe.save!
                @zoom = ZoomSchedule.find_by!(uuid: params[:recipe][:uuid])
                @recipe.zoom_schedules = [@zoom]
                ref = @recipe.zoom_recipes.where(zoom_schedule_id: @zoom.id).first
                ref.frequency = 0
                ref.save!
            end
            redirect_to "/zoom/list/#{@zoom.uuid}", notice: 'Recipe was successfully created.'
        else
            #TODO: uuid情報消えているのでよくない
            render :new
        end
    end

    def increment
        unless params[:recipe].blank?
            for buf in params.require(:recipe)[:increments] do
                zoom = ZoomSchedule.find_by!(uuid: params[:uuid])
                recipe = Recipe.find!(buf)
                ref = recipe.zoom_recipes.where!(zoom_schedule_id: zoom.id).first
                ref.frequency += 1
                recipe.frequency += 1
                recipe.save!
                ref.save!
            end
        end
        redirect_back(fallback_location: new_zoom)
    end

    def index
        @recipes = Recipe.all.order(frequency: "DESC")
    end

    private
    def recipe_form_params
        params.require(:recipe).permit(:title, :url)
    end

end
