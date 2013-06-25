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
  
  def applyStyleToLabel(label, label_color, font_size)
    label.backgroundColor = UIColor.clearColor
    label.setTextColor(getColor(label_color))
    label.setFont(UIFont.boldSystemFontOfSize(font_size))
  end
  
  def add_dynamic_label(content, font_size)
    label_view = UILabel.alloc.initWithFrame CGRectMake(0,0,100,30)
    applyStyleToLabel(label_view, {:red => 1, :green => 1, :blue => 1, :alpha => 1}, font_size)
    maximum_label_size = CGSizeMake(280,40)
    expected_label_size = content.sizeWithFont(label_view.font, constrainedToSize: maximum_label_size)
    new_frame = label_view.frame
    new_frame.size.height = expected_label_size.height
    new_frame.size.width = expected_label_size.width
    label_view.frame = new_frame
    label_view.text = content
    label_view
  end

  def getColor(color)
    UIColor.colorWithRed(color[:red], green: color[:green] ,blue: color[:blue], alpha: color[:alpha])
  end

end
