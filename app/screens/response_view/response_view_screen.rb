class ResponseView < PM::Screen
  attr_accessor :survey_response
  attr_accessor :received_survey_data

  include Helpers
  include ResponseHelper
  
  def on_load
    add header_view = HeaderView.new({:title => I18n.t('response_view_screen.title')})
    table_origin =  get_origin_y(self.view)
    @table = UITableView.alloc.initWithFrame CGRectMake(0, table_origin, self.view.frame.size.width, self.view.frame.size.height - table_origin)
    set_data_source
    @table.backgroundColor = ControlVariables::ScreenColor
    @table.setSeparatorStyle(UITableViewCellSeparatorStyleNone)
    subview(@table, :response_table)
    @table.dataSource = self
    @table.delegate = self
  end

  def set_data_source
    @data = []
    gcd_queue = Dispatch::Queue.concurrent(:high)
    answers = survey_response.answers.to_a
    gcd_queue.sync do
      aggregate_question_answers(survey_response).flatten.each do |answer|
      @data << ResponseDetails.new(answer)
      end
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
    @data[indexPath.row].frame.size.height
  end
end
