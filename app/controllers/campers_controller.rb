class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_error

    def index
        campers = Camper.all
        render json: campers, except: ['created_at','updated_at'], status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, except: ['created_at','updated_at'], include: :activities, status: :ok
    end

    def create
        camper = Camper.create!(camper_parameters)
        render json: camper, except: ['created_at','updated_at'],status: :created
    end


    private

    def camper_parameters
        params.permit(:name, :age)
    end

    def render_record_not_found
        render json: {error: 'Camper not found'}, status: :not_found
    end

    def render_unprocessable_entity_error(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end
end
