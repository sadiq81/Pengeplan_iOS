//
//  Transaction.h
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 02/03/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transaction : NSManagedObject

@property(nonatomic, retain) NSString *id;
@property(nonatomic, retain) NSString *transactionType;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *stockExchange;
@property(nonatomic, retain) NSString *currency;
@property(nonatomic, retain) NSNumber *numberOfItems;
@property(nonatomic, retain) NSNumber *valuation;
@property(nonatomic, retain) NSNumber *amount;
@property(nonatomic, retain) NSString *legalEntity;
@property(nonatomic, retain) NSString *ownedAccount;
@property(nonatomic, retain) NSNumber *localAmount;
@property(nonatomic, retain) NSString *username;

@end
