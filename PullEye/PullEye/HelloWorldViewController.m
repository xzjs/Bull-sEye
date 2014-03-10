//
//  HelloWorldViewController.m
//  PullEye
//
//  Created by xzjs on 14-3-10.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController (){
    int currentValue;
    int targetValue;
}
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)showAlert:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@end

@implementation HelloWorldViewController

@synthesize slider;

-(void)startNewRound{
    targetValue=1+(arc4random()%100);
    currentValue=50;
    self.slider.value=currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    currentValue=self.slider.value;
//    targetValue=1+(arc4random()%100);
    [self startNewRound];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(UISlider *)sender {
    //UISlider *slider=(UISlider *)sender;
    //NSLog(@"滑动条当前的数值是:%f",slider.value);
    currentValue=(int)lround(sender.value);
}

- (IBAction)showAlert:(id)sender {
    NSString *message=[NSString stringWithFormat:@"滑动条当前的数值是：%d,我们的目标数值是:%d",currentValue,targetValue];
    [[[UIAlertView alloc] initWithTitle:@"您好，苍老师" message:message delegate:nil cancelButtonTitle:@"东京热" otherButtonTitles:nil, nil]show];
    [self startNewRound];
}
@end
