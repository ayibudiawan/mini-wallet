module Api::DryHelper
  include ApplicationHelper

  def render_json(http_code, body, opt={ title: nil, data: nil })
    status = http_code.to_s.first.to_i.eql?(2) ? "success" : "error"
    message = body.class.eql?(ActiveModel::Errors) ? body.full_messages.join(" \n "): body
    title = opt[:title]
    if title.blank?
      action = params[:action].eql?("destroy") ? "delete" : params[:action].eql?("index") ? "get list" : params[:action]
      title = action.capitalize.humanize + " " + params[:controller].split("/").last.capitalize.humanize
    end
    title += status.eql?("success") ? " Success" : " Failure"
    response = {
      status: status,
      message_title: title,
      message: message
    }
    response = response.merge({ error: body.messages }) if status.eql?("error") && body.class.eql?(ActiveModel::Errors)
    response = opt[:data].try(:keys).try(:include?, :data) ? response.merge(opt[:data]) : response.merge({ data: opt[:data] }) if opt[:data] != nil
    render json: response, status: http_code
  end
end
