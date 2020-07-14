//
//  TasksTableViewController.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TasksTableViewController.h"
#import "TasksViewModel.h"
#import "TaskViewController.h"

@interface TasksTableViewController ()

@property (nonatomic, strong) TasksViewModel *viewModel;

@end

@implementation TasksTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewModel = [TasksViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"reuseIdentifier"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        [self.viewModel askData];
}

#pragma mark - Utility

- (void)addNewTask {
    TaskViewController *viewController = [[TaskViewController alloc] initWithViewModel:[[TaskViewModel alloc] initWithTask:nil]];
    
    __weak typeof(self)weakSelf = self;
    viewController.popCompletion = ^{
        [weakSelf.viewModel askData];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfElements;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    TaskCellViewModel *viewModel = [self.viewModel cellForRow:indexPath.row];
    cell.textLabel.text = viewModel.text;
    
    cell.contentView.backgroundColor = viewModel.backgroundColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskViewController *viewController = [[TaskViewController alloc] initWithViewModel:[[TaskViewModel alloc] initWithTask:[self.viewModel modelAt:indexPath.row]]];
    __weak typeof(self)weakSelf = self;
    viewController.popCompletion = ^{
        [weakSelf.viewModel askData];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
