//
//  AppDelegate.h
//  Pengeplan IOS
//
//  Created by Tommy Sadiq Hinrichsen on 26/02/14.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PengeplanAPI;


@interface AppDelegate : UIResponder <UIApplicationDelegate> {

}
@property(strong, nonatomic) UIWindow *window;

@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

- (void)setupObjectManager;

- (void)setupCoreData;

- (void)setupMappings;

@end
