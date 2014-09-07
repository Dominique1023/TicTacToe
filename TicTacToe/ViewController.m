//
//  ViewController.m
//  TicTacToe
//
//  Created by Dominique on 9/7/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
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
    CGPoint tapped = [tapGestureRecognizer locationInView:self.view];

   self.activeLabel = [self findLabelUsingPoint:tapped];
    [self whoseTurn];

    //Displays the coordinates of the label tapped
    //NSLog(@"x: %f   y:%f", tapped.x, tapped.y);


}

-(void)whoseTurn{
    //1 = X : 2 = Y

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

@end























