//
//  UIControl+Track.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "UIControl+Track.h"
#import "DKMethodSwizzingTool.h"
#import "DKDataTrackTool.h"
#import <SensorsAnalyticsSDK.h>

@implementation UIControl (Track)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzingSelector = @selector(dk_sendAction:to:forEvent:);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalSelector swizzingSel:swizzingSelector];
    });
}

- (void)dk_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self dk_sendAction:action to:target forEvent:event];
    
    //埋点实现区域====
    //页面/方法名/tag用来区分不同的点击事件
    NSString *identifier = [NSString stringWithFormat:@"%@/%@/%@", [target class], NSStringFromSelector(action),@(self.tag)];
    NSDictionary *eventDict = [[[DKDataTrackTool shareInstance].trackData objectForKey:@"Action"] objectForKey:identifier];
    if (eventDict) {
        //预留参数配置，以后拓展
        NSDictionary *param = [eventDict objectForKey:@"EventParam"];
        __block NSMutableDictionary *eventParam = [NSMutableDictionary dictionaryWithCapacity:0];
        [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //在此处进行属性获取
            id value = [DKMethodSwizzingTool captureVarforInstance:target varName:key];
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
