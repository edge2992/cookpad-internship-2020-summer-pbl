class ZoomsController < ApplicationController
    def index
        @zooms = ZoomSchedule.all
    end

    def new
    end

    def show
        @zoom = ZoomSchedule.find(params[:id])
    end

    def create
        @zoom = ZoomSchedule.new(zoom_params)
        @zoom.uuid = Digest::SHA1.hexdigest(Time.now.to_s)
        @zoom.save  
        redirect_to zooms_url
    end

    def list
        @zoom = ZoomSchedule.where(uuid: params[:h]).first
    end

    private
    def zoom_params
        params.require(:zoom).permit(:text)
    end
end
