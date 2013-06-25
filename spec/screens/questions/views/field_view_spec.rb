describe "FieldView" do
  describe "text" do
    before do
      @question = Question.find(:id => 5).first
      @args = {:question => @question, :origin_y => 10}
      @field_view = FieldView.new(@args)
    end

    it "should set the question statement in the view" do
      question_statement_label = @field_view.viewWithTag(Tags::FieldViewLabel)
      question_statement_label.text.should == @question.content
      @field_view.question_id.should == @question.id
    end

    it "should get the height of label frame dynamically" do
      field_view = @field_view
      question_statement_label = field_view.viewWithTag(Tags::FieldViewLabel)
      first_height = question_statement_label.frame.size.height
      @question.content = "single_line_question_statement"*50
      @question.save
      @field_view = FieldView.new(@args)
      field_view = @field_view
      question_statement_label = field_view.viewWithTag(Tags::FieldViewLabel)
      second_height = question_statement_label.frame.size.height
      first_height.should < second_height
    end

    it "should add text field if the question type is SingleLineQuestion" do
      @field_view = FieldView.new(@args)
      @field_view.viewWithTag(Tags::FieldViewTextField).should.not.be.nil
    end

    it "should have delegate container controller" do
      @field_view.viewWithTag(Tags::FieldViewTextField).delegate.class.should == QuestionScreen
    end
  end

  describe "radio" do
    before do
      @question = Question.find(:id => 12).first
      @args = {:question => @question, :origin_y => 10}
      @field_view = FieldView.new(@args)
    end

    it "should have radiobuttons if the type is RadioQuestion" do
      puts @field_view.subviews
      radio_button_views = @field_view.subviews.select{|subview| subview if subview.controller.class == RadioButtons}
      radio_button_views.size.should == 1
    end

    it "should return the minimum of data count and RadioButtonsMaxCount" do
      @field_view.min_count(['red', 'green', 'blue']).should == 3
      @field_view.min_count(['red', 'green', 'blue', 'yellow', 'indigo', 'violet']).should != 6
    end
  end
end
