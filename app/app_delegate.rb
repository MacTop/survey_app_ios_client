class AppDelegate < PM::Delegate
  def on_load(app, options)
    initialize_nano_store
    open SurveyListScreen.new(nav_bar: true)
    # rb = RadioButtons.new
    # rb.data = ['red', 'green', 'blue']
    # open rb
  end

  def initialize_nano_store
    if RUBYMOTION_ENV == 'test'
      NanoStore.shared_store = NanoStore.store(:memory)
      DataStore.import
    else
      NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")
      import_seed_data
    end
  end

  def import_seed_data
    if App::Persistence['first_run'].nil?
      DataStore.import
      App::Persistence['first_run'] = true
    end
  end
  
  def get_navigation_controller
    self.home_screen.navigation_controller if self.home_screen
  end
end
