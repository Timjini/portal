class TailwindPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: "flex justify-center mt-4 space-x-1 text-sm" }
  end

  def page_number(page)
    if page == current_page
      tag(:span, page, class: "px-4 py-2 text-white bg-blue-600 border border-blue-600 rounded")
    else
      link(page, page, class: "px-4 py-2 text-gray-700 bg-white border border-gray-300 rounded hover:bg-gray-100")
    end
  end

  def previous_or_next_page(page, text, classname, aria_label = nil)
  if page
    link(text, page, class: "px-3 py-2 border rounded text-gray-600 bg-white hover:bg-gray-100")
  else
    tag(:span, text, class: "px-3 py-2 border rounded text-gray-300 bg-gray-100")
  end
end


  def gap
    tag(:span, '...', class: "px-3 py-2 text-gray-500")
  end
end
