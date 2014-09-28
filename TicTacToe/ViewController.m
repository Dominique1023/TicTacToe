//
//  ViewController.m
//  TicTacToe
//
//  Created by Dominique on 9/7/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "ViewController.h"
#define time 3;

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
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property BOOL isTimerRunning;
@property NSTimer *timer;
@property NSInteger timerCount;
@property (weak, nonatomic) UILabel *activeLabel;
@property NSArray *labels;
@property int whoseTurnIsIt;
@property UIAlertView *outOfTimeAlertView;
@property UIAlertView *winnerWinnerAlertView;
@property UIAlertView *tieAlertView;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147 green:191 blue:191 alpha:0];

    self.labels = [[NSArray alloc]initWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];

    self.timerCount = 1;
    self.whoseTurnIsIt = 1;
}

-(IBAction)onResetButtonPressed:(id)sender {
    for (UILabel *label in self.labels) {
        label.text = @"";
    }

    if (self.whoseTurnIsIt == 1) {
        self.whichPlayerLabel.text = @"Player X";
    }else if(self.whoseTurnIsIt == 2){
        self.whichPlayerLabel.text = @"Player O";
    }

    self.timerCount = time;
    self.timerLabel.text = @"3";
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
    [self startTimer];

    //creating a point tapped on the label
    CGPoint tapped = [tapGestureRecognizer locationInView:self.view];

    //activeLabel is the label that was tapped
    self.activeLabel = [self findLabelUsingPoint:tapped];

    [self whoseTurn];
    [self gameLogic];

}

#pragma mark CLOCK SETTINGS
-(void)startTimer{
    if (self.isTimerRunning == false) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
        self.isTimerRunning = true;
    }
}

-(void)timerTick{
    if (self.timerCount == 1) {


        [self stopTheClock];

        self.outOfTimeAlertView = [[UIAlertView alloc]initWithTitle:@"Out of Time!" message:[NSString stringWithFormat:@"Next Player"] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];

        [self.outOfTimeAlertView show];
    }

    if (self.timerCount > 1) {
        self.timerCount -= 1;
        self.timerLabel.text = [NSString stringWithFormat:@"%ld", (long)self.timerCount];
    }


}

-(void)stopTheClock{
    self.timerCount = 4;
    [self.timer invalidate];
    self.isTimerRunning = false;
}

-(void)restartTheClock{
    self.timerCount = time;
    self.timerLabel.text = @"3";
}

//Changes the players turn
#pragma mark GAME FUNCTIONALITY
-(void)whoseTurn{
    //1 = X : 2 = Y

    //if the label is not empty than dont change anything, else change the labels text
    //to the appropriate player
    if (![self.activeLabel.text isEqual: @""]) {
        return;
    }else{
        if (self.whoseTurnIsIt == 1) {
            self.activeLabel.text = @"X";
            self.whichPlayerLabel.text = @"Player O";
            self.timerCount = time;
            self.timerLabel.text = [NSString stringWithFormat:@"%ld", (long)self.timerCount];

            self.whoseTurnIsIt++;

        }else if (self.whoseTurnIsIt == 2){
            self.activeLabel.text = @"O";
            self.whichPlayerLabel.text = @"Player X";
            self.timerCount = time;
            self.timerLabel.text = [NSString stringWithFormat:@"%ld", (long)self.timerCount];

            self.whoseTurnIsIt--;
            
        }
    }
}

-(void)winnerwinner{
    [self stopTheClock];

    self.winnerWinnerAlertView = [[UIAlertView alloc]initWithTitle:@"Congrats!" message:[NSString stringWithFormat:@"Player %@ is The Winner", self.activeLabel.text] delegate:self cancelButtonTitle:@"Great" otherButtonTitles:@"Play Again", nil];

    [self.winnerWinnerAlertView show];
}

//TicTacToe Game Logic
-(void)gameLogic{

    //winner from top to bottom rows
    if ([self.labelOne.text isEqualToString:self.labelTwo.text] && [self.labelTwo.text isEqualToString:self.labelThree.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

    }else if ([self.labelFour.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelSix.text] && ![self.labelFour.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];


    }else if ([self.labelSeven.text isEqualToString:self.labelEight.text] && [self.labelEight.text isEqualToString:self.labelNine.text] && ![self.labelSeven.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

        //Winner from left to right columns
    }else if ([self.labelOne.text isEqualToString:self.labelFour.text] && [self.labelFour.text isEqualToString:self.labelSeven.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];


    } else if ([self.labelTwo.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelEight.text] && ![self.labelTwo.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

    }else if ([self.labelThree.text isEqualToString:self.labelSix.text] && [self.labelSix.text isEqualToString:self.labelNine.text] && ![self.labelThree.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

        //winner left to right diagonal
    }else if ([self.labelOne.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelNine.text] && ![self.labelOne.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

        //winner right to left diagonal
    }else if ([self.labelThree.text isEqualToString:self.labelFive.text] && [self.labelFive.text isEqualToString:self.labelSeven.text] && ![self.labelThree.text isEqualToString:@""]) {
        [self winnerwinner];

        self.whichPlayerLabel.text = [NSString stringWithFormat:@"%@", self.activeLabel.text];

        //no winner, TIE
    }else if (![self.labelOne.text isEqualToString:@""] && ![self.labelTwo.text isEqualToString:@""] && ![self.labelThree.text isEqualToString:@""]
              && ![self.labelFour.text isEqualToString:@""] && ![self.labelFive.text isEqualToString:@""] && ![self.labelSix.text isEqualToString:@""]
              && ![self.labelSeven.text isEqualToString:@""] && ![self.labelEight.text isEqualToString:@""] && ![self.labelNine.text isEqualToString:@""]){


        self.tieAlertView = [[UIAlertView alloc]initWithTitle:@"TIE!" message:@"No Winner, Try Again!" delegate:self cancelButtonTitle:@"Great" otherButtonTitles:@"Play Again", nil];
        
        [self.tieAlertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == self.winnerWinnerAlertView) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [self onResetButtonPressed:self];
            [self restartTheClock];
        }
    }

    if (alertView == self.outOfTimeAlertView) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            [self restartTheClock];

        }
    }

    if (alertView == self.tieAlertView) {
        [self restartTheClock];
        [self onResetButtonPressed:self]; 
    }
}

@end























