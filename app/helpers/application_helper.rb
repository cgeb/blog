module ApplicationHelper
  def flash_key(key)
    if key == "notice"
      "success"
    else
      "danger"
    end
  end
end
