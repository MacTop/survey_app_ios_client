class HeaderView < UIView
  include Helpers

  def initWithFrame(frame)
    super.tap do
      self.stylesheet = :main
    end
  end

  def initialize(args = {})
    @app_delegate = UIApplication.sharedApplication.delegate
    self.initWithFrame CGRectMake(0, 0, ControlVariables::ScreenWidth, ControlVariables::HeaderHeight)
    start_color = UIColor.colorWithRed(0.227, green: 0.559, blue: 0.657, alpha: 1)
    end_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
    gradient = CAGradientLayer.layer
    gradient.frame = self.bounds
    gradient.colors = [start_color.CGColor, end_color.CGColor]
    self.layer.insertSublayer gradient, atIndex: 0
    add_logo
    add_title(args)
    add_back_button_if_needed
  end

  def add_done_button view
    done_button = UIButton.buttonWithType(UIButtonTypeCustom)
    color = {:red => 0.007, :green => 0.339, :blue => 0.437, :alpha => 1}
    done_button.setBackgroundImage(UIImage.imageNamed("done-button.png"), forState: UIControlStateNormal)
    done_button.setTitle("Done", forState: UIControlStateNormal)
    done_button.setTag Tags::HeaderViewDoneButton
    subview(done_button,:done_button)
    done_button.on(UIControlEventTouchUpInside) do
       done_button_handler view, done_button 
    end
    apply_border_radius(done_button, 5)
    done_button.layer.masksToBounds = true
  end

  def done_button_handler view, done_button
    done_button.removeFromSuperview
    view.text_area.resignFirstResponder

    new_frame = view.parent_view.frame
    new_frame.origin.y += view.y_offset
    UIView.animateWithDuration(0.2, animations: lambda{view.parent_view.frame = new_frame})
  end
  
  def add_logo
    image = UIImage.imageNamed('logo.png')
    imageView = UIImageView.alloc.initWithImage(image)
    imageView.frame = CGRectMake(80, ControlVariables::HeaderLogoMarginTop, ControlVariables::LogoWidth, ControlVariables::LogoWidth)
    self.addSubview(imageView)
  end

  def add_title(args)
    label_view = add_dynamic_label(args[:title], 15)
    new_frame = label_view.frame
    new_frame.origin.x = 125
    new_frame.origin.y = ControlVariables::HeaderLabelMarginTop
    label_view.frame = new_frame
    self.addSubview(label_view)
  end

  def back_button_needed?
    if @app_delegate.home_screen
      return @app_delegate.home_screen.navigation_controller.viewControllers.length > 1
    end
    return false
  end
  
  def add_back_button_if_needed
    if(self.back_button_needed?)
      back_button = UIButton.buttonWithType(UIButtonTypeCustom)
      back_button.setTitle("", forState:UIControlStateNormal)
      back_button.setBackgroundImage(UIImage.imageNamed("backbutton-normal.png"), forState: UIControlStateNormal)
      back_button.setBackgroundImage(UIImage.imageNamed("backbutton-highlighted.png"), forState: UIControlStateHighlighted)
      back_button.setTitle(" Back", forState: UIControlStateNormal)
      subview(back_button,:back_button)
      self.addSubview(back_button)
      back_button.on_tap { back_to_previous_screen}
    end
  end

  def back_to_previous_screen received_data = nil
    navigation_controller = @app_delegate.get_navigation_controller
    navigation_controller.popViewControllerAnimated(true)
    navigation_controller.visibleViewController.received_survey_data = received_data
  end

  def back_to view_controller, received_data = nil
    navigation_controller = @app_delegate.get_navigation_controller
    view_controller.received_survey_data = received_data
    navigation_controller.pushViewController(view_controller, animated: true)
  end
end
