//
//  TaskModel.h
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy) NSString *text;

- (instancetype)initWithText:(NSString *)text andIdentifier:(NSInteger)identifier;

@end
