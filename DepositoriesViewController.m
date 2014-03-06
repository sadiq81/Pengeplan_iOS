//
// Created by Tommy Sadiq Hinrichsen on 03/03/14.
// Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import "DepositoriesViewController.h"


@implementation DepositoriesViewController {

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

    [fetchRequest setPropertiesToFetch:@[@"ownedAccount", expressionDescription]];
    [fetchRequest setPropertiesToGroupBy:@[@"ownedAccount"]];
    [fetchRequest setResultType:NSDictionaryResultType];

    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"ownedAccount" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByName]];

    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                  managedObjectContext:self.managedObjectContext
                                                                                                    sectionNameKeyPath:nil
                                                                                                             cacheName:nil];

    self.fetchedResultsController = theFetchedResultsController;
    self.fetchedResultsController.delegate = self;
    return self.fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    NSObject *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *ownedAccount = [[info valueForKey:@"ownedAccount"] substringToIndex:[[info valueForKey:@"ownedAccount"] length] > 10 ? 10 : [[info valueForKey:@"ownedAccount"] length]];
    ownedAccount = [ownedAccount substringToIndex:[ownedAccount rangeOfString:@"-" options:NSBackwardsSearch].location];
    NSString *sumOfAmount = [info valueForKey:@"sumOfAmount"];
    //TODO get local currency from server
    NSString *currency = @"DKK";
    NSString *combined = [NSString stringWithFormat:@"%@%@%@", sumOfAmount, @" ", currency];

    cell.textLabel.text = ownedAccount;
    cell.detailTextLabel.text = combined;
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


@end