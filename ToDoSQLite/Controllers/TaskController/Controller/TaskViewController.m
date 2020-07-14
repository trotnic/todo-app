//
//  TaskViewController.m
//  ToDoSQLite
//
//  Created by Uladzislau Volchyk on 7/14/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@property (nonatomic, strong) TaskViewModel *viewModel;
@property (nonatomic, strong) UITextView *bodyField;

@end

@implementation TaskViewController

- (instancetype)initWithViewModel:(TaskViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.bodyField];
    
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doSave)],
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(doDelete)]
    ];
    
    
    self.bodyField.text = self.viewModel.body;
}

- (void)doDelete {
    [self.viewModel deleteTask];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doSave {
    NSString *body = self.bodyField.text;
    
    __weak typeof(self)weakSelf = self;
    
    [self.viewModel saveTaskWithBody:body completion:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    if(!parent && self.popCompletion) {
        self.popCompletion();
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [NSLayoutConstraint activateConstraints:@[
        
        [self.bodyField.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [self.bodyField.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:20],
        [self.bodyField.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [self.bodyField.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor constant:-10],
    ]];
}

- (UITextView *)bodyField {
    if(!_bodyField) {
        _bodyField = [UITextView new];
        _bodyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _bodyField.translatesAutoresizingMaskIntoConstraints = NO;
        _bodyField.textAlignment = NSTextAlignmentLeft;
        
    }
    return _bodyField;
}

@end
