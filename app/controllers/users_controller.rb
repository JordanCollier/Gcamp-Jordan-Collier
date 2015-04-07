class UsersController < SecretsController
  before_action :authenticate, except: [:create]
  before_action :set_collaborators, only: [:index, :show]
  def index
    @users = User.all
    @full
  end

  def show
    @user = User.find(params[:id])
  end

  # def new
  #   @user = User.new
  #   @submit_name = "Create User"
  # end

  def edit
    @user = User.find(params[:id])
    @submit_name = "Update User"
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: 'User was successfully deleted.'
    end
  end

  # def create
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     redirect_to users_path, notice: 'User was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @task = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def set_collaborators
      @collaborators = current_user.projects.flat_map{|project| project.users}
    end

end
