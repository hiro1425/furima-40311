class ItemsController < ApplicationController
  def index
  end

  private

  def message_params
    params.require(:item).permit(:image, :items_name, :explain, :category_id, :situation_id, :delivery_charge_id, :area_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
