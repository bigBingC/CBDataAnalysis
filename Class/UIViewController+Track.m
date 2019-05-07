//
//  UIViewController+Track.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "UIViewController+Track.h"
#import "DKMethodSwizzingTool.h"
#import "DKDataTrackTool.h"
#import <SensorsAnalyticsSDK.h>

@implementation UIViewController (Track)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalWillAppearSelector = @selector(viewWillAppear:);
        SEL swizzingWillAppearSelector = @selector(dk_viewWillAppear:);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalWillAppearSelector swizzingSel:swizzingWillAppearSelector];
        
        SEL originalWillDisappearSel = @selector(viewWillDisappear:);
        SEL swizzingWillDisappearSel = @selector(dk_viewWillDisappear:);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalWillDisappearSel swizzingSel:swizzingWillDisappearSel];
        
        SEL originalDidLoadSel = @selector(viewDidLoad);
        SEL swizzingDidLoadSel = @selector(dk_viewDidLoad);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalDidLoadSel swizzingSel:swizzingDidLoadSel];
    });
}

- (void)dk_viewWillAppear:(BOOL)animated {
    [self dk_viewWillAppear:animated];
    
    //埋点实现区域====
    [self dataTrack:@"viewWillAppear"];
}

- (void)dk_viewWillDisappear:(BOOL)animated {
    [self dk_viewWillDisappear:animated];
    
    //埋点实现区域====
    [self dataTrack:@"viewWillDisappear"];
}

- (void)dk_viewDidLoad {
    [self dk_viewDidLoad];
    
    //埋点实现区域====
    [self dataTrack:@"viewDidLoad"];
}

- (void)dataTrack:(NSString *)methodName {
    NSString *identifier = [NSString stringWithFormat:@"%@/%@",[self class],methodName];
    NSDictionary *eventDict = [[[DKDataTrackTool shareInstance].trackData objectForKey:@"ViewController"] objectForKey:identifier];
    if (eventDict) {
        //预留参数配置，以后拓展
        NSDictionary *param = [eventDict objectForKey:@"EventParam"];
        __block NSMutableDictionary *eventParam = [NSMutableDictionary dictionaryWithCapacity:0];
        [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //在此处进行属性获取
            id value = [DKMethodSwizzingTool captureVarforInstance:self varName:key];
            if (key && value) {
                [eventParam setObject:value forKey:key];
            }
        }];
        
        NSString *eventName = [eventDict objectForKey:@"EventName"];
        if (eventParam) {
            [[SensorsAnalyticsSDK sharedInstance] track:eventName withProperties:eventParam];
        } else {
            [[SensorsAnalyticsSDK sharedInstance] track:eventName];
        }
        
        NSLog(@"eventName：%@----eventParam：%@",eventName,eventParam);
    }
}
@end
