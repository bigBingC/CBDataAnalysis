//
//  DKMethodSwizzingTool.m
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import "DKMethodSwizzingTool.h"
#import <objc/runtime.h>

@implementation DKMethodSwizzingTool

+ (void)swizzingForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector {
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzingMethod = class_getInstanceMethod(class, swizzingSelector);
    BOOL addMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
    if (addMethod) {
        class_replaceMethod(class, swizzingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzingMethod);
    }
}

+ (BOOL)isContainSel:(SEL)sel class:(Class)cls {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i < count; i ++) {
        Method method = methodList[i];
        NSString *temMethodName = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([temMethodName isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}


+ (id)captureVarforInstance:(id)instance varName:(NSString *)varName {
    id value;
    if ([self isContainProperty:varName class:instance]) {
       value = [instance valueForKey:varName];
    }
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([instance class], &count);
    
    if (!value) {
        NSMutableArray *varNameArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
            NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
            if (splitPropertyAttributes.count < 2) {
                continue;
            }
            NSString *className = [splitPropertyAttributes objectAtIndex:1];
            Class cls = NSClassFromString(className);
            NSBundle *bundle2 = [NSBundle bundleForClass:cls];
            if (bundle2 == [NSBundle mainBundle]) {
                //NSLog(@"自定义的类----- %@", className);
                const char *name = property_getName(property);
                NSString *varname = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
                [varNameArray addObject:varname];
            } else {
                //NSLog(@"系统的类");
            }
        }
        
        for (NSString *name in varNameArray) {
            id newValue = [instance valueForKey:name];
            if (newValue) {
                value = [newValue valueForKey:varName];
                if (value) {
                    return value;
                } else {
                    value = [[self class] captureVarforInstance:newValue varName:varName];
                }
            }
        }
    }
    return value;
}

+ (BOOL)isContainProperty:(id)varName class:(id)cls {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([cls class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([varName isEqualToString:propertyName]) {
            return YES;
        }
    }
    return NO;
}
@end
