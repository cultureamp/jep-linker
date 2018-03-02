require 'dry-transaction'

class CreateUnregisteredLink
  include Dry::Transaction
  include Services

  step :validate
  step :persist

  def validate(params)
    validation = UnregisteredLinkSchema.(params)
    if validation.success?
      Success(params)
    else
      Failure(validation.errors)
    end
  end

  def persist(params)
    link = Services::Url.find_or_create_unregistered_link(long_url: params[:long_url]) 
    if link.valid?
      Success(link)
    else
      Failure(link)
    end
  end
end
