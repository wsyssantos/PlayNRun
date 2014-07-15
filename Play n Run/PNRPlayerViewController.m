//
//  PNRPlayerViewController.m
//  Play n Run
//
//  Created by Guilherme Munhoz on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRPlayerViewController.h"
#import "PNRResultadoMapaViewController.h"
#import "Corrida.h"
#import "Ponto.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PNRPlayerViewController ()

@property(nonatomic, strong)MPMusicPlayerController *musicPlayer;

@end

@implementation PNRPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];

    [self playListOfMusics];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)playListOfMusics
{
    if([self.arrMusicas count] > 0)
    {
        [self.musicPlayer setShuffleMode:MPMusicShuffleModeSongs];
        [self.musicPlayer setRepeatMode:MPMusicRepeatModeAll];
        MPMediaItemCollection *allSongs = [[MPMediaItemCollection alloc] initWithItems:self.arrMusicas];
        [self.musicPlayer setQueueWithItemCollection:allSongs];
        [self.musicPlayer play];
    }
}

//- (IBAction)salvarTapped:(id)sender {
//    
//    [self.locationManager stopUpdatingLocation];
//    self.trackingLabel.text = @"Desligado";
//    self.currentLocation = nil;
//    
//    Corrida *novaCorrida = [NSEntityDescription insertNewObjectForEntityForName:@"Corrida" inManagedObjectContext:self.managedObjectContext];
//    
//    novaCorrida.dataCorrida = [NSDate date];
//    
//    for (CLLocation *l in self.locations){
//        Ponto *novoPonto = [NSEntityDescription insertNewObjectForEntityForName:@"Ponto" inManagedObjectContext:self.managedObjectContext];
//        
//        novoPonto.corrida = novaCorrida;
//        novoPonto.latitude = l.coordinate.latitude;
//        novoPonto.longitude = l.coordinate.longitude;
//        
//        [novaCorrida addPontosObject:novoPonto];
//    }
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![self.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    } else {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.musicPlayer stop];
}

@end
