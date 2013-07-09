class MultiLineField < UIView
  attr_accessor :text_area, :y_offset, :parent_view
  stylesheet :main

  def initialize(args = {})
    self.initWithFrame(CGRectMake(0, args[:origin_y], args[:max_width], 100))
    @header_view = args[:header_view]
    @text_area = UITextView.alloc.initWithFrame(self.bounds)
    @text_area.delegate = self
    @text_area.setFont(UIFont.systemFontOfSize(16))
    @text_area.layer.cornerRadius = 15
    add_inset_shadow_to_text_area
    subview(@text_area)
  end

  def add_inset_shadow_to_text_area
    @text_area.backgroundColor = UIColor.clearColor
    border_view = UIImageView.alloc.initWithFrame CGRectMake(0, -2 , @text_area.frame.size.width, @text_area.frame.size.height + 5)
    border_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    text_field_image = UIImage.imageNamed("text-area-bg.png").resizableImageWithCapInsets(UIEdgeInsetsMake(20, 20, 20, 20))
    border_view.image = text_field_image
    border_view.frame.origin = @text_area.frame.origin
    subview(border_view)
    self.sendSubviewToBack(border_view)
  end
  
  def textViewDidBeginEditing(textView)
    @header_view.add_done_button self
    self.parent_view = self.superview
    controller_view = QuestionScreen.this_controller.view
    controller_view.subviews.select{|subview| subview.class == FieldView}.count
    field_view = controller_view.viewWithTag(Tags::FieldView)
    new_frame = field_view.frame
    new_frame.origin.y -= calculate_displacement(ControlVariables.get_keyboard_height)
    UIView.animateWithDuration(0.2, animations: lambda{self.parent_view.frame = new_frame})
  end

  def calculate_displacement(kb_height)
    screen_height = UIScreen.mainScreen.bounds.size.height
    text_view_height = self.frame.size.height
    text_view_origin_y = self.frame.origin.y
    @y_offset = 0
    @y_offset = (kb_height - (screen_height - (text_view_height + text_view_origin_y + self.parent_view.frame.origin.y + ControlVariables::HeaderHeight)))
    @y_offset = @y_offset > 0 ? @y_offset : 0
  end
end
