class RadioOption < NanoStore::Model
  attribute :id
  attribute :question_id
  attribute :content
  bag :questions
end
