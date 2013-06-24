class ResponseListItemTemplate < UIView
  include Helpers

  MAX_WIDTH = 300
  MARGIN = 10
  
  def initWithFrame(frame)
    super.tap do
      self.stylesheet = :main
    end
  end

  def initialize(args = {})
    puts args[:survey_id]
    self.initWithFrame CGRectMake(MARGIN, ControlVariables::QuestionMargin, MAX_WIDTH, 100)
    self.backgroundColor = UIColor.whiteColor
    add_response_container_view
  end

  def add_response_container_view
    response_container_view = UIView.alloc.initWithFrame(CGRectMake(0,0,0,0))
    subview(response_container_view, :response_container_view)
  end
end
