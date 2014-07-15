//
//  PNRAppDelegate.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 04/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
