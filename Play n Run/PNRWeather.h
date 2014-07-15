//
//  PNRWeather.h
//  Play n Run
//
//  Created by Diones Camargo on 05/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNRWeather : NSObject

@property(nonatomic, strong)NSString *temperatura;
@property(nonatomic, strong)NSString *metrica;

+ (PNRWeather *) comDicionario: (NSDictionary *) dicionario;

@end
