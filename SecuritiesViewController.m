//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "SecuritiesViewController.h"


@implementation SecuritiesViewController {

}

- (NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"localAmount"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    NSObject *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *paperName = [[info valueForKey:@"paperName"] substringToIndex:[[info valueForKey:@"paperName"] length] > 10 ? 10 : [[info valueForKey:@"paperName"] length]];
    NSString *sumOfAmount = [info valueForKey:@"sumOfAmount"];
    NSString *currency = [info valueForKey:@"currency"];
    NSString *combined = [NSString stringWithFormat:@"%@%@%@", sumOfAmount, @" ", currency];

    cell.textLabel.text = paperName;
    cell.detailTextLabel.text = combined;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

@end