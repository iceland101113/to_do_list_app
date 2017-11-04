class TodolistsController < ApplicationController
  before_action :set_todolist, :only =>[:show, :edit, :update, :destroy]

  def index
    @todolists = Todolist.all
  end

  def new
    @todolist = Todolist.new
  end

  def create
    @todolist = Todolist.new(todolist_params)
    if @todolist.save
      redirect_to todolists_url
    else
      render :action => :new
    end
  end

  def update
    if @todolist.update_attributes(todolist_params)
      redirect_to todolist_path(@todolist)
    else
      render :action => :edit
    end
  end

  def destroy
    require 'date'
    if Date.today >= @todolist.due_date
      redirect_to todolists_url 
    else  
      @todolist.destroy
      redirect_to todolists_url
    end
  end

  private

  def todolist_params
    params.require(:todolist).permit(:title, :due_date, :description)
  end  

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end