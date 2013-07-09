class MultiLineField < UIView
  attr_accessor :text_area, :y_offset, :parent_view
  stylesheet :main

  def initialize(args = {})
    self.initWithFrame(CGRectMake(0, args[:origin_y], args[:max_width], 100))
    @header_view = args[:header_view]
    @text_area = UITextView.alloc.initWithFrame(self.bounds)
    @text_area.delegate = self
    @text_area.setFont(UIFont.systemFontOfSize(16))
    @text_area.layer.cornerRadius = 5
    subview(@text_area)
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
