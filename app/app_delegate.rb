class AppDelegate < PM::Delegate
  def on_load(app, options)
    open ThrobberControllerDataImport.new(nav_bar: true)
  end
  
  def get_navigation_controller
    self.home_screen.navigation_controller if self.home_screen
  end
end
