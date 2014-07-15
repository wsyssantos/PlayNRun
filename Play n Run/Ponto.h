//
//  Ponto.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Corrida;

@interface Ponto : NSManagedObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) Corrida *corrida;

@end
