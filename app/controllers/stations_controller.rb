class StationsController < ApplicationController
	before_action :set_station, only: [:show, :edit, :update, :destroy]

	def index
		@stations = current_city.stations
	end

	def show
	end

	def new
		@station = Station.new
		@station.build_address
	end

	def edit
	end

	def create
		@station = Station.new(station_params.merge(city: current_city))

		respond_to do |format|
			if @station.save
				format.html{ redirect_to @station, notice: 'Station was successfully created.' }
				format.json{ render :show, status: :created, location: @station }
			else
				format.html{ render :nem }
				format.json{ render json: @station.errors, status: :unprocessable_entity}
			end
		end
	end

	def update
		respond_to do |format|
	      if @station.update(station_params)
	        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
	        format.json { render :show, status: :ok, location: @station }
	      else
	        format.html { render :edit }
	        format.json { render json: @station.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
	    @station.destroy
	    respond_to do |format|
	      format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	end

	private

		def set_station
			@station = Station.find(params[:id])
		end

		def  station_params
			ret = params.require(:station).permit(:name, address_attributes: [:id, :address, :comment, :lat, :lng])
	        ret[:address_attributes].delete(:address) if ret[:address_attributes][:address].blank?
	        ret
		end
	end