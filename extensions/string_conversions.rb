class String
  
  def uncontrollerize
    self.gsub(/Controller/, "").snake_case
  end
  
  def snake_case
    str = ""
    self.each_char do |char|
      (char =~ /[A-Z]/) ? str += "_#{char}" : str += char
    end
    str[1..-1].downcase
  end
  
end

