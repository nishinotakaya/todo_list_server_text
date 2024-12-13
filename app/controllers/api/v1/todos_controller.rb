class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    # デバッグ用にログを追加
    Rails.logger.debug "Current User: #{current_user.inspect}"
    Rails.logger.debug "Auth Headers: #{request.headers['Authorization']}"

    if current_user.present?
      @todos = current_user.todos.order(:sort)
    else
      @todos = Todo.order(:sort)
    end
    render json: @todos
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:content, :completed_flg, :delete_flg, :sort)
  end
end
