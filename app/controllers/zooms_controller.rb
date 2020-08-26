RAND_GET_NUMBER = 3

class ZoomsController < ApplicationController

    def index
        @zooms = ZoomSchedule.all
    end

    def new
    end

    def show
        #TODO:: urlをhash値に変更する
    #    @zoom = ZoomSchedule.find_by(uuid: params[:id])
        @zoom = ZoomSchedule.find(params[:id])
        @recipes = @zoom.recipes
    end

    def create
        #TODO:: 全部取得してるからヤバそうだが
        @recipes = Recipe.order("RANDOM()").limit(RAND_GET_NUMBER)
        @zoom = ZoomSchedule.new(zoom_params)
        @zoom.uuid = Digest::SHA1.hexdigest(Time.now.to_s)
        @zoom.save  
        @zoom.recipes = @recipes
        redirect_to zoom_path(@zoom)
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end
end
