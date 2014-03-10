//
//  HelloWorldViewController.m
//  PullEye
//
//  Created by xzjs on 14-3-10.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "HelloWorldViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HelloWorldViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)showAlert:(id)sender;
- (IBAction)startOver:(id)sender;
- (IBAction)showInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation HelloWorldViewController

@synthesize slider;
@synthesize scoreLabel;
@synthesize targetLabel;
@synthesize roundLabel;
@synthesize audioPlayer;

-(void)playBackGroundMusic{
    NSString *musicPath=[[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops=-1;
    if(audioPlayer==nil){
        NSString *errorInfo=[NSString stringWithString:[error description]];
        NSLog(@"the error is %@",errorInfo);
    }else{
        [audioPlayer play];
    }
}

-(void)updateLabels{
    self.targetLabel.text=[NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    self.roundLabel.text=[NSString stringWithFormat:@"%d",round];
}

-(void)startNewRound{
    round+=1;
    targetValue=1+(arc4random()%100);
    currentValue=50;
    self.slider.value=currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *thumbImageNormal=[UIImage imageNamed:@"SliderThumbHighLighted"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted=[UIImage imageNamed:@"SliderThumbHighlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage=[[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage=[[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];

//    currentValue=self.slider.value;
//    targetValue=1+(arc4random()%100);
    [self startNewRound];
    [self updateLabels];
    [self playBackGroundMusic];
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
    int difference=abs(currentValue-targetValue);
    int points=100-difference;
    score+=points;
    NSString *title;
    if(difference==0){
        title=@"土豪你太NB了！";
        points+=100;
    }else if (difference<5){
        title=@"土豪太棒了，差一点！";
        if (difference==1) {
            points+=50;
        }
    }else if (difference<10){
        title=@"勉强算个土豪";
    }else{
        title=@"不是土豪少来装";
    }
    NSString *message=[NSString stringWithFormat:@"您的得分是：%d",points];
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"朕已知晓，爱卿辛苦了" otherButtonTitles:nil, nil]show];
}

- (IBAction)startOver:(id)sender {
    //添加过渡效果
    CATransition *transition=[CATransition animation];
    transition.type=kCATransitionFade;
    transition.duration=3;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller=[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)startNewGame{
    score=0;
    round=0;
    [self startNewRound];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self startNewRound];
    [self updateLabels];
}

@end
