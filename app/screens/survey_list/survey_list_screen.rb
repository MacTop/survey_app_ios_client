class SurveyListScreen < PM::Screen
  attr_accessor :received_survey_data

  title "SurveyList"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    add header_view = HeaderView.new({:title => I18n.t('survey_list_screen.title')})
    header_view_height = header_view.frame.size.height
    @table = UITableView.alloc.initWithFrame CGRectMake(0, header_view_height, self.view.frame.size.width, self.view.frame.size.height -  header_view_height)
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    @table.backgroundColor = ControlVariables::ScreenColor
    self.view.addSubview @table
    @table.dataSource = self
    @table.delegate = self
    load_surveys
  end

  def will_appear
    self.navigationController.setNavigationBarHidden(true, animated: false)
  end

  def viewDidAppear(animated)
    update_response_counts
  end
  
  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
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

  def show_responses_screen_for survey_id
    open ResponseListScreen.new(survey_id: survey_id)
  end

  def load_surveys
    @data = []
    Survey.all.each do |survey|
      @data <<  SurveyListItemView.new({:survey => survey})
    end
  end

  def update_response_counts
    @data.each do |survey_list_item|
      response_count = survey_list_item.get_survey_responses_count
      survey_list_item.viewWithTag(Tags::SurveyResponseCountLabel).text = response_count
    end
  end
end
