module ResponseHelper
  def aggregate_question_answers survey_response
    answers = survey_response.answers.to_a
    root_answers = answers.select{|answer| Question.find(:id => answer.question_id).first.parent_id == 0}
    aggregated_answers = []
    root_answers = root_answers.sort_by{|answer| answer.created_at}
    root_answers.each do |root_answer|
      answer_pair = []
      answer_pair << root_answer
      answer_pair << get_child_answers_for(root_answer, answers)
      aggregated_answers << answer_pair
    end
    aggregated_answers
  end
  
  def get_child_answers_for root_answer, answers
    answers.select do |answer|
      radio_option = RadioOption.find(:id => Question.find(:id => answer.question_id).first.parent_id)
      if radio_option.blank?
        false
      else
        radio_option.first.question_id  == root_answer.question_id
      end
    end
  end
end
