class MultiLineField < UIView
  attr_accessor :text_area, :y_offset
  stylesheet :main

  def initialize(args = {})
    self.initWithFrame(CGRectMake(0, args[:origin_y], args[:max_width], 100))
    @header_view = args[:header_view]
    @text_area = UITextView.alloc.initWithFrame(self.bounds)
    @text_area.delegate = self
    @text_area.setFont(UIFont.systemFontOfSize(16))
    @text_area.layer.cornerRadius = 5
    @keyboard_observer = App.notification_center.observe UIKeyboardDidShowNotification do |notification|
      key_board_shown(notification)
    end
    
    subview(@text_area)
  end
  
  def key_board_shown notification
    @header_view.add_done_button self
    new_frame = self.superview.frame
    new_frame.origin.y -= calculate_displacement(get_keyboard_height(notification))
    UIView.animateWithDuration(0.2, animations: lambda{self.superview.frame = new_frame})
  end

  def get_keyboard_height notification
    key_board_object = notification.userInfo.objectForKey("UIKeyboardFrameEndUserInfoKey")
    key_board_object.CGRectValue.size.height
  end

  def calculate_displacement(kb_height)
    screen_height = UIScreen.mainScreen.bounds.size.height
    text_view_height = self.frame.size.height
    text_view_origin_y = self.frame.origin.y
    @y_offset = (kb_height - (screen_height - (text_view_height + text_view_origin_y + self.superview.frame.origin.y + ControlVariables::HeaderHeight)))
    @y_offset > 0 ? @y_offset : 0
  end
end
