RAND_GET_NUMBER = 3

class ZoomsController < ApplicationController

    def index
        @zooms = ZoomSchedule.all
    end

    def new
    end

    # def show
    #     #TODO:: urlをhash値に変更する
    # #    @zoom = ZoomSchedule.find_by(uuid: params[:id])
    #     @zoom = ZoomSchedule.find(params[:id])
    #     @recipes = @zoom.recipes.order(frequency: "DESC")
    # end

    def share
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid]) 
    end

    def list
        @zoom = ZoomSchedule.find_by(uuid: params[:uuid])
        @recipes = @zoom.recipes.order(frequency: "DESC")
    end


    def create
        #TODO:: 全部取得してるからヤバそうだが
        @zoom = ZoomSchedule.new(zoom_params)
        ZoomSchedule.transaction do
            recipes = Recipe.order("RANDOM()").limit(RAND_GET_NUMBER)
            @zoom.uuid = Digest::SHA1.hexdigest(Time.now.to_s)
            @zoom.save!
            @zoom.recipes = recipes
        end
        redirect_to "/zoom/share/#{@zoom.uuid}"
        #redirect_to  "/zoom/list/#{@zoom.uuid}"
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end
end
