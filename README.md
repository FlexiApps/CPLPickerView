# CPLPickerView
Custom Picker List

Have an init method to set default values before calling the CPLPickerView
- (void)initNamePicker {
    self.staticPickerData =  @[NSLocalizedString(@"home", nil), NSLocalizedString(@"office", nil), NSLocalizedString(@"country_house", nil)];
    self.textLengthAllowance = 40;
    self.pickerTitle = NSLocalizedString(@"choose", nil);
    
    //- Set initial values
    if ([self.staticPickerData containsObject:self.location.name]) {
        //- location name found in the staticPickerData
        //- empty editablePickerData to just present the placeholder
        //- set the row from the staticPickerData array
        //- set the section to zero (first section)
        //- create an indexpath from row & section
        self.editablePickerData = @[@""];
        self.row = (int)[self.staticPickerData indexOfObject:self.location.name];
        self.section = 0;
        self.indexPath = [NSIndexPath indexPathForRow:self.row inSection:self.section];
    }
    else if (self.location.name && ![self.staticPickerData containsObject:self.location.name]) {
        self.editablePickerData = @[self.location.name];
        self.row = 0;
        self.section = 1;
        self.indexPath = [NSIndexPath indexPathForRow:self.row inSection:self.section];
    }
    else {
        self.editablePickerData = @[@""];
        self.row = -1;
        self.section = -1;
        self.indexPath = nil;
    }
}

And then push or present to the CPLPickerView
  self.controller.delegate = self;
  self.controller.pickerTitle = self.pickerTitle;
  self.controller.textLengthAllowanceInt = self.textLengthAllowance;
  self.controller.selectedIndexPath = self.indexPath;
  self.controller.colorForBackgroundView = [UIColor purpleColor];
  self.controller.colorForCustomCell = [UIColor whiteColor];
  self.controller.colorForSeparatorLine = [UIColor lightGrayColor];
  self.controller.colorForTextFieldWarning = [UIColor orangeColor];
  self.controller.fontForCustomCell = [UIFont fontWithName:@"HelveticaNeue-light" size:20.0];
  [self.navigationController pushViewController:self.controller animated:YES];
