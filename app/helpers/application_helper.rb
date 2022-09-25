module ApplicationHelper

  def mobile?
    agent = request.user_agent
    return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    agent =~ /Mobile/ ? true : false
  end
end
