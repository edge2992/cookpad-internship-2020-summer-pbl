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
    end

    def create
        @zoom = ZoomSchedule.new(zoom_params)
        @zoom.uuid = Digest::SHA1.hexdigest(Time.now.to_s)
        @zoom.save  
        redirect_to zooms_url
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end
end
