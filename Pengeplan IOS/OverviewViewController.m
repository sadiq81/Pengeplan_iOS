//
//  OverviewViewController.m
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 27/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "OverviewViewController.h"
#import "PengeplanService.h"
#import "AppDelegate.h"
#import "SecuritiesViewController.h"

@interface OverviewViewController ()

@end

const CGRect securitiesShow = {{0, 70}, {320, 498}};
const CGRect securitiesHide = {{-320, 70}, {320, 498}};

const CGRect depositoriesShow = {{0, 70}, {320, 498}};
const CGRect depositoriesHide = {{0, 568}, {320, 498}};

const CGRect historyShow = {{0, 70}, {320, 498}};
const CGRect historyHide = {{320, 70}, {320, 498}};

@implementation OverviewViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.securitiesTableView.delegate = [SecuritiesViewController sharedSegmentedViewController:self.securitiesTableView];
    self.securitiesTableView.dataSource = [SecuritiesViewController sharedSegmentedViewController:self.securitiesTableView];
    self.securitiesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//    [[PengeplanService sharedPengeplanService] updateTransactions];
    //[self getAllPhoneBookRecords];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;

    segmentedControl.enabled = NO;
    int selected = [segmentedControl selectedSegmentIndex];
    switch (selected) {
        case 0: {
            [UIView animateWithDuration:1.0 animations:^{
                self.securities.frame = securitiesShow;
                self.securities.hidden = NO;
                self.depositories.frame = depositoriesHide;
                self.history.frame = historyHide;
            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;
                self.depositories.hidden = YES;
                self.history.hidden = YES;
            }];
            break;
        }
        case 1: {
            [UIView animateWithDuration:1.0 animations:^{
                self.securities.frame = securitiesHide;
                self.depositories.frame = depositoriesShow;
                self.depositories.hidden = NO;
                self.history.frame = historyHide;
            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;
                self.securities.hidden = YES;
                self.history.hidden = YES;
            }];
            break;
        }
        case 2: {
            [UIView animateWithDuration:1.0 animations:^{
                self.securities.frame = securitiesHide;
                self.depositories.frame = depositoriesHide;
                self.history.frame = historyShow;
                self.history.hidden = NO;
            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;
                self.securities.hidden = YES;
                self.depositories.hidden = YES;
            }];
            break;
        }
    }
}
@end
