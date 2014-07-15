//
//  PNRViewController.m
//  Play n Run
//
//  Created by Diones Camargo on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRViewController.h"
#import "PNRWeather.h"

#define kJSONURL @"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D2344868%20AND%20u%3D'c'&format=json&diagnostics=true&callback="

@interface PNRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;

@end

@implementation PNRViewController

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
    [self runReadJSON];
    
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
        self.labelTemperature.text = [[weather.temperatura stringByAppendingString:@"° "] stringByAppendingString:weather.metrica];
        
        NSLog(@"%@", [[weather.temperatura stringByAppendingString:@" "] stringByAppendingString:weather.metrica]);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
