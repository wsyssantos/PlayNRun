//
//  PNRWeather.m
//  Play n Run
//
//  Created by Diones Camargo on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import "PNRWeather.h"

@implementation PNRWeather

+ (PNRWeather *) comDicionario: (NSDictionary *) dicionario {
    
    
    PNRWeather * wheater = [[PNRWeather alloc] init];
    [wheater setTemperatura: [[[[[[dicionario objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"condition"] objectForKey:@"temp"]];
    
    [wheater setMetrica:[[[[[dicionario objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"units"] objectForKey:@"temperature"]];
    
    return wheater;
}

@end
