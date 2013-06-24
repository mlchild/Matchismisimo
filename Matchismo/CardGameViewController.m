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
#import "SetCardDeck.h"

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
        
        
        NSLog(@"Contents: %@ for index: %d", card.contents, [self.cardButtons indexOfObject:cardButton]);
        
        //introspect here and use attributed strings if it's a set game
        //use card.attributedContents
        if ([card isMemberOfClass:[SetCard class]]) {
            
            SetCard *setCard = (SetCard *)card;
            
            //STROKE AND FILLCOLOR MISNAMED
            //NSLog(@"FillString: %@", setCard.color);
            UIColor *fillColor = nil;
            if ([setCard.color  isEqual: @"green"]) {
                fillColor = [UIColor greenColor];
            } else if ([setCard.color  isEqual: @"blue"]) {
                fillColor = [UIColor blueColor];
            } else if ([setCard.color  isEqual: @"red"]) {
                fillColor = [UIColor redColor];
            }
            //NSLog(@"Fill: %@", fillColor);
            
            //STROKE AND FILLCOLOR MISNAMED
            UIColor *strokeColor = nil;
            if ([setCard.shading isEqual: @"filled"]) {
                strokeColor = fillColor;
            } else if ([setCard.shading isEqual: @"blank"]) {
                strokeColor = [UIColor whiteColor];
            } else if ([setCard.shading  isEqual: @"gray"]) {
                strokeColor = [UIColor grayColor];
            }
            //NSLog(@"%@", strokeColor);
             
            NSDictionary *attributes =
            @{NSForegroundColorAttributeName : strokeColor,
              NSStrokeWidthAttributeName : @-2,
              NSStrokeColorAttributeName : fillColor};
            
            NSMutableAttributedString *cardAttributedTitle = [[NSMutableAttributedString alloc] initWithString:setCard.contents attributes:attributes];
            
            [cardButton setAttributedTitle:cardAttributedTitle forState:UIControlStateNormal];
            NSLog(@"Title: %@", cardButton.currentAttributedTitle);
            
        } else {
            [cardButton setTitle:card.contents forState:UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        }
        
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.05 : 1.0;
        

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
