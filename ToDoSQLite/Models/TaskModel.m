//
//  TaskModel.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

- (instancetype)initWithText:(NSString *)text
               andIdentifier:(NSInteger)identifier
{
    self = [super init];
    if (self) {
        _text = text;
        _identifier = identifier;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %ld", self.text, (long)self.identifier];
}

@end
