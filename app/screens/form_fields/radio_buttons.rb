class RadioButtons < SelectionField
  attr_accessor :radio_button_selection

  def viewDidLoad
    super
    @radio_image_selected_view = get_radio_image_view_for("RadioButton-Selected.png")
  end
  
  def get_radio_image_view_for(image_name)
    radio_image = UIImage.imageNamed(image_name)
    radio_image_view = UIImageView.alloc.initWithImage(radio_image)
    radio_image_view.setFrame(CGRectMake(15, 12, 20,21))
    radio_image_view
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.setSelectionStyle(UITableViewCellSelectionStyleNone)

    radio_image_view = get_radio_image_view_for("RadioButton-Unselected.png")
    cell.contentView.addSubview(radio_image_view)

    cell.contentView.addSubview(@data[indexPath.row])
    cell     
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    cell = @table.cellForRowAtIndexPath(indexPath)
    change_cell_highlight cell, @data[indexPath.row]
    cell.contentView.addSubview(@radio_image_selected_view)
    self.radio_button_selection = @data[indexPath.row].text
  end
end
