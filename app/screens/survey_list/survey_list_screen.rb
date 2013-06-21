class SurveyListScreen < PM::Screen
  title "SurveyList"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    header_view = HeaderView.new({:title => I18n.t('survey_list_screen.title')})
    add header_view
    @data = Survey.get_survey_list
    header_view_height = header_view.frame.size.height
    @table = UITableView.alloc.initWithFrame CGRectMake(0, header_view_height, self.view.frame.size.width, self.view.frame.size.height -  header_view_height)
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    @table.backgroundColor = ControlVariables::ScreenColor
    self.view.addSubview @table
    @table.dataSource = self
    @table.delegate = self
  end

  def will_appear
     self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  def show_questions_screen
    open QuestionScreen.new
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.contentView.backgroundColor = ControlVariables::ScreenColor
    
    survey = @data[indexPath.row]
    args = {:survey_name => survey[:name], :description => survey[:description], :expiry_date => survey[:expiry_date]}

    view = SurveyListItemView.new(args)
    cell.contentView.addSubview(view)
    cell    
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
   130
  end
  
end
