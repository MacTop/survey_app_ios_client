module Helpers
  
  def get_origin_y view
    last_sub_view = view.subviews.last
    if last_sub_view
      origin_y = last_sub_view.frame.origin.y
      height = last_sub_view.size.height
      origin_y + height
    else
      0
    end
  end
end
