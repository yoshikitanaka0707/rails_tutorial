class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])#だいたいコントローラでdbから引っ張ってくる。
    # debugger
    #gem byebugによるメソッド書いてrails -sするとそのターミナル上で
    #Railsコンソールのようにコマンドを呼び出すことができる。
  end

  def new
    @user = User.new
    # debugger
  end

  def create
    @user = User.new(user_params)   #strong parametersを使う。
    if @user.save
      # 保存の成功をここで扱う。
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private   #見えないようにできるやつ。

    def user_params   #こいつらだけ書き換えて良いぞ。
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
