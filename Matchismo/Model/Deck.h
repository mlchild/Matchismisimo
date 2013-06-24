//
//  Deck.h
//  Matchismo
//
//  Created by Max Child on 6/22/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
