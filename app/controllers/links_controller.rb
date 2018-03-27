class LinksController < ApplicationController
  before_action :set_inputs, only: [:create]
  include Services
  def index
    @link = Link.new
    @shortened_link = Link.find_by_short_url(params[:id])
    @user_links = current_user.links.all
  end

  def show
   owedn
   redirection_url = Link.find_by(short_url: params[:id])
    redirect_to redirection_url.long_url
  end

  def create
    unregistered_transaction = CreateUnregisteredLink.new
    registered_transaction = CreateRegisteredLink.new

    if user_signed_in?
      registered_transaction.(params: @inputs.to_h.symbolize_keys, current_user: current_user) do |result|
        result.success do |link|
          redirect_to links_path(id: link)
        end

        result.failure :validate do |invalid_link|
          @errors = errors
          flash[:error] = invalid_link.errors.full_messages
          redirect_to root_path
        end
      end
    else
      unregistered_transaction.(@inputs.to_h.symbolize_keys) do |result|
        result.success do |link|
          redirect_to links_path(id: link)
        end

        result.failure :validate do |errors|
          @link = Link.new(@inputs)
          @errors = errors
          flash[:error] = @link.errors.full_messages
          redirect_to root_path
        end
      end
    end
  end

  private

  def set_inputs
    @inputs = {long_url: params[:long_url], custom_url: params[:custom_url]}
  end

  def allowed_params
    params.require(:link).permit(:long_url, :custom_url)
  end
end
