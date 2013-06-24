class ResponseListScreen < PM::Screen
  attr_accessor :survey_id
  title "Response List"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    add header_view = HeaderView.new({:title => I18n.t('response_list_screen.title')})
    survey_view = SurveyListItemTemplate.new({:survey => Survey.find(:id => self.survey_id).first})
    survey_view.frame = get_new_frame survey_view
    add survey_view
    @data = []
    table_origin =  get_origin_y(self.view) + ControlVariables::QuestionMargin
    @table = UITableView.alloc.initWithFrame CGRectMake(0, table_origin, self.view.frame.size.width, self.view.frame.size.height - table_origin)
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :response_table)
    @table.dataSource = self
    @table.delegate = self
    Survey.all.each do |survey|
      @data <<  ResponseListItemTemplate.new({:survey_id => 5})
    end
  end

  def will_appear
    self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "response_list_screen_cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.contentView.backgroundColor = ControlVariables::ScreenColor
    cell.contentView.addSubview(@data[indexPath.row])
    cell    
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
   130
  end

  def show_questions_screen_for survey_id
    open QuestionScreen.new(survey_id: survey_id) 
  end

  def get_new_frame view
    new_frame = view.frame
    new_frame.origin.y = get_origin_y(self.view) + ControlVariables::QuestionMargin
    new_frame
  end
end
