//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <CorePlot/CPTPlatformSpecificCategories.h>
#import <CorePlot/CPTTextLayer.h>
#import <CorePlot/CPTPlotRange.h>
#import <CorePlot/CPTGraphHostingView.h>
#import "SecuritiesViewController.h"
#import "CPTPieChart.h"
#import "CPTMutableTextStyle.h"
#import "CPTXYGraph.h"
#import "CPTXYPlotSpace.h"
#import "CPTUtilities.h"


@implementation SecuritiesViewController {

}

- (id)initWithTableView:(UITableView *)uiTableView viewController:(UIViewController *)uiViewController {
    self = [super initWithTableView:uiTableView viewController:uiViewController];
    if (self) {


    }

    return self;
}


- (NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"amount"];
    NSExpression *sumOfCountExpression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:keyPathExpression]];

    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"sumOfAmount"];
    [expressionDescription setExpression:sumOfCountExpression];
    [expressionDescription setExpressionResultType:NSFloatAttributeType];

    [fetchRequest setPropertiesToFetch:@[@"paperName", @"currency", expressionDescription]];
    [fetchRequest setPropertiesToGroupBy:@[@"paperName", @"currency"]];
    [fetchRequest setResultType:NSDictionaryResultType];

    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"paperName" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByName]];

    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                  managedObjectContext:self.managedObjectContext
                                                                                                    sectionNameKeyPath:nil
                                                                                                             cacheName:nil];

    self.fetchedResultsController = theFetchedResultsController;
    self.fetchedResultsController.delegate = self;
    return self.fetchedResultsController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController fetchedObjects] count] + 1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item == 0) {


        CPTGraphHostingView *cPLayerHostingView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 320, 219)];


        CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:cPLayerHostingView.bounds];
        // Get the (default) plotspace from the graph so we can set its x/y ranges
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;

        // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
        [plotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(16)]];
        [plotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-4) length:CPTDecimalFromFloat(8)]];

        graph.axisSet = nil;

        cPLayerHostingView.hostedGraph = graph;

        // Get the (default) plotspace from the graph so we can set its x/y ranges
        CPTPieChart *pieChart = [[CPTPieChart alloc] init];
        pieChart.dataSource = self;
        pieChart.delegate = self;
        pieChart.pieRadius = (cPLayerHostingView.bounds.size.height * 0.6) / 2;
        [graph addPlot:pieChart toPlotSpace:plotSpace];

        [cell.contentView addSubview:cPLayerHostingView];
        return;
    }

    NSObject *info = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.item - 1];
    NSString *paperName = [[info valueForKey:@"paperName"] substringToIndex:[[info valueForKey:@"paperName"] length] > 10 ? 10 : [[info valueForKey:@"paperName"] length]];
    NSString *sumOfAmount = [info valueForKey:@"sumOfAmount"];
    NSString *currency = [info valueForKey:@"currency"];
    NSString *combined = [NSString stringWithFormat:@"%@%@%@", sumOfAmount, @" ", currency];

    cell.textLabel.text = paperName;
    cell.detailTextLabel.text = combined;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath item] == 0 ){
        return 219;
    } else{
        return 44;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {

    if (idx >= [[self.fetchedResultsController fetchedObjects] count]) {
        return nil;
    }
    if (fieldEnum == CPTPieChartFieldSliceWidth) {
        NSObject *transaction = [self.fetchedResultsController.fetchedObjects objectAtIndex:idx];
        NSNumber *value = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [transaction valueForKey:@"sumOfAmount"]] intValue]];
        return value;
    }
    else {
        return [NSNumber numberWithInt:idx];
    }
}

- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)idx {

    static CPTMutableTextStyle *labelText = nil;
    if (!labelText) {
        labelText = [[CPTMutableTextStyle alloc] init];
        labelText.color = [CPTColor grayColor];
    }

    //TODO Only calculate once
    NSNumber *totalValue = [NSNumber numberWithInt:0];
    for (NSObject *paperName in self.fetchedResultsController.fetchedObjects) {
        NSNumber *value = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [paperName valueForKey:@"sumOfAmount"]] intValue]];
        totalValue = @([totalValue floatValue] + [value floatValue]);
    }

    NSObject *transaction = [self.fetchedResultsController.fetchedObjects objectAtIndex:idx];

    int length = [[NSString stringWithFormat:@"%@", [transaction valueForKey:@"paperName"]] length];
    NSString *paperName = [[NSString stringWithFormat:@"%@", [transaction valueForKey:@"paperName"]] substringToIndex: length > 2 ? 3 : length];
    NSNumber *value = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [transaction valueForKey:@"sumOfAmount"]] floatValue]];
    NSNumber *percentage = @(([value floatValue] / [totalValue floatValue]) * 100);

    NSNumberFormatter *twoDecimalPlacesFormatter = [[NSNumberFormatter alloc] init];
    [twoDecimalPlacesFormatter setMaximumFractionDigits:2];
    [twoDecimalPlacesFormatter setMinimumFractionDigits:0];


    NSString *formattedPercentage = [twoDecimalPlacesFormatter stringFromNumber:percentage];

    NSString *label = [NSString stringWithFormat:@"%@%@%@%@", paperName, @" ", formattedPercentage, @" %"];
    return [[CPTTextLayer alloc] initWithText:label style:labelText];
}

@end