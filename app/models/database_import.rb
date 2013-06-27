class DataStore

  def self.get_data_for(resource)
    file_path = NSBundle.mainBundle.pathForResource(resource, ofType: "json")
    BW::JSON.parse(NSData.dataWithContentsOfFile file_path)
  end

  def self.import
    get_data_for("surveys").each_with_index do |survey, index|
      survey_model = Survey.new(:id => survey[:id], :name => survey[:name], :expiry_date => survey[:expiry_date], :description => survey[:description])
      survey_model.save
    end

    get_data_for("questions").each_with_index do |question, index|
      survey = Survey.find(:id => question[:survey_id]).first
      survey.questions << Question.new(:id => question[:id], :survey_id => question[:survey_id], :content => question[:content], :type => question[:type], :mandatory => question[:mandatory], :parent_id => 0)
      survey.save
    end

    get_data_for("options").each do |option|
      question = Question.find(:id => option[:question_id]).first
      radio_option = RadioOption.new(:id => option[:id], :question_id => option[:question_id], :content => option[:content])
      option[:questions].each do |sub_question|
        radio_option.questions << Question.new(:id => sub_question[:id], :survey_id => sub_question[:survey_id], :content => sub_question[:content], :type => sub_question[:type], :mandatory => sub_question[:mandatory], :parent_id => sub_question[:parent_id])
        radio_option.save
      end
      question.radio_options << radio_option
      question.save
    end

  end
end
