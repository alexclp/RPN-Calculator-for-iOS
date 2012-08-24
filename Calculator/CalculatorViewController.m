//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alex Clapa on 25.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

#define PI 3.14

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL firstDigit;
@property (nonatomic) BOOL dotPressed;
@property (nonatomic) BOOL equalIsShown;

@end

@implementation CalculatorViewController

@synthesize historyLabel = _historyLabel;
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize firstDigit = _firstDigit;
@synthesize dotPressed = _dotPressed;
@synthesize equalIsShown = _equalIsShown;

- (CalculatorBrain *)brain 
{
    if(_brain == nil) 
        _brain = [[CalculatorBrain alloc] init];
    
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    /*
    NSString *digit = [sender currentTitle];
    UILabel *myDisplay = self.display; // [self display];
    NSString *currenText = myDisplay.text; // [myDisplay text];
    NSString *newText = [currenText stringByAppendingString:digit];
    myDisplay.text = newText; // [myDisplay setText:newText];
    */
    
    NSString *digit = [sender currentTitle];
    self.firstDigit = YES;
    
    if((self.historyLabel.text.length) && (self.equalIsShown)) {
        self.historyLabel.text = [self.historyLabel.text substringToIndex:(self.historyLabel.text.length - 1)];
        self.equalIsShown = NO;
    }
    
    if(self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.firstDigit = NO;
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    if ([@"." isEqualToString:digit]) {
        self.dotPressed = YES;
        if (self.firstDigit) {
            self.display.text = @"0.";
        }
    }
    
    
}
- (IBAction)operationPressed:(UIButton *)sender 
{
    if(self.userIsInTheMiddleOfEnteringANumber == YES) {
        [self enterPressed];
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.dotPressed = NO;
        self.firstDigit = NO;
    }
    
    NSString *operation = [sender currentTitle];
    
    double result = [self.brain performOperation:sender.currentTitle];
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:@" "];
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:operation];
    
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:@"="];
    
    self.equalIsShown = YES;
    
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:@" "];
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:resultString];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:@" "];
    self.historyLabel.text = [self.historyLabel.text stringByAppendingString:self.display.text];
}

- (IBAction)clearPressed 
{
    self.display.text = @"0";
    self.historyLabel.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain emptyStack];
    
}

- (IBAction)plusMinusPressed 
{
    self.display.text = [NSString stringWithFormat:@"%g", ([self.display.text doubleValue] * -1)];
}


- (IBAction)backSpacePressed 
{
    if(self.display.text.length) {
        self.display.text = [self.display.text substringToIndex:(self.display.text.length - 1)];
    }
}



- (void)viewDidUnload {
    [self setHistoryLabel:nil];
    [super viewDidUnload];
}

@end
