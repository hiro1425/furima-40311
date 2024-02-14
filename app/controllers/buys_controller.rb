class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :redirect_if_author_or_sold, only: [:index, :create]
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @buy_address = BuyAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      pay_item
      @buy_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:buy_address).permit(:postal_code, :area_id, :city, :address, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item[:price],
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_author_or_sold
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id || @item.buy.present?
      redirect_to root_path
    end
  end
end
