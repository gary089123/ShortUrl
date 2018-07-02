module UrlHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message,id: 'message' ,class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
        if msg_type == "notice" || msg_type == "success"
          concat content_tag(:button, 'COPY', id:'copy_button',onclick:'copyToClipboard()',class:' btn btn-outline-secondary float-right mr-4 btn-sm')
        end
      end)
    end
    nil
  end
end
