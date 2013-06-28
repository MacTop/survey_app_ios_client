module Helpers

  MAXIMUM_WIDTH = 300
  
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

  def set_label_dynamicity label_view, text, tag
    new_frame = label_view.frame
    label_view.text = text
    label_view.lineBreakMode = UILineBreakModeWordWrap
    new_frame.size.height = get_label_height text, label_view
    label_view.frame = new_frame
    label_view.setTag tag
    label_view.numberOfLines = 0
  end
  
  def get_label_height text, label
    max_label_size = CGSizeMake(MAXIMUM_WIDTH, Float::INFINITY)
    expected_size = text.sizeWithFont(label.font, constrainedToSize: max_label_size,  lineBreakMode: label.lineBreakMode)
    expected_size.height
  end
  
  def reset_field_frame extra_height = 0
    total_view_height = get_origin_y self
    new_frame = self.frame
    new_frame.size.height = total_view_height + extra_height
    self.frame = new_frame
  end

  def get_image_from_color color
    rect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, getColor(color).CGColor)
    CGContextFillRect(context, rect)
    background_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    background_image
  end

  def apply_border_radius view, radius
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
  end

  def change_highlight(view, highlight_color)
    default_color = view.backgroundColor
    view.backgroundColor = getColor(highlight_color)
    gcd_queue = Dispatch::Queue.main
    gcd_queue.after(0.2){ view.backgroundColor = default_color}
  end

  def apply_click_highlight button
    color = {:red => 0.127, :green => 0.459, :blue => 0.557, :alpha => 0.6}
    button.setBackgroundImage(get_image_from_color(color), forState: UIControlStateHighlighted)
  end
end
