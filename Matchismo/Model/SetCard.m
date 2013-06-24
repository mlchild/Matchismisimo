//
//  SetCard.m
//  Matchismo
//
//  Created by Max Child on 6/23/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


/*
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.color];
}
 */

@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shading = _shading;

+ (NSArray *)validSymbols {
    
    NSArray *validSymbols = nil;
    if (!validSymbols) validSymbols = @[@"▲", @"●", @"◼"];
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
    if (!validShadings) validShadings = @[@"filled", @"blank", @"grey"];
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



+ (NSArray *)numberStrings {
    return @[@"?",@"1",@"2",@"3"];
}


+ (NSUInteger)maxNumber {
    return [self numberStrings].count-1;
}



@end
