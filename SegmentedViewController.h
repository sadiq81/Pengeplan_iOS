//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SegmentedViewController : NSObject <UITableViewDelegate, UITableViewDataSource> {
@protected
    NSFetchedResultsController *_fetchedResultsController;
    UIViewController *_uiViewController;
}

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) UIViewController *uiViewController;
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain) UITableView *uiTableView;

- (id)initWithTableView:(UITableView *)uiTableView viewController:(UIViewController *)uiViewController;

@end