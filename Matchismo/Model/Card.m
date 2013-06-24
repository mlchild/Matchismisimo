//
//  Card.m
//  Matchismo
//
//  Created by Max Child on 6/22/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
