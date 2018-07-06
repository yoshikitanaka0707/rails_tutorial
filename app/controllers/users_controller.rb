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
    @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    if @user.save
      # 保存の成功をここで扱う。
    else
      render 'new'
    end
  end

end
