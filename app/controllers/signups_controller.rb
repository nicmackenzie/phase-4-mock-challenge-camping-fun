class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_error

    def create
        signup = Signup.create!(signup_params)
        activity = Activity.find(signup.activity_id)
        render json: activity,except: ['created_at','updated_at'], status: :created
    end

    private

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end

    def render_unprocessable_entity_error(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end
end
