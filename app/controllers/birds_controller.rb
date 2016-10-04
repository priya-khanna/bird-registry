class BirdsController < ApplicationController
  def index
    render json: all_birds.map{ |item| BirdDecorator.new(item).as_json }, status: 200
  end

  def show
    if bird
      render json: BirdDecorator.new(bird).as_json, status: 200
    else
      render json: { error: "Not found" }, status: 404
    end
  end

  def create
    new_bird = Bird.create(bird_create_data)
    if new_bird
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

  def all_birds
    @_all_birds ||= Bird.where(visible: true).desc(:added).to_a
  end

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:name, :family, :visible, continents: [])
  end

  def bird_create_data
    {
      name: create_params[:name],
      family: create_params[:family],
      added: Time.zone.now.strftime("%Y-%m-%d"),
      visible: params[:visible] == "true" ? true : false
    }
  end
end
