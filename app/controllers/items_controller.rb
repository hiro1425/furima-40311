class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def items_params
    params.require(:item).permit(:image, :items_name, :explain, :category_id, :situation_id, :delivery_charge_id, :area_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
