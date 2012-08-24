//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Alex Clapa on 25.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

- (IBAction)enterPressed;
- (IBAction)clearPressed;
- (IBAction)plusMinusPressed;
- (IBAction)backSpacePressed;


@end
