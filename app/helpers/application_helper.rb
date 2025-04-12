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

  def nav_link_to(icon_name, path, disabled: false)
    css_classes = "btn-ghost material-symbols-outlined no-underline"

    if disabled
      css_classes += " btn-disabled"
      content_tag(:span, icon_name, class: css_classes)
    else
      link_to(icon_name, path, class: css_classes)
    end
  end

  def add_link_to(path)
    link_to path, class: "btn btn-circle btn-ghost" do
      content_tag(:span, "add", class: "material-symbols-outlined text-gray-400")
    end
  end
end
