//
//  TaskViewModel.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"

@interface TaskViewModel : NSObject

- (instancetype)initWithTask:(TaskModel *)task;
- (void)saveTaskWithBody:(NSString *)body completion:(void(^)(void))completion;

- (NSString *)body;

- (void)deleteTask;
@end
