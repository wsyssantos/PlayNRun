//
//  PNRResultadoMapaViewController.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>

#import "PNROpcoesViewController.h"

@interface PNRResultadoMapaViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate, UIAccelerometerDelegate, OpcoesDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *coordinates;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trackingSwitch;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addedButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *canceledButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stepButton;

- (IBAction)trackingSwitchChanged:(id)sender;

@end
