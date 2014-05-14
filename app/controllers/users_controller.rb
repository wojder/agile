class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    params[:action] = :edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url,
          notice: "User #{@user.name} was successfully created." }
        format.json { render json: @user,
          status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
def update
  @user = User.find(params[:id])    
  if @user.authenticate(params[:user])    
    params[:user].delete :current_password      
    respond_to do |format|      
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end      
  else
    redirect_to edit_user_path(@user), notice: 'Current password is incorrect'
  end      
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def user_params
    allow = [:name, :password, :password_confirmation]
    params.require(:user).permit(allow)
  end

end