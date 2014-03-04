//
//  OverviewViewController.h
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 27/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecuritiesViewController.h"
#import "DepositoriesViewController.h"
#import "HistoryViewController.h"

@interface OverviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIView *securities;
@property (weak, nonatomic) IBOutlet UIView *depositories;
@property (weak, nonatomic) IBOutlet UIView *history;

@property (weak, nonatomic) IBOutlet UITableView *securitiesTableView;
@property (weak, nonatomic) IBOutlet UITableView *depositoriesTableView;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@property (strong, nonatomic) SecuritiesViewController *securitiesViewController;
@property (strong, nonatomic) DepositoriesViewController *depositoriesViewController;
@property (strong, nonatomic) HistoryViewController *historyViewController;

- (void) configureSegmentedControlViews;

- (IBAction)segmentedControl:(id)sender;




@end
