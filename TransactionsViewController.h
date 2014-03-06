//
// Created by Tommy Sadiq Hinrichsen on 04/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransactionsViewController : UIViewController      <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
;
@property (weak, nonatomic) IBOutlet UITableView *transactionsTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSString *selectedPaperName;
@property (strong, nonatomic) NSDateFormatter *df;


@end