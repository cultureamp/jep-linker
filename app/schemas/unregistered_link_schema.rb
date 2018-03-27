require 'dry-validation'

UnregisteredLinkSchema = Dry::Validation.Schema do
    required(:long_url).filled
    required(:custom_url).none?
end
