//
//  TaskCellViewModel.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TaskCellViewModel.h"

@interface TaskCellViewModel ()

@property (nonatomic, strong) TaskModel *task;

@end

@implementation TaskCellViewModel

- (instancetype)initWithTask:(TaskModel *)task 
{
    self = [super init];
    if (self) {
        _task = task;
    }
    return self;
}

- (NSString *)text {
    return [self.task.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)identifier {
    return self.task.identifier;
}

- (UIColor *)backgroundColor {
    return [UIColor.grayColor colorWithAlphaComponent:0.1];
}

@end

