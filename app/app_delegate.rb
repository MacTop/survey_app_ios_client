class AppDelegate < PM::Delegate
  def on_load(app, options)
    initialize_nano_store
    open SurveyListScreen.new(nav_bar: true)
  end

  def initialize_nano_store
    if RUBYMOTION_ENV == 'test'
      NanoStore.shared_store = NanoStore.store(:memory)
      DataStore.import
    else
      NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")
    end
  end
end
