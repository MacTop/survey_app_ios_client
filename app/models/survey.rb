class Survey
  def self.get_survey_list
    BW::JSON.parse(get_survey_list_data)
  end

  def self.get_survey_list_data
    file_path = NSBundle.mainBundle.pathForResource("surveys", ofType: "json")
    NSData.dataWithContentsOfFile file_path
  end
end
