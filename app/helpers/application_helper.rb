module ApplicationHelper
  def exercise_priority(priority)
    color =
      case priority
      when 1
        "text-lime-400"
      when 2
        "text-lime-700"
      when 3
        "text-amber-300"
      when 4
        "text-orange-300"
      when 5
        "text-amber-600"
      end

    content_tag(:span, %w[~ S A B C D][priority], class: color)
  end
end
