//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Max Child on 6/23/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "SetCardDeck.h"


@implementation SetCardDeck

- (id)init{
    
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card atTop:YES];
                        //NSLog(@"%d %@ %@ %@", card.number, card.symbol, card.color, card.shading);
                    }
                }
            }
        }
    }
    return self;
}

@end
