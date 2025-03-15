module ApplicationHelper
  def exercise_priority(priority)
    color =
      case priority
      when 1
        "text-lime-300"
      when 2
        "text-lime-600"
      when 3
        "text-amber-200"
      when 4
        "text-orange-300"
      when 5
        "text-amber-600"
      when 6
        "text-orange-600"
      when 7
        "text-red-500"
      end

    content_tag(:span, %w[~ S A B C D E F][priority], class: color)
  end
end
