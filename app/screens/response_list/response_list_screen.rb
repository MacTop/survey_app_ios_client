class ResponseListScreen < PM::Screen
  attr_accessor :survey_id
  title "Response List"
  include Helpers

  stylesheet :main

  def on_load
    set_attributes self.view, stylename: :base_theme
    add header_view = HeaderView.new({:title => I18n.t('response_list_screen.title')})
    @survey_view = SurveyListItemTemplate.new({:survey => Survey.find(:id => self.survey_id).first})
    @survey_view.frame = get_new_frame @survey_view
    add @survey_view
    table_origin =  get_origin_y(self.view) + ControlVariables::QuestionMargin
    @table = UITableView.alloc.initWithFrame CGRectMake(0, table_origin, self.view.frame.size.width, self.view.frame.size.height - table_origin)
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :response_table)
    @table.dataSource = self
    @table.delegate = self
  end

  def will_appear
    update_response_count
    load_survey_response_data
    self.navigationController.setNavigationBarHidden(true, animated: false)
    @data.each do |data|
      open_response_view_screen_on_tap data
    end
  end

  def update_response_count
    response_count = @survey_view.get_survey_responses_count
    @survey_view.viewWithTag(Tags::SurveyResponseCountLabel).text = response_count
  end

  def open_response_view_screen_on_tap data
    data.on_tap do
      change_highlight data, {:red => 0.933, :green => 0.933, :blue => 0.933, :alpha => 1}
      response_controller = ResponseView.new
      response_controller.survey_response = data.response
      open response_controller
    end
  end

  def will_disappear
     self.navigationController.setNavigationBarHidden(false, animated: true)
  end

  def add_complete_response_title
    field_label = UILabel.alloc.initWithFrame(CGRectMake(10, 0, 300, 30))
    field_label.text = I18n.t('response.completed_responses')
    field_label.textColor = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
    field_label.backgroundColor =  UIColor.clearColor
    field_label.textAlignment = NSTextAlignmentCenter
    field_label
  end
  
  def create_empty_message_label
    empty_message_label = UILabel.alloc.initWithFrame(CGRectMake(10, 0, 300, 30))
    set_label_dynamicity empty_message_label, I18n.t('response.empty_message'), Tags::EmptyResponseMessageLabel
    empty_message_label.textColor = UIColor.colorWithRed(0.027, green: 0.459, blue: 0.557, alpha: 1)
    empty_message_label.backgroundColor =  UIColor.clearColor
    empty_message_label.textAlignment = NSTextAlignmentCenter
    empty_message_label
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "response_list_screen_cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.contentView.subviews.each do |sub_view|
      sub_view.removeFromSuperview
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
   @data[indexPath.row].frame.size.height + 10
  end

  def show_questions_screen_for survey_id
    open QuestionScreen.new(survey_id: survey_id) 
  end

  def load_survey_response_data
    @data = []
    responses = SurveyResponse.find({:survey_id => self.survey_id}, {:sort => {:created_at => :desc}})
    if responses.blank?
      @data << create_empty_message_label
    else
      @data << add_complete_response_title
      responses.each do |response|
        @data <<  ResponseListItemTemplate.new({:survey_response => response})
      end
    end
    @table.reloadData
  end

  def get_new_frame view
    new_frame = view.frame
    new_frame.origin.y = get_origin_y(self.view) + ControlVariables::QuestionMargin
    new_frame
  end
end
