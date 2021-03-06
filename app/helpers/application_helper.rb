require 'redcarpet'

module ApplicationHelper

  def markdown(text)
    render_options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { target: '_blank' }
    }
    renderer = HTML.new(render_options)

    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def format_alert_type(flash_type)
    case flash_type
    when 'alert'
      'warning'
    when 'notice'
      'success'
    end
  end

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag(:div, link_to('x', '#', :class => 'close', 'data-dismiss' => 'alert') + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def format_time(utc_time)
    utc_time.strftime('%Y-%m-%d')
  end

  def format_full_time(utc_time)
    utc_time.strftime('%Y年%m月%d日%H时%M分%S秒')
  end

  def owner?(item)
    return false if item.blank? || current_user.blank?
    if item.is_a?(User)
      item.id == current_user.id
    else
      item.user_id == current_user.id
    end
  end

  def admin?
    return current_user.has_role? :admin
  end

end
