//
//  TaskViewModel.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TaskViewModel.h"
#import "SQLiteManager.h"

@interface TaskViewModel ()

@property (nonatomic, strong) TaskModel *task;

@end

@implementation TaskViewModel

- (instancetype)initWithTask:(TaskModel *)task {
    self = [super init];
    if(self) {
        _task = task;
    }
    return self;
}

- (void)saveTaskWithBody:(NSString *)body completion:(void(^)(void))completion {
    NSInteger identifier = self.task == nil ? 0 : self.task.identifier;
    TaskModel *task = [[TaskModel alloc] initWithText:body andIdentifier:identifier];
    if(self.task == nil) {
        [SQLiteManager.shared createTask:task];
    } else {
        [SQLiteManager.shared updateTask:task];
    }
    completion();
}

- (NSString *)body {
    return self.task == nil ? @"" : self.task.text;
}

- (void)deleteTask {
    if(self.task) {
        [SQLiteManager.shared deleteTask:self.task];
    }
}

@end
