//
//  ViewController.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewConmtroller.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *tips;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text = @"hahha";
    self.content = @"dictionary";
    self.tips = @"test";
    //手势2
    UILabel * tapLabel = [[UILabel alloc]init];
    tapLabel.frame = CGRectMake(30, 400, 200, 50);
    tapLabel.text = @"点击触发手势埋点";
    tapLabel.textAlignment = NSTextAlignmentCenter;
    tapLabel.textColor = [UIColor whiteColor];
    tapLabel.backgroundColor = [UIColor grayColor];
    tapLabel.userInteractionEnabled = YES;
    [self.view addSubview:tapLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureclicked:)];
    [tapLabel addGestureRecognizer:tap];
}

- (IBAction)didPressedButton:(id)sender {
    [self.navigationController pushViewController:[SecondViewConmtroller new] animated:YES];
}

- (void)gestureclicked:(UIGestureRecognizer *)gesture {
    NSLog(@"测试手势点击");
}

@end
