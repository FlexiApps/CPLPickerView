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
    self.staticPickerData = @[NSLocalizedString(@"Home", nil), NSLocalizedString(@"Office", nil), NSLocalizedString(@"Country House", nil), NSLocalizedString(@"Garaz", nil)];
    self.editablePickerData = @[NSLocalizedString(@"Add Custom Label", nil)];
    self.textLengthAllowance = 5;
    self.indexPath = nil;
    self.pickerTitle = NSLocalizedString(@"Choose", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //- Update picker values
    self.controller = [[PickerViewController alloc] initWithStaticItems:self.staticPickerData editableItems:self.editablePickerData  staticImageItems:self.staticImagesData pickerRow:self.row pickerSection:self.section];
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
    }
    else {
        self.editablePickerData = @[customText];
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
    
    CustomViewModel *customViewModel = self.customViewArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = customViewModel.name;
    
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
                    [self.navigationController pushViewController:self.controller animated:YES];
                }
                    break;
                default:
                    break;
            }
            
            break;
        }
//        case 1:
//        {
//            switch (indexPath.row) {
//                case 0:
//                {
//                    GoToPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GoToPickerViewController"];
//                    [self.navigationController pushViewController:controller animated:YES];
//                }
//                    break;
//                default:
//                    break;
//            }
//            break;
//        }
            
        default:
            break;
    }
}

@end
