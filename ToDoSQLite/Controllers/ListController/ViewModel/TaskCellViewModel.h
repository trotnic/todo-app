//
//  TaskCellViewModel.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface TaskCellViewModel : NSObject
- (instancetype)initWithTask:(TaskModel *)task;

- (NSString *)text;
- (NSInteger)identifier;
- (UIColor *)backgroundColor;

@end
