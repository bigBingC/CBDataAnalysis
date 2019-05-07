//
//  DKMethodSwizzingTool.h
//  DKDataTrackKitDemo
//
//  Created by 崔冰smile on 2019/5/6.
//  Copyright © 2019 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKMethodSwizzingTool : NSObject
/**
 方法交换
 
 @param cls 需要交换的类
 @param originalSelector 原始方法
 @param swizzingSelector 交换后的方法
 */
+ (void)swizzingForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector;

/**
 判断一个类中是否有这个方法
 
 @param sel 方法
 @param cls 类
 */
+ (BOOL)isContainSel:(SEL)sel class:(Class)cls;

/**
 根据属性名获取某个对象的对应属性的值
 
 @param instance 持有属性的对象
 @param varName 属性的名字
 @return 属性对应的value
 */
+(id)captureVarforInstance:(id)instance varName:(NSString *)varName;

/**
 判断一个类是否包含某个属性
 
 @param varName 需要判断的属性
 @param cls 类
 */
+ (BOOL)isContainProperty:(id)varName class:(id)cls;

@end

NS_ASSUME_NONNULL_END
