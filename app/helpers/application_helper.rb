module ApplicationHelper
  def name_flash_method(name)
    [:alert, :error].include?(name.to_sym) ? "danger" : "success"
  end
end
