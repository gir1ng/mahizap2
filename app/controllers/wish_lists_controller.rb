class WishListsController < ApplicationController
  def index
    @wish_lists = current_user.wish_lists
  end

  def new
    @wish_list = WishList.new
  end

  def create
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      flash[:success] = "やりたいことリストを追加しました"
      redirect_to new_wish_list_url
    else
      render "new"
    end
  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:wish_content)
  end
end
