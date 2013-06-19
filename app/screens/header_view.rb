class HeaderView < UIView
  include Helpers
#  include Constants

  def initialize(args = {})
    self.initWithFrame CGRectMake(0, 0, ControlVariables::ScreenWidth, ControlVariables::HeaderHeight)
    start_color = UIColor.colorWithRed(0.227, green: 0.559, blue: 0.657, alpha: 1)
    end_color = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
    gradient = CAGradientLayer.layer
    gradient.frame = self.bounds
    gradient.colors = [start_color.CGColor, end_color.CGColor]
    self.layer.insertSublayer gradient, atIndex: 0
    add_logo
    add_title(args)
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
end
