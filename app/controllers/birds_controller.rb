class BirdsController < ApplicationController
  def index
    render json: Bird.where(visible: true).pluck(:id).map(&:to_s).uniq, status: 200
  end

  def show
    if bird
      render json: BirdDecorator.new(bird).as_json, status: 200
    else
      render json: { error: "Not found" }, status: 404
    end
  end

  def create
    new_bird = Bird.new(bird_data)
    if new_bird.save
      render json: BirdDecorator.new(new_bird).as_json, status: 201
    else
      render json: { error: "Failed due to errors: #{new_bird.errors.full_messages.to_sentence}" }, status: 400
    end
  end

  def delete
    if bird && bird.delete
      render json: { success: "Successfully deleted!"}, status: 200
    else
      render json: { error: "Not found"}, status: 404
    end
  end

  private

  def bird
    @_bird = Bird.find_by(id: params[:id])
  end

  def create_params
    params.permit(:name, :family, :visible, continents: [])
  end

  def bird_data
    {
      name: create_params[:name],
      family: create_params[:family],
      added: Time.zone.now.strftime("%Y-%m-%d"),
      continents: create_params[:continents],
      visible: params[:visible] == "true" ? true : false
    }
  end
end
