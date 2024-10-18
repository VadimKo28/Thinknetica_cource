
module ManufacturedCompany
  def set_company_name(name)
    self.company_name = name
  end

  def print_company_name
    self.company_name
  end

  protected
  attr_accessor :company_name
end  
