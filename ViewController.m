//
//  ViewController.m
//  CustomList
//
//  Created by Christos Christodoulou on 08/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewModel.h"
#import "CustomList-Swift.h"


static NSString * const customViewCell = @"customViewCell";

@interface ViewController () <PickerViewControllerDelegate>
@property (nonatomic, strong) NSArray *customViewArray;
@property (nonatomic, strong) CustomViewModel *customViewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PickerViewController *controller;

@property (nonatomic, strong) NSArray *staticPickerData;
@property (nonatomic, strong) NSArray *editablePickerData;
@property (nonatomic, strong) NSArray *staticImagesData;
@property (nonatomic, assign) NSInteger textLengthAllowance;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int section;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Initial Data
    [self initNamePicker];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //- Update picker values
    self.controller = [[PickerViewController alloc] initWithStaticItems:self.staticPickerData editableItems:self.editablePickerData  staticImageItems:self.staticImagesData pickerRow:self.row pickerSection:self.section];
}

- (void)initNamePicker {
    self.staticPickerData =  @[NSLocalizedString(@"home", nil), NSLocalizedString(@"office", nil), NSLocalizedString(@"country_house", nil), NSLocalizedString(@"Garaz", nil), NSLocalizedString(@"island", nil)];
    
    self.textLengthAllowance = 40;
    self.pickerTitle = NSLocalizedString(@"choose", nil);
    
    //- Set initial values
    if ([self.staticPickerData containsObject:self.customViewModel.name]) {
        //- location name found in the staticPickerData
        //- empty editablePickerData to just present the placeholder
        //- set the row from the staticPickerData array
        //- set the section to zero (first section)
        //- create an indexpath from row & section
        self.editablePickerData = @[@""];
        self.row = (int)[self.staticPickerData indexOfObject:self.customViewModel.name];
        self.section = 0;
        self.indexPath = [NSIndexPath indexPathForRow:self.row inSection:self.section];
    }
    else if (self.customViewModel.name && ![self.staticPickerData containsObject:self.customViewModel.name]) {
        self.editablePickerData = @[self.customViewModel.name];
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

#pragma mark - TestViewControllerDelegate Methods
- (void)didCancelWithPickerViewController:(PickerViewController *)pickerViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickerViewControllerWithPickerViewController:(PickerViewController *)pickerViewController didSelectRow:(NSInteger)row inSection:(NSInteger)section :(NSString *)customText {
    [self.navigationController popViewControllerAnimated:YES];
    self.indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    self.row = (int)row;
    self.section = (int)section;
    
    if (customText == nil || [customText isEqualToString:@""]) {
        self.editablePickerData = @[@""];
        self.customViewModel.name = self.staticPickerData[self.indexPath.row];
    }
    else {
        self.editablePickerData = @[customText];
        self.customViewModel.name = customText;
    }
}


#pragma Getters - settingsArray
- (NSArray *)customViewArray
{
    if (_customViewArray == nil) {
        _customViewArray = @[
                             @[
                                 [[CustomViewModel alloc] initWithName:@"Local" withCustomLabel:YES],
                                 ],
                             @[
                                 [[CustomViewModel alloc] initWithName:@"Framework" withCustomLabel:YES],
                                 ]
                             ];
    }
    return _customViewArray;
}


#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.customViewArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customViewArray[section] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:customViewCell];
        
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.customViewModel = self.customViewArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = self.customViewModel.name;
    
    cell.preservesSuperviewLayoutMargins = FALSE;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
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
                }
                    break;
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
}

@end
