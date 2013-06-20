class DataStore

  def self.get_data_for(resource)
    file_path = NSBundle.mainBundle.pathForResource(resource, ofType: "json")
    BW::JSON.parse(NSData.dataWithContentsOfFile file_path)
  end

  def self.import
    get_data_for("surveys").each_with_index do |survey, index|
      survey_model = Survey.new(:id => survey[:id], :name => survey[:name], :expiry_date => survey[:expiry_date])
      survey_model.save
    end

    get_data_for("questions").each_with_index do |question, index|
      survey = Survey.find(:id => question[:survey_id]).first
      survey.questions << Question.new(:id => question[:id], :survey_id => question[:survey_id], :content => question[:content], :type => question[:type], :mandatory => question[:mandatory])
      survey.save
    end
  end
end
