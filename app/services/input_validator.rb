class InputValidator
  def self.validate(input: nil)
    return false if input.nil?
    /^[a-zA-Z0-9]*$/.match?(input.gsub(/\s+/, "").upcase)
  end
end