//
//  TestViewController.m
//  CustomList
//
//  Created by Christos Christodoulou on 13/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, assign)NSInteger selectedItemIndex;
@property (nonatomic, assign)NSInteger editableItemIndex;
@property (nonatomic, strong)NSArray *selectedItemsArray;
@property (nonatomic, strong)NSArray *editableItemsArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (instancetype)initWithSelectedItems:(NSArray *)items andEditableItems:(NSArray *)editableItems forSelectedItemIndex:(NSInteger)selectedItemIndex forEditableItemIndex:(NSInteger)editableItemIndex {
    self = [super init];
    
    return self;
}
@end
