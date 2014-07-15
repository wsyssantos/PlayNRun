//
//  PNRHomeViewController.m
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRHomeViewController.h"
#import "PNRPlaylistViewController.h"
#import "PNRCorridasViewController.h"
#import "PNRWeather.h"

#define kJSONURL @"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D2344868%20AND%20u%3D'c'&format=json&diagnostics=true&callback="

@interface PNRHomeViewController ()

@end

@implementation PNRHomeViewController

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
    
//    [self runReadJSON];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showPlaylist"]){
        PNRPlaylistViewController *playlistController = segue.destinationViewController;
        playlistController.managedObjectContext = self.managedObjectContext;
    } else if ([segue.identifier isEqualToString:@"showCorridas"]){
        PNRCorridasViewController *corridasController = segue.destinationViewController;
        corridasController.managedObjectContext = self.managedObjectContext;
    }
    
}

- (void)runReadJSON {
    
	NSURL *url = [NSURL URLWithString:kJSONURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSURLResponse *response = NULL;
	NSError *error = NULL;
	NSData *retValue = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if (!error) {
        [self updateWeather:retValue];
	}
}

- (void)updateWeather:(NSData *)aJSONData {
    NSError *error;
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:aJSONData options:kNilOptions error:&error];
	if (!error) {
        
        PNRWeather *weather = [PNRWeather comDicionario: jsonResult];
        self.temperatureLabel.text = [[weather.temperatura stringByAppendingString:@"° "] stringByAppendingString:weather.metrica];
        
        NSLog(@"%@", [[weather.temperatura stringByAppendingString:@" "] stringByAppendingString:weather.metrica]);
    }
}


@end
