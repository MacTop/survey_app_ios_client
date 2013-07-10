class DataStore
  
  def self.get_data_for(resource)
    file_path = NSBundle.mainBundle.pathForResource(resource, ofType: "json")
    BW::JSON.parse(NSData.dataWithContentsOfFile file_path)
  end

  def self.import
    set_resource_names
    DataStore.import_surveys
    DataStore.import_questions
    DataStore.import_options
  end

  def self.set_resource_names
    if RUBYMOTION_ENV == 'test'
      @survey_data = "surveys_test"
      @question_data = "questions_test"
      @option_data = "options_test"
    else
      @survey_data = "surveys"
      @question_data = "questions"
      @option_data = "options"
    end
  end

  def self.import_surveys
    get_data_for(@survey_data).each do |survey|
      survey_model = Survey.new(:id => survey[:id], :name => survey[:name], :expiry_date => survey[:expiry_date], :description => survey[:description])
      survey_model.save
    end
  end

  def self.import_questions    
    get_data_for(@question_data).each do |question|
      survey = Survey.find(:id => question[:survey_id]).first
      survey.questions << Question.new(:id => question[:id], :survey_id => question[:survey_id], :content => question[:content], :type => question[:type], :mandatory => question[:mandatory], :parent_id => 0, :created_at => Time.now)
      survey.save
    end
  end

  def self.import_options
    get_data_for(@option_data).each do |option|
      question = Question.find(:id => option[:question_id]).first
      radio_option = RadioOption.new(:id => option[:id], :question_id => option[:question_id], :content => option[:content])
      option[:questions].each do |sub_question|
        radio_option.questions << Question.new(:id => sub_question[:id], :survey_id => sub_question[:survey_id], :content => sub_question[:content], :type => sub_question[:type], :mandatory => sub_question[:mandatory], :parent_id => sub_question[:parent_id], :created_at => Time.now)
      end
      radio_option.save
      question.radio_options << radio_option
      question.save
    end

  end
end
