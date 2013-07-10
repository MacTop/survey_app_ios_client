class Question < NanoStore::Model
  attribute :id
  attribute :survey_id
  attribute :parent_id
  attribute :content
  attribute :type
  attribute :mandatory
  attribute :created_at
  bag :radio_options
  
  def self.get_survey
    BW::JSON.parse(get_survey_data)
  end

  def self.get_survey_data
    file_path = NSBundle.mainBundle.pathForResource("questions", ofType: "json")
    NSData.dataWithContentsOfFile file_path
  end

  def self.load_questions_to_db
    Question.get_survey.each_with_index do |question, index|
      question = Question.new(:survey_id => 1, :content => question[:content], :type => question[:type], :mandatory => question[:mandatory])
      question.save
    end
  end
end
