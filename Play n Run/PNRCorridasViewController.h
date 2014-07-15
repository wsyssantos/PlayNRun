//
//  PNRCorridasViewController.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNRCorridasViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
