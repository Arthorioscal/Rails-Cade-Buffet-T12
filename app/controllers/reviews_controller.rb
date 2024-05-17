class ReviewsController < ApplicationController
    before_action :authenticate_user_client, only: [:new, :create]
    before_action :set_buffet, only: [:new, :create, :index, :show]
    before_action :set_review, only: [:show]
    before_action :check_order_status, only: [:create]
  
    
    def index
        @reviews = @buffet.reviews
    end
    
    def show
    end
    
    def new
        @review = @buffet.reviews.new
    end

    def create
      @review = @buffet.reviews.new(review_params)
      @review.user = current_user
  
      if @review.save
        redirect_to root_path, notice: 'Avaliação enviada com sucesso.'
      else
        render :new
      end
    end

    private
  
    def set_buffet
      @buffet = Buffet.find(params[:buffet_id])
    end
  
    def set_review
      @review = @buffet.reviews.find(params[:id])
    end
  
    def check_order_status
      if current_user.role == 'client'
        order = Order.find_by(user: current_user, buffet: @buffet)
        unless order && order.status == 'confirmed' && order.event_date < Date.today
          redirect_to @buffet, alert: 'Você ainda não pode avaliar este buffet.'
        end
      else
        redirect_to @buffet, alert: 'Only clients can review buffets.'
      end
    end
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def authenticate_user_client
      unless current_user.role == 'client'
        redirect_to root_path, alert: 'You are not authorized to access this page.'
      end
    end
  end