//
//  PNROpcoesViewController.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OpcoesDelegate <NSObject>

-(void)didChangeDistance:(float)distance;

@end

@interface PNROpcoesViewController : UIViewController

@property (weak) id<OpcoesDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxDistanceLabel;
@property (weak, nonatomic) IBOutlet UIStepper *distanceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *maxDistanceStepper;
@property (weak, nonatomic) IBOutlet UISwitch *stepModeSwitch;

- (IBAction)distanceStepperChanged:(id)sender;
- (IBAction)maxDistanceStepperChanged:(id)sender;
- (IBAction)limparTapped:(id)sender;
- (IBAction)stepModeSwitchChanged:(id)sender;
- (IBAction)fecharTapped:(id)sender;

@end
