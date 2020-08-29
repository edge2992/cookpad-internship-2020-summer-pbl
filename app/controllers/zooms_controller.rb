RAND_GET_NUMBER = 3

BEST_SCORE = 10
SECOND_SCORE = 5
THIRD_SCORE = 3
FORTH_SCORE = 2
WORST_SCORE = 1

class ZoomsController < ApplicationController

    def index
        @zooms = ZoomSchedule.all
    end

    def new
    end

    def share
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid]) 
        unless @zoom
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        end
    end

    def list
        session[:uuid] = params[:uuid]
        @recipe_form = RecipeCreateForm.new
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid])
        if @zoom
            @zoom_url = URI.extract(@zoom.text, %w[http https]).first
            @recipes = @zoom.recipes.order(frequency: "DESC")
        else
            redirect_to "/zooms/new", alert: "セッティングされた飲み会が無効です"
        end
    end


    def create
        #TODO:: 全部取得してるからヤバそうだが
        @zoom = ZoomSchedule.new(zoom_params.merge(uuid: Digest::SHA1.hexdigest(Time.now.to_s)))
        
        if @zoom.valid?
            @zoom.save
            recipes = Recipe.order("RANDOM()").limit(RAND_GET_NUMBER)
            ZoomRecipe.transaction do
                @zoom.recipes = recipes
            end
        else
            redirect_to new_zoom_url, alert: "Zoomセッテイングに失敗しました"
            return
        end
        redirect_to "/zooms/share/#{@zoom.uuid}"
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end


    def recipe_rank(recipe)
        if recipe
            case recipe.frequency
            when 0..WORST_SCORE
                "-"
            when WORST_SCORE+1..FORTH_SCORE
                "★"*1 
            when FORTH_SCORE+1..THIRD_SCORE
                "★"*2
            when THIRD_SCORE+1..SECOND_SCORE
                "★"*3 
            when SECOND_SCORE+1..BEST_SCORE
                "★"*4 
            else
                "★"*5
            end
        end
    end

    helper_method :recipe_rank
end
