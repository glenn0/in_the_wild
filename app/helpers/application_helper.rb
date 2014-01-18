module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | InTheWild"      
    end
  end
end
