class UserProfilesController < ApplicationController
    before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

    # GET /app_user_profiles
    # GET /app_user_profiles.json
    def index
      authorize User
      @q = User.ransack(params[:q])
      @user_profiles = @q.result.page(params[:page])
    end

    # GET /app_user_profiles/1
    # GET /app_user_profiles/1.json
    def show
    end

    # GET /app_user_profiles/new
    # def new
    #   @user_profile = UserProfile.new
    #   authorize @user_profile
    # end

    # GET /app_user_profiles/1/edit
    def edit
    end

    # POST /app_user_profiles
    # POST /app_user_profiles.json
    # def create
    #   @user_profile = UserProfile.new(user_profile_params)
    #   authorize @user_profile
    #   respond_to do |format|
    #     if @user_profile.save
    #       set_show_user_profile
    #       flash[:notice] = "Registro inserido com sucesso!"
    #       format.html { render :index }
    #       #format.html { redirect_to @app_user_profile, notice: 'App user profile was successfully created.' }
    #       format.json { render :show, status: :created, location: @user_profile }
    #     else
    #       format.html { render :new }
    #       format.json { render json: @user_profile.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end

    # PATCH/PUT /app_user_profiles/1
    # PATCH/PUT /app_user_profiles/1.json
    def update
      respond_to do |format|
        if @user_profile.update(user_profile_params)
          set_show_user_profile
          flash[:notice] = "Registro atualizado com sucesso!"
          format.html { render :index }
          #format.html { redirect_to @app_user_profile, notice: 'App user profile was successfully updated.' }
          format.json { render :show, status: :ok, location: @user_profile }
        else
          format.html { render :edit }
          format.json { render json: @user_profile.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /app_user_profiles/1
    # DELETE /app_user_profiles/1.json
    def destroy
      @user_profile.destroy
      respond_to do |format|
        format.html { redirect_to user_profiles_url, notice:  "Registro deletado com sucesso!"   }
        format.json { head :no_content }
      end
    end

    private
      def set_show_user_profile
        @q = User.ransack(id_eq: @user_profile.id)
        @user_profiles = @q.result.page(params[:page])
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_user_profile
        @user_profile = User.find(params[:id])
        authorize @user_profile
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_profile_params
        params.require(:user_profile).permit(:profile_id)
      end
end
  
