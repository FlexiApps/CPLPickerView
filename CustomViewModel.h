//
//  CustomViewModel.h
//  CustomList
//
//  Created by Christos Christodoulou on 08/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomViewModel : NSObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)BOOL addCustomLabelEnabled;

- (instancetype)initWithName:(NSString *)name withCustomLabel:(BOOL)addCustomLabelEnabled;

@end
