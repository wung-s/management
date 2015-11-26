module ApplicationHelper

  def is_active(path)
    current_page?(path) ? "active": ""

  end

  def alert_type(message_type)

    case message_type
    when 'notice'
      alert_class = 'success'
    when 'success'
      alert_class = 'success'
    when 'alert'
      alert_class = 'danger'
    when 'danger'
      alert_class = 'danger'
    else	
      alert_class = 'warning'
    end

    alert_class

  end

 end
