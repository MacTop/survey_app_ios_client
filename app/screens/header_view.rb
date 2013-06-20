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

  def add_logo
    image = UIImage.imageNamed('logo.png')
    imageView = UIImageView.alloc.initWithImage(image)
    imageView.frame = CGRectMake(80, 0, ControlVariables::LogoWidth, ControlVariables::LogoWidth)
    self.addSubview(imageView)
  end

  def add_title(args)
    label_view = add_dynamic_label(args[:title], 15)
    new_frame = label_view.frame
    new_frame.origin.x = 125
    new_frame.origin.y = 10
    label_view.frame = new_frame
    self.addSubview(label_view)
  end

  def back_button_needed?
    if @app_delegate.home_screen
      return @app_delegate.home_screen.navigation_controller.viewControllers.length > 0
    end
    return false
  end
  
  def add_back_button_if_needed
    if(self.back_button_needed?)
      back_button = UIButton.buttonWithType(UIButtonTypeCustom)
      back_button.setTitle("Back", forState:UIControlStateNormal)
      back_button.layer.cornerRadius = 5
      # back_button.setImage(UIImage.imageNamed("logo.png"), forState:UIControlStateNormal)
      back_button.setTintColor(UIColor.blackColor)
      subview(back_button,:back_button)
      self.addSubview(back_button)
      back_button.on_tap { back_to_previous_screen }
    end
  end

  def back_to_previous_screen
    navigation_controller = @app_delegate.get_navigation_controller
    navigation_controller.popToRootViewControllerAnimated(true) 
  end
end
