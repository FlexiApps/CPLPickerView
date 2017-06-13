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

@interface ViewController () <TestViewControllerDelegate>
@property (nonatomic, strong) NSArray *customViewArray;
@property (nonatomic, strong) CustomViewModel *customViewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TestViewController *controller;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *staticPickerData = @[NSLocalizedString(@"home", nil), NSLocalizedString(@"office", nil), NSLocalizedString(@"country_house", nil)];
    NSArray *editablePickerData = @[NSLocalizedString(@"custom", nil)];
    NSInteger staticItemIndex = 1;
    NSInteger editableItemIndex = -1;

    self.controller = [[TestViewController alloc] initWithStaticItems:staticPickerData editableItems:editablePickerData staticItemIndex:staticItemIndex editableItemIndex:editableItemIndex];
}


#pragma mark - TestViewControllerDelegate Methods
- (void)didCancelWithTestViewController:(TestViewController *)testViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectItemWithSelectedStaticItemIndex:(NSInteger)selectedStaticItemIndex {
    NSLog(@"%ld",(long)selectedStaticItemIndex);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectEditableItemWithSelectedEditableItemIndex:(NSInteger)selectedEditableItemIndex customEditableItem:(NSString *)customEditableItem {
    NSLog(@"%ld - %@",(long)selectedEditableItemIndex, customEditableItem);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectNothingWithTestViewController:(TestViewController *)testViewController {
    NSLog(@"NOTHING");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Getters - settingsArray
- (NSArray *)customViewArray
{
    if (_customViewArray == nil) {
        _customViewArray = @[
                             @[
                                 [[CustomViewModel alloc] initWithName:@"Name" withCustomLabel:YES],
                                 [[CustomViewModel alloc] initWithName:@"Nothing" withCustomLabel:YES],
                                 ],
                             @[
                                 [[CustomViewModel alloc] initWithName:@"Other" withCustomLabel:YES],
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
                case 1:
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
        case 1:
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
            
        default:
            break;
    }
}

@end
