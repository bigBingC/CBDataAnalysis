//
//  UIGestureRecognizer+Track.m
//  DKCorePodResourceUtil
//
//  Created by 崔冰smile on 2019/5/6.
//

#import "UIGestureRecognizer+Track.h"
#import "DKMethodSwizzingTool.h"
#import <objc/runtime.h>
#import "DKDataTrackTool.h"
#import <SensorsAnalyticsSDK.h>

@implementation UIGestureRecognizer (Track)

- (void)setMethodName:(NSString *)methodName {
    objc_setAssociatedObject(self, @selector(methodName), methodName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)methodName {
   return objc_getAssociatedObject(self, @selector(methodName));
}

+(void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSel = @selector(initWithTarget:action:);
        SEL swizzingSel = @selector(dk_initWithTarget:action:);
        [DKMethodSwizzingTool swizzingForClass:[self class] originalSel:originalSel swizzingSel:swizzingSel];
    });
}

- (instancetype)dk_initWithTarget:(nullable id)target action:(nullable SEL)action {
    UIGestureRecognizer *recognizer = [self dk_initWithTarget:target action:action];

    if (!target && !action) {
        return recognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return recognizer;
    }
    
    Class cls = [target class];
    SEL sel = action;
    
    NSString *selName = [NSString stringWithFormat:@"%s/%@",class_getName(cls),NSStringFromSelector(sel)];
    SEL swizzingSel = NSSelectorFromString(selName);
    BOOL addMethod = class_addMethod(cls, swizzingSel, method_getImplementation(class_getInstanceMethod([self class], @selector(dk_responseUsergesture:))), nil);
    self.methodName = NSStringFromSelector(sel);

    if (addMethod) {
        Method originalMethod = class_getInstanceMethod(cls, sel);
        Method swizzingMethod = class_getInstanceMethod(cls, swizzingSel);
        method_exchangeImplementations(originalMethod, swizzingMethod);
    }

    return recognizer;
}

- (void)dk_responseUsergesture:(UIGestureRecognizer *)gesture {
    NSString *identifier = [NSString stringWithFormat:@"%s/%@", class_getName([self class]),gesture.methodName];
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,gesture);
    }

    //埋点实现区域====
    NSDictionary *eventDict = [[[DKDataTrackTool shareInstance].trackData objectForKey:@"Gesture"] objectForKey:identifier];
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
