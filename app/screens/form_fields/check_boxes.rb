class CheckBoxes < SelectionField
  attr_accessor :check_box_selection

  def initialize(args = {})
    super args
    self.check_box_selection = []
  end
  
  def get_check_box_image_view_for(image_name)
    check_box_image = UIImage.imageNamed(image_name)
    check_box_image_view = UIImageView.alloc.initWithImage(check_box_image)
    check_box_image_view.setFrame(CGRectMake(15, 12, 20,21))
    check_box_image_view
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.setSelectionStyle(UITableViewCellSelectionStyleNone)

    cell.contentView.addSubview(checkbox_image_for_cell("unchecked-checkbox.png", 1)) if cell.contentView.subviews.empty?
    checked_image = checkbox_image_for_cell("checked-checkbox.png", 0) 
    checked_image.setTag(Tags::CheckedImageView)
    cell.contentView.addSubview(checked_image) if cell.contentView.subviews.size < 2
    cell.contentView.addSubview(@data[indexPath.row])
    cell     
  end

  def checkbox_image_for_cell(image_name, alpha)
    image_view = get_check_box_image_view_for(image_name)
    image_view.alpha = alpha
    image_view
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    @data[indexPath.row].frame.size.height + ControlVariables::RadioCellPadding
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    cell = @table.cellForRowAtIndexPath(indexPath)
    change_cell_highlight cell, @data[indexPath.row]
    toggle_content_selection(indexPath)
  end

  def toggle_content_selection(indexPath)
    text = @data[indexPath.row].text
    cell = @table.cellForRowAtIndexPath(indexPath)
    if self.check_box_selection.index(text).nil?
      self.check_box_selection << text
      cell.contentView.viewWithTag(Tags::CheckedImageView).alpha = 1
    else
      self.check_box_selection.delete(text)
      cell.contentView.viewWithTag(Tags::CheckedImageView).alpha = 0
    end
  end
end
