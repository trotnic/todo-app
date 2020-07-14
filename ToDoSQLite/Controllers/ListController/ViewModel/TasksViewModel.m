//
//  TasksViewModel.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TasksViewModel.h"
#import "SQLiteManager.h"

@interface TasksViewModel ()

@property (nonatomic, strong) NSMutableArray<TaskCellViewModel *> *cellViewModels;
@property (nonatomic, strong) NSMutableArray<TaskModel *> *models;

@end

@implementation TasksViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellViewModels = [NSMutableArray new];
        _models = [NSMutableArray new];
    }
    return self;
}

- (void)askData {
    self.models = [SQLiteManager.shared.getAll mutableCopy];
    [self.cellViewModels removeAllObjects];
    for (TaskModel *model in self.models) {
        [self.cellViewModels addObject:[[TaskCellViewModel alloc] initWithTask:model]];
    }
}

- (TaskModel *)modelAt:(NSInteger)index {
    return [self.models objectAtIndex:index];
}

- (NSInteger)numberOfElements {
    return self.cellViewModels.count;
}

- (TaskCellViewModel *)cellForRow:(NSInteger)row {
    return [self.cellViewModels objectAtIndex:row];
}

@end
