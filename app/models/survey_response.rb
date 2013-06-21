class SurveyResponse < NanoStore::Model
  attribute :survey_id
  bag :answers
end
