class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @entries = Entry.not_draft.page(params[:page]).per(18)
  end

  def search
    @entries = if params[:tag].present? && params[:q].present?
      Entry.not_draft.tagged_with(params[:tag]).search_by(params[:q]).includes(:tags)
    elsif params[:tag].present?
      Entry.not_draft.tagged_with(params[:tag]).includes(:tags).desc
    elsif params[:q].present?
      Entry.not_draft.search_by(params[:q]).includes(:tags)
    else
      Entry
    end
    @entries = @entries.page(params[:page]).per(18)
    render 'index'
  end

  def show
    @comment = Comment.new
    @entry.update(view: @entry.view + 1)
  end

  def new
    @entry = current_user.entries.build
  end

  def create
    @entry = current_user.entries.new(entry_params)
    if @entry.save
      flash[:success] = '記事を作成しました。'
      redirect_to entry_path(@entry)
    else
      render 'new'
    end
  end

  def edit
    gon.before_body = @entry.body
  end

  def update
    gon.before_body = @entry.body
    if @entry.update(entry_params)
      flash[:success] = '記事を編集しました。'
      redirect_to entry_path(@entry)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def tag_cloud
    @tags = Entry.tag_counts_on(:tags)#.order('count DESC')
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:id, :image, :title, :body, :is_draft, :tag_list)
  end
end
