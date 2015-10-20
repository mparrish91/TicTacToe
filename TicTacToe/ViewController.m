//
//  ViewController.m
//  TicTacToe
//
//  Created by Malcolm Parrish on 10/9/15.
//  Copyright © 2015 WordWise. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerNextLabel;
@property NSArray *labelArray;
@property UILabel *selectedLabel;
@property NSString *winner;
@property NSArray *winningCombinations;
@property NSMutableArray *currentGameArray;

//@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.whichPlayerNextLabel.text = @"O";
    self.winner = @"nowinner";
    self.labelArray = [NSArray arrayWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];
    self.currentGameArray = [NSMutableArray array];

    }


- (void)findLabelUsingPoint:(CGPoint)point{
    for (UILabel *label in self.labelArray) {
        if (CGRectContainsPoint(label.frame, point)) {
            self.selectedLabel = label;
        }
    }
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    [self findLabelUsingPoint:point];
    if ([self.whichPlayerNextLabel.text  isEqualToString:@"O"] ) {
        self.selectedLabel.backgroundColor = [UIColor redColor];
        self.selectedLabel.text = @"O";
        self.whichPlayerNextLabel.text = @"X";
        
    }else{
        
        self.selectedLabel.backgroundColor = [UIColor blueColor];
        self.selectedLabel.text = @"X";
        self.whichPlayerNextLabel.text = @"O";
    }
    
    //Did someone win?
    [self whoWon];
        
    //Winner?
    if (![self.winner isEqualToString:@"nowinner"]) {
        NSString *winMessage = [NSString stringWithFormat:@"Player %@ won!",self.winner];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:winMessage message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Play Again?" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                        [self viewDidLoad];
                        
                    }];
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSString *)whoWon{
    self.winningCombinations = [NSArray arrayWithObjects:
                                @[self.labelOne.text, self.labelTwo.text, self.labelThree.text],
                                @[self.labelFour.text, self.labelFive.text, self.labelSix.text],
                                @[self.labelSeven.text, self.labelEight.text, self.labelNine.text],
                                @[self.labelOne.text, self.labelFive.text, self.labelNine.text],
                                @[self.labelThree.text, self.labelFive.text, self.labelSeven.text],
                                @[self.labelOne.text, self.labelFour.text, self.labelSeven.text],
                                @[self.labelTwo.text, self.labelFive.text, self.labelEight.text],
                                @[self.labelThree.text, self.labelSix.text, self.labelNine.text],nil];
    
    for (NSArray *array in self.winningCombinations) {
        for (int i = 0; i < [array count] - 1; i++) {
            if (! [[array objectAtIndex:i] isEqualToString:@"Label"]) {
                NSSet *set = [NSSet setWithArray:array];
                if(([set count] <= 1)){
                    NSString * _temp = [set anyObject];
                    self.winner = _temp;
            }
        }
    }
    }
    
        return self.winner;
    }



@end
