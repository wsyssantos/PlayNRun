//
//  PNRResultadoMapaViewController.m
//  Play n Run
//
//  Created by Guilherme Munhoz on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRResultadoMapaViewController.h"

#define kUpdateFrequency    60.0

@interface PNRResultadoMapaViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation PNRResultadoMapaViewController{
    float distanceToCancel;
    float maxDistanceToCancel;
    int addedCount;
    int cancelledCount;
    
    float px;
    float py;
    float pz;
    
    int stepCount;
    BOOL isChange;
    BOOL isSleeping;
    
    BOOL stepMode;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    distanceToCancel = 10;
    maxDistanceToCancel = 50;
    addedCount = 0;
    cancelledCount = 0;
    
    stepCount = 0;
    px = py = pz = 0;
    stepMode = NO;
    
    [self initLocationManager];
    [self initAcelerometer];
    
    MKMapRect mapRect = MKMapRectNull;
    NSInteger numberOfSteps = self.coordinates.count;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [self.coordinates objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coordinates[index] = coordinate;
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        MKMapRect pinRect = MKMapRectMake(point.x, point.y, 0.1, 0.1);
        
        mapRect = MKMapRectUnion(mapRect, pinRect);
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [self.map addOverlay:polyLine];
    [self.map setVisibleMapRect:mapRect edgePadding:UIEdgeInsetsMake(170.0, 70.0, 100.0, 70.0) animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor blueColor];
    polylineView.lineWidth = 10.0;
    
    return polylineView;
}

- (void)initLocationManager
{
    self.locations = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.delegate = self;
}

- (void)initAcelerometer
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self handleAcceleretionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(!stepMode){
        if(oldLocation != nil) {
            [self updateToLocation:newLocation];
        }
    } else {
        self.currentLocation = newLocation;
    }
    
}

- (void)handleAcceleretionData:(CMAcceleration)acceleration
{
    float xx = acceleration.x;
    float yy = acceleration.y;
    float zz = acceleration.z;
    
    float dot = (px * xx) + (py * yy) + (pz * zz);
    float a = ABS(sqrt(px * px + py * py + pz * pz));
    float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
    
    dot /= (a * b);
    
    if (dot <= 0.96) {
        if (!isSleeping) {
            isSleeping = YES;
            [self performSelector:@selector(wakeUp) withObject:nil afterDelay:0.4];
            stepCount += 1;
            
            if (self.currentLocation){
                [self updateToLocation:self.currentLocation];
            }
        }
    }
    
    px = xx; py = yy; pz = zz;
    
}

- (void)wakeUp {
    isSleeping = NO;
}

- (void)updateToLocation:(CLLocation*)newLocation
{
    if (self.locations.count > 0) {
        CLLocationDistance distance = [[self.locations objectAtIndex:self.locations.count-1] distanceFromLocation:newLocation];
        if (distance < distanceToCancel || distance > maxDistanceToCancel) {
            NSLog(@"## Ignoring coordinate... ##");
            cancelledCount += 1;
            return;
        }
    }
    
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        NSLog(@"App is active. lat: %.7f - lon: %.7f", newLocation.coordinate.latitude, newLocation.coordinate.latitude);
        
    }
    else
    {
        NSLog(@"App is backgrounded. lat: %.7f - lon: %.7f", newLocation.coordinate.latitude, newLocation.coordinate.latitude);
    }
    
    addedCount += 1;
    
    [self.locations addObject:newLocation];
}

-(void)didChangeDistance:(float)distance
{
    self.stepButton.title = [NSString stringWithFormat:@"%.0f", distance];
}


- (IBAction)trackingSwitchChanged:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PNROpcoesViewController *opcoesController = segue.destinationViewController;
    opcoesController.delegate = self;
}

@end
