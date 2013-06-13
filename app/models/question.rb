class Question
  def self.get_survey
    BW::JSON.parse(get_survey_data)
  end

  def self.get_survey_data
    file_path = NSBundle.mainBundle.pathForResource("questions", ofType: "json")
    NSData.dataWithContentsOfFile file_path
  end
end
