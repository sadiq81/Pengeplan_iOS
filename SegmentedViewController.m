//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "SegmentedViewController.h"
#import "AppDelegate.h"

@implementation SegmentedViewController {

}

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize uiTableView = _uiTableView;


static SegmentedViewController *sharedSegmentedViewController = nil;    // static instance variable

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

+ (SegmentedViewController *)sharedSegmentedViewController:(UITableView *)uiTableView {
    if (sharedSegmentedViewController == nil) {
        sharedSegmentedViewController = [[super allocWithZone:NULL] init];
        sharedSegmentedViewController.managedObjectContext = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
        sharedSegmentedViewController.uiTableView = uiTableView;

        NSError *error;
        if (![sharedSegmentedViewController.fetchedResultsController performFetch:&error]) {
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
    }
    return sharedSegmentedViewController;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end