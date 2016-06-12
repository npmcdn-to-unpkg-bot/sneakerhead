class ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def new
    @shoe = Shoe.new
  end

  def edit
    @shoe = Shoe.find(params[:id])
  end

  def create
    @shoe = Shoe.new post_params
    if @shoe.save
      if current_user
        current_user.shoes << @shoe
      end
      redirect_to shoe_path(@shoe.id)
    else
      render 'new'
    end
  end

  def update
    @shoe = Shoe.find(params[:id])
    if @shoe.save
      @shoe.update(shoe_params)
      redirect_to shoes_path
    else
      render 'edit'
    end
  end

  def destroy
    @shoe = Shoe.find(params[:id])
    @shoe.destroy
    redirect_to shoes_path
  end

  private

    def shoe_params
      params.require(:shoe).permit(:size, :name, :brand, :price, :condition, :color, :notes, :image)
    end

    def correct_user
      @shoe = current_user.shoes.find_by(id: params[:id])
      redirect_to shoes_path, notice: "C'mon brah, don't touch other people's stuff" if @shoe.nil?
    end
end
