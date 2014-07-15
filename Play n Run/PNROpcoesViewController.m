//
//  PNROpcoesViewController.m
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNROpcoesViewController.h"
#import "PNRPlayerViewController.h"
#import "PNRResultadoMapaViewController.h"
#import "Corrida.h"
#import "Ponto.h"

@interface PNROpcoesViewController ()

@end

@implementation PNROpcoesViewController{
    float distanceToCancel;
    float maxDistanceToCancel;
    int addedCount;
    int cancelledCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    distanceToCancel = 10;
    maxDistanceToCancel = 50;
    addedCount = 0;
    cancelledCount = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)distanceStepperChanged:(id)sender {
    distanceToCancel = self.distanceStepper.value;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0f", self.distanceStepper.value];
    [self.delegate didChangeDistance:distanceToCancel];
}

- (IBAction)maxDistanceStepperChanged:(id)sender {
    maxDistanceToCancel = self.maxDistanceStepper.value;
    self.maxDistanceLabel.text = [NSString stringWithFormat:@"%.0f", self.maxDistanceStepper.value];
}

- (IBAction)limparTapped:(id)sender {
    addedCount = 0;
    cancelledCount = 0;

    self.stepLabel.text = @"0";
}

- (IBAction)stepModeSwitchChanged:(id)sender {
//    if (self.stepModeSwitch.isOn) {
//        stepMode = YES;
//        self.stepModeLabel.text = @"Ligado";
//    } else {
//        stepMode = NO;
//        self.stepModeLabel.text = @"Desligado";
//    }
}

- (IBAction)fecharTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
