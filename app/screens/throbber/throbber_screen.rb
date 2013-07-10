class ThrobberController < ProMotion::Screen
  include Helpers
   
  def viewDidLoad
    super
    self.view.addSubview get_animated_throbber
  end
  
  def will_appear
     self.navigationController.setNavigationBarHidden(true, animated: false)
  end
  
  def get_animated_throbber
    throbber_view = UIImageView.alloc.initWithFrame(CGRectMake(126,200,76,76))
    throbber_view.animationImages = [UIImage.imageNamed("throbber1.gif"), UIImage.imageNamed("throbber2.gif"), UIImage.imageNamed("throbber3.gif")]
    throbber_view.animationDuration = 0.1
    throbber_view.animationRepeatCount = 0
    throbber_view.startAnimating
    throbber_view
  end
   
end
