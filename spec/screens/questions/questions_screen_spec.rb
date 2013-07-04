describe "QuestionScreen" do

  before do
    @questions_screen = QuestionScreen.new
    @questions_screen.survey_id = 5
    @questions_screen.on_load
  end

  it "should have a instance of FieldView" do
    sub_views = @questions_screen.view.subviews.collect{|sub_view| sub_view.class}
    sub_views.should.include FieldView
  end

  it "should calculate the origin of the next view" do
    @questions_screen.view.subviews.each{|view| view.removeFromSuperview}
    @questions_screen.get_origin_y(@questions_screen.view).should == 0
    @questions_screen.view.addSubview(UIView.alloc.initWithFrame CGRectMake(100, 100, 200, 200))
    @questions_screen.get_origin_y(@questions_screen.view).should == 300
  end
=begin
  it "should increment current_view by one on swipe left" do
    flick "question_screen", :from => :right, :to => :left
    @questions_screen.instance_variable_get(:@current_page).should == 1
    field_views = @questions_screen.view.subviews.collect{|subview| subview if subview.class == FieldView}
    field_views.last.viewWithTag(100).text.should == @second_arg[:content]
  end
=end

  it "should fetch only the questions with the parent is null" do
    Question.should_receive(:find).with({:survey_id => 5, :parent_id => 0}).and_return([])
    @questions_screen.populate_questions
    1.should == 1
  end

  it "should include header view" do
    sub_views = @questions_screen.view.subviews.collect{|sub_view| sub_view.class.to_s}
    sub_views.should.include "HeaderView"
  end

  it "should return true if the current page is the last page" do
    @questions_screen.instance_variable_set(:@current_page, 2)
    @questions_screen.is_last_page?.should == true
  end

  it "should add a submit button to the parent view" do
    questions = @questions_screen.instance_variable_get(:@questions)
    questions.last.viewWithTag(Tags::SubmitButtonView).should.not.be.nil
  end

  it "should receive click handler on click of submit button" do
    @questions_screen.should.receive(:save_response)
    questions = @questions_screen.instance_variable_get(:@questions)
    questions.last.viewWithTag(Tags::SubmitButtonView).sendActionsForControlEvents(UIControlEventTouchUpInside)
  end

  it "should have atleast one instance of swipe view" do
    @questions_screen.view.viewWithTag(Tags::SwipeView).should.not.be.nil
  end

  it "should return true if there are more than one question exists" do
    @questions_screen.multiple_question_exists?.should == true
  end

  it "should not have any instances of swipe view if only have 1 question" do
    @questions_screen.stub!(:multiple_question_exists?).and_return(false)
    @questions_screen.view = UIView.alloc.init
    @questions_screen.on_load
    @questions_screen.view.viewWithTag(Tags::SwipeView).should.be.nil
  end

  it "should save the response" do
    @questions_screen.stub!(:navigation_controller).and_return(UINavigationController.new)
    questions = @questions_screen.instance_variable_get(:@questions)
    questions.each do |question|
      question.viewWithTag(Tags::FieldViewTextField).text = "content"
    end
    previous_response_count = SurveyResponse.all.count
    previous_answers_count = Answer.all.count
    @questions_screen.save_response
    SurveyResponse.all.count.should > previous_response_count
    Answer.all.count.should > previous_answers_count
  end

  it "should set error field on validation failure" do
    questions = @questions_screen.instance_variable_get(:@questions)
    @questions_screen.instance_variable_set(:@current_page,1)
    questions.each do |question|
      question.viewWithTag(Tags::FieldViewTextField).text = "content"
    end
    unfilled_question = questions.first
    related_question = Question.find(:id => unfilled_question.question_id).first
    related_question.mandatory = true
    related_question.save
    unfilled_question.viewWithTag(Tags::FieldViewTextField).text = ""
    @questions_screen.should_receive(:addQuestionView)
    @questions_screen.save_response
    unfilled_question.viewWithTag(Tags::ErrorFieldViewLabel).text.should == I18n.t('field_view.error')
    @questions_screen.instance_variable_get(:@current_page).should == 0
  end

  describe "radio button" do
    before do
      @questions_screen = QuestionScreen.new
      @questions_screen.survey_id = 8
      @questions_screen.on_load
    end
    
    it "should save the response" do
      questions = @questions_screen.instance_variable_get(:@questions)
      radio_buttons = questions.collect {|subview| subview.viewWithTag(Tags::RadioButtonsControllerView) if subview.class == FieldView}
      radio_buttons.compact!
      radio_buttons.each do |radio_button|
        radio_button.radio_button_selection = "content"
      end
      previous_response_count = SurveyResponse.all.count
      previous_answers_count = Answer.all.count
      @questions_screen.save_response
      SurveyResponse.all.count.should > previous_response_count
      Answer.all.count.should > previous_answers_count
    end
  end

  describe "Check box" do
    before do
      @questions_screen = QuestionScreen.new
      @questions_screen.survey_id = 3
      @questions_screen.on_load
    end
    
    it "should save the response" do
      check_boxes = @questions_screen.childViewControllers.select{|controller| controller if controller.class == CheckBoxes}
      check_boxes.each do |check_box|
        check_box.check_box_selection = ["content"]
      end
      previous_response_count = SurveyResponse.all.count
      previous_answers_count = Answer.all.count
      @questions_screen.save_response
      SurveyResponse.all.count.should > previous_response_count
      Answer.all.count.should > previous_answers_count
    end

    it "should join the selction for saving the answer" do
      field_view = @questions_screen.instance_variable_get(:@questions).first
      controller = field_view.viewWithTag(Tags::CheckBoxesControllerView)
      controller.stub!(:check_box_selection).and_return(["asd", "wer"])
      @questions_screen.get_answer_for_type_MultiChoiceQuestion(field_view).should == "asd, wer"
    end
  end
  
  describe "text area" do
    before do
      @questions_screen = QuestionScreen.new
      @questions_screen.survey_id = 12
      @questions_screen.on_load
    end

    it "should save the response" do
      questions = @questions_screen.instance_variable_get(:@questions)
      multiline_fields = questions.collect {|subview| subview.viewWithTag(Tags::MultilineQuestionView) if subview.class == FieldView}
      multiline_fields.compact!

      multiline_fields.each do |field|
        question = Question.find(:id => field.superview.question_id).first
        question.mandatory = true
        question.save
        field.text_area.text = "answer to multiline"
      end
      previous_response_count = SurveyResponse.all.count
      previous_answers_count = Answer.all.count
      @questions_screen.save_response
      SurveyResponse.all.count.should > previous_response_count
      Answer.all.count.should > previous_answers_count
    end
  end
end
