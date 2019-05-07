//
//  DKDataTrackTool.m
//  DKDataTrackKit
//
//  Created by 崔冰smile on 2019/5/6.
//

#import "DKDataTrackTool.h"
//#import "NSBundle+PodResource.h"

@implementation DKDataTrackTool

+ (instancetype)shareInstance {
    static DKDataTrackTool *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
//        NSBundle *bundle = [NSBundle resourceBundleForClass:[self class] resourceBundleName:@"DKDataTrackKit"];
//        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[bundle pathForResource:@"DKDataTrack" ofType:@"plist"]];
//
        NSDictionary *testDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DKDataTest" ofType:@"plist"]];
        self.trackData = [testDict copy];
    }
    return self;
}

@end
