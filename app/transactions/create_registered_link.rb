require 'dry-transaction'

class CreateRegisteredLink
  include Dry::Transaction  

  step :validate
  step :persist

  def validate(params:, current_user:)
    validation = RegisteredLinkSchema.(params)
    if validation.success?
      Success(params: params, current_user: current_user)
    else
      Failure(validation.errors)
    end
  end

  def persist(params:, current_user:)
    link = Services::Url.find_or_create_registered_link(long_url: params[:long_url], custom_url: params[:custom_url], current_user: current_user) 
    if link.valid?
      Success(link)
    else
      Failure(link)
    end
  end
end
