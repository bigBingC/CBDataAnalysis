//
//  UITableView+Track.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "UITableView+Track.h"
#import "DKMethodSwizzingTool.h"
#import <objc/runtime.h>
#import "DKDataTrackTool.h"
#import <SensorsAnalyticsSDK.h>

@implementation UITableView (Track)
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzingSelector = @selector(dk_setDelegate:);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalSelector swizzingSel:swizzingSelector];
    });
}

- (void)dk_setDelegate:(id<UITableViewDelegate>)delegate {
    [self dk_setDelegate:delegate];
    
    SEL originalSel = @selector(tableView:didSelectRowAtIndexPath:);
    SEL swizzingSel = NSSelectorFromString([NSString stringWithFormat:@"%@/%@", NSStringFromClass([delegate class]),@(self.tag)]);
    
    //didSelectRowAtIndexPath不一定要实现，未实现在跳过
    if (![DKMethodSwizzingTool isContainSel:originalSel class:[delegate class]]) {
        return;
    }
    
    BOOL addMethod = class_addMethod([delegate class], swizzingSel, method_getImplementation(class_getInstanceMethod([self class], @selector(dk_tableView:didSelectRowAtIndexPath:))), nil);
    if (addMethod) {
        Method originalMetod = class_getInstanceMethod([delegate class], originalSel);
        Method swizzingMethod = class_getInstanceMethod([delegate class], swizzingSel);
        method_exchangeImplementations(originalMetod, swizzingMethod);
    }
}

- (void)dk_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"%@/%@", NSStringFromClass([self class]),@(tableView.tag)];
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,tableView,indexPath);
    }
    
    //埋点实现区域====
    NSDictionary *eventDict = [[[DKDataTrackTool shareInstance].trackData objectForKey:@"TableView"] objectForKey:identifier];
    if (eventDict) {
        //预留参数配置，以后拓展
        NSDictionary *param = [eventDict objectForKey:@"EventParam"];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        __block NSMutableDictionary *eventParam = [NSMutableDictionary dictionaryWithCapacity:0];
        //如果viewcontroller有值则取viewcontroller中的，否则取cell中的
        BOOL isViewController = [eventDict objectForKey:@"viewcontroller"];
        id instance = isViewController ? self : cell;
        [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //在此处进行属性获取
            id value = [DKMethodSwizzingTool captureVarforInstance:instance varName:key];
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
