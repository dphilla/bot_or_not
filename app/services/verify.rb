module Verify
  def self.is_valid_phone_number?(phone_number)
    response = Authy::PhoneVerification.start(country_code: 1, phone_number: phone_number)
    response.success?
  end

  def self.valid_confirmation_code?(code, id)
    phone_number = User.find(id).phonenumber
    response = Authy::PhoneVerification.check(verification_code: code, country_code: 1, phone_number: phone_number)
    response.success?
  end
end
