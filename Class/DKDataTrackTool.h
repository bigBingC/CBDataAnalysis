//
//  DKDataTrackTool.h
//  DKDataTrackKit
//
//  Created by 崔冰smile on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDataTrackTool : NSObject

@property (nonatomic, copy) NSDictionary *trackData;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
