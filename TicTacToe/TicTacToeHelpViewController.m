//
//  TicTacToeHelpViewController.m
//  TicTacToe
//
//  Created by Dominique on 9/7/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "TicTacToeHelpViewController.h"

@interface TicTacToeHelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TicTacToeHelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *urlString = @"http://en.wikipedia.org/wiki/Tic-tac-toe";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request]; 

}

@end
