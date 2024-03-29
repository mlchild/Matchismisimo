//
//  SetCard.m
//  Matchismo
//
//  Created by Max Child on 6/23/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    
    if (([self.symbol isEqual:firstCard.symbol] &&
         [self.symbol isEqual:secondCard.symbol]) ||
        (![self.symbol isEqual:firstCard.symbol] &&
         ![self.symbol isEqual:secondCard.symbol] &&
         ![firstCard.symbol isEqual:secondCard.symbol])) {
            NSLog(@"Symbol match");
        if (([self.color isEqual:firstCard.color] &&
             [self.color isEqual:secondCard.color]) ||
            (![self.color isEqual:firstCard.color] &&
             ![self.color isEqual:secondCard.color] &&
             ![firstCard.color isEqual:secondCard.color])) {
                NSLog(@"Symbol and color match");
            if (([self.shading isEqual:firstCard.shading] &&
                 [self.shading isEqual:secondCard.shading]) ||
                (![self.shading isEqual:firstCard.shading] &&
                 ![self.shading isEqual:secondCard.shading] &&
                 ![firstCard.shading isEqual:secondCard.shading])) {
                    NSLog(@"Symbol, color, shading match");
                    NSLog(@"Numbers: %d %d %d", self.number, firstCard.number, secondCard.number);
                if ((self.number == firstCard.number &&
                     self.number == secondCard.number) ||
                    (self.number != firstCard.number &&
                     self.number != secondCard.number &&
                     firstCard.number != secondCard.number)) {
                        NSLog(@"SET match");
                        score = 1;
                    }
                }
            }
        }
    
    return score;
}


- (NSString *)contents {
    
    NSString *contents = @"";
    for (int i=0; i<self.number; i++) {
        contents = [contents stringByAppendingString:self.symbol];
        }
    //NSLog(@"Contents: %@", contents);
    return contents;

}


@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shading = _shading;

+ (NSArray *)validSymbols {
    
    NSArray *validSymbols = nil;
    if (!validSymbols) validSymbols = @[@"▲", @"●", @"■"];
    return validSymbols;
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

+ (NSArray *)validColors {
    
    NSArray *validColors = nil;
    if (!validColors) validColors = @[@"green", @"blue", @"red"];
    return validColors;
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color {
    return _color ? _color : @"?";
}

+ (NSArray *)validShadings {
    
    NSArray *validShadings = nil;
    if (!validShadings) validShadings = @[@"filled", @"blank", @"gray"];
    return validShadings;
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}


//probably more complicated than necessary but OH WELL
+ (NSArray *)numbers {
    return @[@1,@2,@3];
}


+ (NSUInteger)maxNumber {
    return [self numbers].count;
}



@end
