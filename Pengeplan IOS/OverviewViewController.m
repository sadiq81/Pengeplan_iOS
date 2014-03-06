//
//  OverviewViewController.m
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 27/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "OverviewViewController.h"
#import "TransactionsViewController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transactionsUpdated) name:@"transactionsUpdated" object:nil];

    [self configureViews];
    [self configureSegmentedControlViews];
//    [self configureChart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.securitiesTableView deselectRowAtIndexPath:[self.securitiesTableView indexPathForSelectedRow] animated:NO];
    [self.depositoriesTableView deselectRowAtIndexPath:[self.depositoriesTableView indexPathForSelectedRow] animated:NO];
    [self.historyTableView deselectRowAtIndexPath:[self.historyTableView indexPathForSelectedRow] animated:NO];
}


- (void)configureViews {
    self.securities.alpha = 1;
    self.depositories.alpha = 0;
    self.history.alpha = 0;
}

- (void)configureSegmentedControlViews {
    self.securitiesViewController = [[SecuritiesViewController alloc] initWithTableView:self.securitiesTableView viewController:self];
    self.depositoriesViewController = [[DepositoriesViewController alloc] initWithTableView:self.depositoriesTableView viewController:self];
    self.historyViewController = [[HistoryViewController alloc] initWithTableView:self.historyTableView viewController:self];
}

//- (void)configureChart {
//
//    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.cPLayerHostingView.bounds];
//    // Get the (default) plotspace from the graph so we can set its x/y ranges
//    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
//
//    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
//    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 16 )]];
//    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -4 ) length:CPTDecimalFromFloat( 8 )]];
//
//    graph.axisSet = nil;
//
//    self.cPLayerHostingView.hostedGraph = graph;
//
//    // Get the (default) plotspace from the graph so we can set its x/y ranges
//    self.pieChart = [[CPTPieChart alloc] init];
//    self.pieChart.dataSource = self.securitiesViewController;
//    self.pieChart.delegate = self.securitiesViewController;
//    self.pieChart.pieRadius = (self.cPLayerHostingView.bounds.size.height * 0.6) / 2;
//    [graph addPlot:self.pieChart toPlotSpace:plotSpace];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.segmentedControl.enabled = NO;
    int selected = [segmentedControl selectedSegmentIndex];

    switch (selected) {
        case 0: {
            [UIView animateWithDuration:0.5 animations:^{
                self.securities.alpha = 1;
                self.depositories.alpha = 0;
                self.history.alpha = 0;
            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;
            }];
            break;
        }
        case 1: {
            [UIView animateWithDuration:0.5 animations:^{
                self.securities.alpha = 0;
                self.depositories.alpha = 1;
                self.history.alpha = 0;
            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;

            }];
            break;
        }
        case 2: {
            [UIView animateWithDuration:0.5 animations:^{
                self.securities.alpha = 0;
                self.depositories.alpha = 0;
                self.history.alpha = 1;

            }                completion:^(BOOL finished) {
                segmentedControl.enabled = YES;
            }];
            break;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"historySeque"]) {
        TransactionsViewController *destination = [segue destinationViewController];
        destination.selectedPaperName = self.historyViewController.selectedPaperName;
    }
}

- (IBAction)unwindToOverviewViewController:(UIStoryboardSegue *)unwindSegue {

    [UIView animateWithDuration:0.5 animations:^{
        self.securities.alpha = 0;
        self.depositories.alpha = 0;
        self.history.alpha = 1;

    }                completion:^(BOOL finished) {
        self.segmentedControl.enabled = YES;
    }];
}

//- (void)transactionsUpdated {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.pieChart reloadData];
//    });
//
//}


@end
