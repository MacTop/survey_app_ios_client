class RadioOption < NanoStore::Model
  attribute :id
  attribute :question_id
  attribute :content
  attribute :created_at
  bag :questions
end
