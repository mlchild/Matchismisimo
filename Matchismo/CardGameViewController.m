//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Max Child on 6/21/13.
//  Copyright (c) 2013 Max Child. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatHappenedLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSelected;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

//testing git

- (CardMatchingGame *)game {
    
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] withNumberOfCardsToMatch:self.gameTypeSelected.selectedSegmentIndex+2];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    
    //segmented control enabled?
    if (self.flipCount == 0) {
        self.gameTypeSelected.enabled = YES;
    } else {
        self.gameTypeSelected.enabled = NO;
    }
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!cardButton.selected) {
            [cardButton setImage:[UIImage imageNamed:@"lil wayne.jpg"] forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        

    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    int scoreChange = self.game.score - self.game.oldScore;
    if (self.game.matchStatus) {
        self.whatHappenedLabel.text = [NSString stringWithFormat:@"%@ for %d points", self.game.matchStatus, scoreChange];
    } else {
        self.whatHappenedLabel.text = [NSString stringWithFormat:@"Let's get started!"];
    }
}

- (void)setFlipCount:(int)flipCount {
    
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    //NSLog(@"Flips updated to %d",self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {

    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)redealGame:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)chooseGameType:(UISegmentedControl *)sender {
    self.game = nil;
    [self updateUI];
    
}


@end
