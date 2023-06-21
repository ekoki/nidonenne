module ApplicationHelper
  def flash_classname(type)
    case type
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'alert' then 'alert alert-warning'
    else 'alert'
    end
  end
end
