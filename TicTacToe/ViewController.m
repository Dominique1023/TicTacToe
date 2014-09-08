//
//  ViewController.m
//  TicTacToe
//
//  Created by Dominique on 9/7/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (weak, nonatomic) UILabel *activeLabel;
@property NSArray *labels;
@property int whoseTurnIsIt;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.labels = [[NSArray alloc]initWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];

    self.whoseTurnIsIt = 1;
}

-(UILabel *)findLabelUsingPoint:(CGPoint)point{
    for (UILabel *label in self.labels) {
        if (CGRectContainsPoint(label.frame, point)) {
            return label;
        }
    }

    return nil;
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer{
    //creating a point tapped on the label
    CGPoint tapped = [tapGestureRecognizer locationInView:self.view];

    //activeLabel is the label that was tapped
    self.activeLabel = [self findLabelUsingPoint:tapped];

    [self whoseTurn];
    [self gameLogic];

    //Displays the coordinates of the label tapped
    //NSLog(@"x: %f   y:%f", tapped.x, tapped.y);
}


//Changes the players turn
-(void)whoseTurn{
    //1 = X : 2 = Y

    //if the label is not empty than dont change anything, else change the labels text
    //to the appropriate player
    if (![self.activeLabel.text isEqual: @""]) {
        return;
    }else{
        if (self.whoseTurnIsIt == 1) {
            self.activeLabel.text = @"X";
            self.whichPlayerLabel.text = @"Player O Turn";
            self.whoseTurnIsIt++;

        }else if (self.whoseTurnIsIt == 2){
            self.activeLabel.text = @"O";
            self.whichPlayerLabel.text = @"Player X Turn";
            self.whoseTurnIsIt--;
        }
    }
}

//TicTacToe Game Logic
-(void)gameLogic{

    //Left to Right Wins from top to bottom
    if ([self.labelOne.text isEqualToString:self.labelTwo.text] && [self.labelTwo.text isEqualToString:self.labelThree.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    if ([self.labelFour.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelSix.text] && ![self.labelFour.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    if ([self.labelSeven.text isEqualToString:self.labelEight.text] && [self.labelEight.text isEqualToString:self.labelNine.text] && ![self.labelSeven.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    //Top To Bottom wins from left to right
    if ([self.labelOne.text isEqualToString:self.labelFour.text] && [self.labelFour.text isEqualToString:self.labelSeven.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    if ([self.labelTwo.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelEight.text] && ![self.labelTwo.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    if ([self.labelThree.text isEqualToString:self.labelSix.text] && [self.labelSix.text isEqualToString:self.labelNine.text] && ![self.labelThree.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    //Diagonal Left to Right
    if ([self.labelOne.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelNine.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }

    //Diagonal Right to Left
    if ([self.labelThree.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelSeven.text] && ![self.labelThree.text isEqualToString:@""]) {
        [self winnerwinner];
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Player %@ Wins", self.activeLabel.text];
    }
}

-(void)winnerwinner{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Congrats!" message:[NSString stringWithFormat:@"Player %@ is The Winner", self.activeLabel.text] delegate:self cancelButtonTitle:@"Great" otherButtonTitles:@"Play Again", nil];

    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        self.labelOne.text = @"";
        self.labelTwo.text = @"";
        self.labelThree.text = @"";
        self.labelFour.text = @"";
        self.labelFive.text = @"";
        self.labelSix.text = @"";
        self.labelSeven.text = @"";
        self.labelEight.text = @"";
        self.labelNine.text = @"";

        if (self.whoseTurnIsIt == 1) {
            self.whichPlayerLabel.text = @"Player X Turn";
        }else if(self.whoseTurnIsIt == 2){
            self.whichPlayerLabel.text = @"Player O Turn";
        }
    }
}


@end























