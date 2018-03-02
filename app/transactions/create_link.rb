require 'dry-transaction'

class CreateUnregisteredLink
  include Dry::Transaction

  step :validate

  def validate(params)
    validation = UnregisteredLinkSchema.(params)
    if validation.success?
      Success(params)
    else
      Failure(validation.errors)
    end
  end
end
