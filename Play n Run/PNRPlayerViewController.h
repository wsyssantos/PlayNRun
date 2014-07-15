//
//  PNRPlayerViewController.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>

@interface PNRPlayerViewController : UIViewController<CLLocationManagerDelegate, UIAccelerometerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong)NSMutableArray *arrMusicas;

@end
