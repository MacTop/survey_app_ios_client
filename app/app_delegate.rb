class AppDelegate < PM::Delegate
  def on_load(app, options)
    open QuestionScreen.new(nav_bar: true)
  end
end
