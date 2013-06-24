//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Max Child on 6/22/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) int oldScore;
@property (nonatomic) NSUInteger matchCount;
@property (strong, nonatomic) NSString *matchStatus;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck withNumberOfCardsToMatch:(NSUInteger)matchCount {
    self = [super init];
    
    if (self) {
        self.matchCount = matchCount;
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}


#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.oldScore = self.score;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            //do we get a match?
            for (Card *otherCard in self.cards) {
                if (self.matchCount == 2) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            //a match
                            self.matchStatus = [NSString stringWithFormat:@"Matched %@ and %@",card.contents, otherCard.contents];
                            self.score += matchScore * MATCH_BONUS;
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            //a mismatch
                            self.matchStatus = [NSString stringWithFormat:@"%@ and %@ don't match",card.contents, otherCard.contents];
                        }
                        break;
                    }
                }
                
                if (self.matchCount == 3) {
                    //NSLog(@"trying to play 3 segment game");
                    Card *firstUpCard = nil;
                    Card *secondUpCard = nil;
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isFaceUp && !otherCard.isUnplayable && !firstUpCard) {
                            //first (maybe only) one other card faceUp/playable
                            firstUpCard = otherCard;
                        } else if (otherCard.isFaceUp && !otherCard.isUnplayable && firstUpCard) {
                            secondUpCard = otherCard;
                            //two cards faceUp/playable
                            int matchScore = [card match:@[firstUpCard, secondUpCard]];
                            if (matchScore) {
                                firstUpCard.unplayable = YES;
                                secondUpCard.unplayable = YES;
                                card.unplayable = YES;
                                //a match
                                self.matchStatus = [NSString stringWithFormat:@"Matched %@, %@, and %@",card.contents, firstUpCard.contents, secondUpCard.contents];
                                self.score += matchScore * MATCH_BONUS;
                            } else {
                                firstUpCard.faceUp = NO;
                                secondUpCard.faceUp = NO;
                                self.score -= MISMATCH_PENALTY;
                                //a mismatch
                                self.matchStatus = [NSString stringWithFormat:@"%@, %@, and %@ don't match",card.contents, firstUpCard.contents, secondUpCard.contents];
                            }
                            break;
                        }
                    }
                }
                
                //just a flip
                if (self.score == self.oldScore) {
                    self.matchStatus = [NSString stringWithFormat:@"%@ flippin out",card.contents];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

@end
