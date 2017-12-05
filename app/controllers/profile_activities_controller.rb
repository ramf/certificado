class ProfileActivitiesController < ApplicationController
    before_action :set_profile_activity, only: [:show, :edit, :update, :destroy]

    def index
        authorize ProfileActivity
        @q = ProfileActivity.ransack(params[:q])
        @profile_activities = @q.result.page(params[:page])
    end

    def show
    end

    def new
        @profile_activity = ProfileActivity.new
        authorize @profile_activity
    end

    def edit
    end

    def create
        @profile_activity = ProfileActivity.new(profile_activity_params)
        authorize @profile_activity
        respond_to do |format|
            if @profile_activity.save
                show_profile_activity
                flash[:notice] = "Registro inserido com sucesso!"
                format.html { render :index }
                #format.html { redirect_to @app_profile_activity, notice: 'App profile activity was successfully created.' }
                format.json { render :show, status: :created, location: @profile_activity }
            else
                format.html { render :new }
                format.json { render json: @profile_activity.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @profile_activity.update(profile_activity_params)
                show_profile_activity
                flash[:notice] = "Registro atualizado com sucesso!"
                format.html { render :index }

                #format.html { redirect_to @app_profile_activity, notice: 'App profile activity was successfully updated.' }
                format.json { render :show, status: :ok, location: @profile_activity }
            else
                format.html { render :edit }
                format.json { render json: @profile_activity.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @profile_activity.destroy
        respond_to do |format|
            format.html { redirect_to profile_activities_url, notice: 'Registro deletado com sucesso!'}
            format.json { head :no_content }
        end
    end

    private
        def show_profile_activity
            @q = ProfileActivity.ransack(id_eq: @profile_activity.id)
            @profile_activities= @q.result.page(params[:page])
        end
        # Use callbacks to share common setup or constraints between actions.
        def set_profile_activity
            @profile_activity = ProfileActivity.find(params[:id])
            authorize @profile_activity
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def profile_activity_params
            params.require(:profile_activity).permit(:profile_id, :activity_id)
        end
end
