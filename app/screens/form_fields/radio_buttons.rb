class RadioButtons < SelectionField
  attr_accessor :radio_button_selection, :radio_options, :radio_sub_question

  def initialize(args = {})
    super args
    self.radio_options = args[:radio_options]
    @expanded_data = []
    self.generate_expanded_data args
    @radio_image_selected_view = get_radio_image_view_for("RadioButton-Selected.png")
    @selected_row = -1
  end

  def generate_expanded_data args
    @radio_options.each_with_index do |radio_option, index|
      unless radio_option.questions.to_a.empty?
        question = radio_option.questions.to_a.first
        question.content = "#{args[:question_index]}.#{index+1} #{question.content}" 
          field_view = FieldView.new({:question => question, :origin_x => 28, :origin_y => 25, :width => 271, :input_field_y_margin => 6})
      end
      @expanded_data << (radio_option.questions.to_a.empty? ? nil : field_view)
    end
  end
  
  def get_radio_image_view_for(image_name)
    radio_image = UIImage.imageNamed(image_name)
    radio_image_view = UIImageView.alloc.initWithImage(radio_image)
    radio_image_view.setFrame(CGRectMake(15, 12, 20,21))
    radio_image_view
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = super
    cell.contentView.subviews.removeViewsFromSuperview unless cell.contentView.subviews.empty?
    radio_image_view = get_radio_image_view_for("RadioButton-Unselected.png")
    cell.contentView.addSubview(radio_image_view)
    cell.contentView.addSubview(@data[indexPath.row])
    if @selected_row == indexPath.row
      cell.contentView.addSubview(@radio_image_selected_view)
      self.radio_button_selection = @data[indexPath.row].text
      unless self.radio_options[indexPath.row].questions.to_a.empty?
        self.radio_sub_question = @expanded_data[indexPath.row]
        cell.contentView.addSubview(@expanded_data[indexPath.row]) unless @expanded_data[indexPath.row].blank?
      end
    end
    cell     
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    if @selected_row == indexPath.row
      unless @expanded_data[indexPath.row].blank?
        @data[indexPath.row].frame.size.height + @expanded_data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding + 20
      else
        @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding - 7
      end
    else
      @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding - 7
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_row = indexPath.row
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationFade)
    cell = @table.cellForRowAtIndexPath(indexPath)
    change_cell_highlight cell, @data[indexPath.row]
    adjust_table_height unless @expanded_data[indexPath.row].blank?
    cell
  end

  def adjust_table_height
    @table.reloadData
    
    adjust_height_to_table_content @table
    adjust_height_to_table_content self
    adjust_height_to_table_content self.superview
    
    self.superview.reset_field_frame 50
    
    submit_button = self.superview.viewWithTag(Tags::SubmitButtonView)
    if submit_button
      index =  self.superview.subviews.indexOfObject(submit_button)
      offset =  (@table.contentSize.height + ControlVariables::TableHeightMargin) - submit_button.frame.origin.y
      self.superview.update_input_field_height index, offset if index
    end   
  end

  def adjust_height_to_table_content view
    new_frame = view.frame
    new_frame.size.height = @table.contentSize.height
    view.frame = new_frame
  end
end
