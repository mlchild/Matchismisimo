//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Max Child on 6/23/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetCardGameViewController

#define SET_GAME_CARD_COUNT 24
#define SET_GAME_MATCH_COUNT 3

- (CardMatchingGame *)game {
    
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:SET_GAME_CARD_COUNT usingDeck:[[SetCardDeck alloc] init] withNumberOfCardsToMatch:SET_GAME_MATCH_COUNT];
    }
    return _game;
}

@end
