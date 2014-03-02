//
//  OverviewViewController.m
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 27/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "OverviewViewController.h"
#import "PengeplanService.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

NSArray *views;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    views = [[NSArray alloc] initWithObjects:_securities, _depositories, _history, nil];
    [[PengeplanService sharedPengeplanService] updateTransactions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    int selected = [segmentedControl selectedSegmentIndex];
    for (int i = 0; i < segmentedControl.numberOfSegments; i++) {
        UIView *view = [views objectAtIndex:i];
        if (selected == i) {
            view.hidden = false;
        } else {
            view.hidden = true;
        }
    }
}
@end
