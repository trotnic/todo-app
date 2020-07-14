//
//  TaskViewController.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewModel.h"

@interface TaskViewController : UIViewController
- (instancetype)initWithViewModel:(TaskViewModel *)viewModel;
@property (nonatomic, copy) void(^popCompletion)(void);
@end
