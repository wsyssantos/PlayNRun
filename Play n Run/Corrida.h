//
//  Corrida.h
//  Play n Run
//
//  Created by Guilherme Munhoz on 06/11/13.
//  Copyright (c) 2013 Play n' Run. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ponto;

@interface Corrida : NSManagedObject

@property (nonatomic, retain) NSDate * dataCorrida;
@property (nonatomic, retain) NSSet *pontos;
@end

@interface Corrida (CoreDataGeneratedAccessors)

- (void)addPontosObject:(Ponto *)value;
- (void)removePontosObject:(Ponto *)value;
- (void)addPontos:(NSSet *)values;
- (void)removePontos:(NSSet *)values;

@end
