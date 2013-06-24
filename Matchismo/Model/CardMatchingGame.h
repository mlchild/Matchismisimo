//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Max Child on 6/22/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck withNumberOfCardsToMatch:(NSUInteger)matchCount;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int oldScore;
@property (nonatomic, readonly) NSString *matchStatus;

//I KNOW I KNOW I SHOULD IMPLEMENT THIS FOR THE 2-CARD GAME
@property (nonatomic, strong) NSArray *cardsInPlay;
@end
