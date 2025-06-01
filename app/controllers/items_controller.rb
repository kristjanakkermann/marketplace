class ItemsController < ApplicationController
  before_action :require_user, except: [ :index, :show ]
  before_action :set_item, only: [ :show, :edit, :update, :destroy ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def index
    @items = Item.includes(:seller, :images)

    # Filter by seller if param is present
    @items = @items.where(seller_id: params[:seller_id]) if params[:seller_id].present?

    # Filter by brand if param is present
    @items = @items.where(brand: params[:brand]) if params[:brand].present?

    # Filter by condition if param is present
    @items = @items.where(condition: params[:condition]) if params[:condition].present?

    # Filter by authentication status if param is present
    @items = @items.where(authentication_status: params[:authentication_status]) if params[:authentication_status].present?

    # Only show available items by default (unless viewing own items)
    @items = @items.available unless params[:seller_id].present? && current_user && params[:seller_id].to_i == current_user.id

    # Cache the brands and conditions for filter dropdowns
    @brands = Rails.cache.fetch("available_brands", expires_in: 1.hour) do
      Item.distinct.pluck(:brand).compact.sort
    end

    @conditions = Rails.cache.fetch("available_conditions", expires_in: 1.hour) do
      Item.distinct.pluck(:condition).compact.sort
    end
  end

  def show
    # Show a specific item
    @related_items = Item.where(brand: @item.brand)
                         .where.not(id: @item.id)
                         .available
                         .limit(4)
  end

  def new
    @item = Item.new
    @item.images.build # Build an empty image for the form
  end

  def create
    @item = Item.new(item_params)
    @item.seller = current_user
    @item.authentication_status = "pending" # Items start as pending authentication

    if @item.save
      process_images if params[:item][:image_files].present?

      flash[:notice] = "Item was successfully listed"
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Edit item form
  end

  def update
    if @item.update(item_params)
      process_images if params[:item][:image_files].present?

      flash[:notice] = "Item was successfully updated"
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.transaction.present?
      flash[:alert] = "Cannot delete an item that has been sold"
      redirect_to @item
    else
      @item.destroy
      flash[:notice] = "Item was successfully deleted"
      redirect_to items_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :title, :description, :brand, :condition,
      :original_price, :listed_price,
      images_attributes: [ :id, :image_url, :position, :_destroy ]
    )
  end

  def process_images
    params[:item][:image_files].each_with_index do |file, index|
      # In a real app, you would upload this to cloud storage
      # For simplicity, we'll just store the filename
      filename = file.original_filename

      @item.images.create(
        image_url: filename,
        position: index
      )
    end
  end

  def require_same_user
    if current_user != @item.seller && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own items"
      redirect_to @item
    end
  end
end
