require 'dry-validation'

RegisteredLinkSchema = Dry::Validation.Schema do
    required(:long_url).filled
    required(:custom_url).maybe(:str?)
end
