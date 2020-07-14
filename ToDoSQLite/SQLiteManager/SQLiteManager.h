//
//  SQLiteManager.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"

@interface SQLiteManager : NSObject
+ (instancetype)shared;

- (void)createDatabaseIfNeeded;

- (NSArray<TaskModel *> *)getAll;
- (BOOL)deleteTask:(TaskModel *)task;
- (TaskModel *)createTask:(TaskModel *)task;
- (TaskModel *)updateTask:(TaskModel *)task;
- (TaskModel *)getById:(NSInteger)identifier;

@end
