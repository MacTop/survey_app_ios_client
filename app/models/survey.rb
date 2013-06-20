class Survey < NanoStore::Model
  attribute :id
  attribute :name
  attribute :expiry_date
  bag :questions
  bag :survey_responses
end
