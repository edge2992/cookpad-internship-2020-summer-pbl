RAND_GET_NUMBER = 3

class ZoomsController < ApplicationController

    def index
        @zooms = ZoomSchedule.all
    end

    def new
    end

    def share
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid]) 
    end

    def list
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid])
        @zoom_url = URI.extract(@zoom.text, %w[http https]).first
        @recipes = @zoom.recipes.order(frequency: "DESC")
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
            redirect_to new_zoom_url
            return
        end
        redirect_to "/zoom/share/#{@zoom.uuid}"
        #redirect_to  "/zoom/list/#{@zoom.uuid}"
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end
end
