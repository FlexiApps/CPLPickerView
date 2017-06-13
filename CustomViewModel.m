//
//  CustomViewModel.m
//  CustomList
//
//  Created by Christos Christodoulou on 08/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

#import "CustomViewModel.h"

@implementation CustomViewModel

- (instancetype)initWithName:(NSString *)name withCustomLabel:(BOOL)addCustomLabelEnabled
{
    self = [super init];
    if (self) {
        _name = name;
        _addCustomLabelEnabled = addCustomLabelEnabled;
    }
    return self;
}
@end
