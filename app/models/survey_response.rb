class SurveyResponse < NanoStore::Model
  attribute :survey_id
  attribute :created_at
  bag :answers
end
