//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "SegmentedViewController.h"
#import "AppDelegate.h"

@implementation SegmentedViewController {

}

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize uiViewController = _uiViewController;
@synthesize uiTableView = _uiTableView;


- (id)initWithTableView:(UITableView *)uiTableView viewController:(UIViewController *)uiViewController {
    self = [super init];
    if (self) {
        self.managedObjectContext = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];

        self.uiViewController = uiViewController;

        self.uiTableView = uiTableView;
        self.uiTableView.delegate = self;
        self.uiTableView.dataSource = self;
        self.uiTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        NSError *error;
        if (![self.fetchedResultsController performFetch:&error]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController fetchedObjects] count];
}

@end