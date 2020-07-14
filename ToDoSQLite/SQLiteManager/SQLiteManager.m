//
//  SQLiteManager.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

static NSString *const filePath = @"/db.sqlite";

@interface SQLiteManager ()

@property (nonatomic, copy) NSString *directoryPath;
@property (nonatomic, strong) NSMutableArray<TaskModel *> *results;

@end

@implementation SQLiteManager

+ (instancetype)shared {
    static SQLiteManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SQLiteManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _results = [NSMutableArray new];
    }
    return self;
}

#pragma mark - CRUD

- (NSArray<TaskModel *> *)getAll {
    NSString *query = @"SELECT * FROM TASK";
    [self runQuery:query];
    return [self.results copy];
}

- (TaskModel *)getById:(NSInteger)identifier {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM STUDENT WHERE ID = %ld", identifier];
    [self runQuery:query];
    return self.results.lastObject;
}

- (TaskModel *)updateTask:(TaskModel *)task {
    NSString *query = [NSString stringWithFormat:@"UPDATE TASK SET BODY = '%@' WHERE ID = %ld", task.text, task.identifier];
    [self runQuery:query];
    return [self getLastUpdated];
}

- (TaskModel *)createTask:(TaskModel *)task {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO TASK (BODY) VALUES ('%@')", task.text];
    [self runQuery:query];
    
    return [self getLastUpdated];
}

- (BOOL)deleteTask:(TaskModel *)task {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM TASK WHERE ID = %ld", (long)task.identifier];
    [self runQuery:query];
    return YES;
}


#pragma mark - Utility

- (TaskModel *)getLastUpdated {
    NSString *query = @"SELECT * FROM TASK ORDER BY ID DESC LIMIT 1;";
    [self runQuery:query];
    return self.results.lastObject;
}


- (void)createDatabaseIfNeeded {
    NSString *fullPath = [self.directoryPath stringByAppendingString:filePath];
//    NSLog(@"%@", fullPath);

    NSFileManager *fileManager = [NSFileManager new];
    if([fileManager fileExistsAtPath:fullPath]) {
        NSLog(@"FILE EXISTS");
        return;
    }
    
    sqlite3 *database;
    if(sqlite3_open([fullPath UTF8String], &database) != SQLITE_OK) {
        NSLog(@"CAN'T OPEN DATABASE");
        return;
    }
    
    NSString *query = @"CREATE TABLE TASK (ID INTEGER PRIMARY KEY, BODY TEXT NOT NULL);";
    [self runQuery:query];
    
    sqlite3_close(database);
}


- (void)runQuery:(NSString *)query {
    NSString *fullPath = [self.directoryPath stringByAppendingString:filePath];
    sqlite3 *database;
    
    if(sqlite3_open([fullPath UTF8String], &database) != SQLITE_OK) {
        NSLog(@"CAN'T OPEN DATABASE");
        return;
    }
    
    sqlite3_stmt *statement = NULL;
    
    if(sqlite3_prepare_v2(database, query.UTF8String, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"CAN'T PREPARE STATEMENT");
        sqlite3_close(database);
        return;
    }
    
    [self runStatement:statement];
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

- (void)runStatement:(sqlite3_stmt *)statement {
    self.results = [NSMutableArray new];
    
    while(sqlite3_step(statement) == SQLITE_ROW) {
        NSInteger identifier = sqlite3_column_int(statement, 0);
        NSString *text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        [self.results addObject:[[TaskModel alloc] initWithText:text andIdentifier:identifier]];
    }
}

@end
