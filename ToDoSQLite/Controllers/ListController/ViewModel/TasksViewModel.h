//
//  TasksViewModel.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskCellViewModel.h"

@interface TasksViewModel : NSObject
- (NSInteger)numberOfElements;
- (TaskCellViewModel *)cellForRow:(NSInteger)row;
- (TaskModel *)modelAt:(NSInteger)index;
- (void)askData;
@end
