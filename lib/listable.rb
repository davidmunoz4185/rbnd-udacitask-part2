module Listable
  def format_description(description)
    "#{@description}".ljust(30)
  end

  def format_date(options = {})
    if options[:due] then
      dates = options[:due].strftime("%D")
    elsif options[:start_date]
      dates = options[:start_date].strftime("%D")
      if options[:end_date] then
        dates << " -- " + options[:end_date].strftime("%D")
      end
    else
      dates = "N/A"
    end
    return dates
  end

  def format_priority(priority)
    case priority
    when "high"
      value = " ⇧".colorize(:green)
    when "medium"
      value = " ⇨".colorize(:yellow)
    when "low"
      value = " ⇩".colorize(:grey)
    else value = "" if (!priority || priority.to_s == '')
    end
    return value
  end

  def format_name(name)
    @name ? @name : ""
  end

end
