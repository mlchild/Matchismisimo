//
//  SetCard.h
//  Matchismo
//
//  Created by Max Child on 6/23/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *color; //stroke
@property (strong, nonatomic) NSString *shading; //fill

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
