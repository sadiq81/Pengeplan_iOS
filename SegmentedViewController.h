//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SegmentedViewController : NSObject <UITableViewDelegate, UITableViewDataSource> {
@protected
    NSFetchedResultsController *_fetchedResultsController;
}

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain) UITableView *uiTableView;

+ (SegmentedViewController *)sharedSegmentedViewController:(UITableView *)uiTableView;

@end