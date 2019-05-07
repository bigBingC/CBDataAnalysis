//
//  SAKeyChainItemWrapper.h
//  SensorsAnalyticsSDK
//
//  Created by 向作为 on 2018/3/26.
//  Copyright © 2015-2019 Sensors Data Inc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>
extern  NSString * const kSAService;
extern  NSString * const kSAUdidAccount;
extern  NSString * const kSAAppInstallationAccount;
extern  NSString * const kSAAppInstallationWithDisableCallbackAccount;
@interface SAKeyChainItemWrapper : NSObject

+ (NSString *)saUdid;
+ (NSString *)saveUdid:(NSString *)udid;

#ifndef SENSORS_ANALYTICS_DISABLE_INSTALLATION_MARK_IN_KEYCHAIN
+ (BOOL)hasTrackInstallation;
+ (BOOL)hasTrackInstallationWithDisableCallback;
+ (BOOL)markHasTrackInstallation;
+ (BOOL)markHasTrackInstallationWithDisableCallback;
#endif

+ (BOOL)saveOrUpdatePassword:(NSString *)password account:(NSString *)account service:(NSString *)service ;
+ (NSDictionary *)fetchPasswordWithAccount:(NSString *)account service:(NSString *)service ;
+ (BOOL)deletePasswordWithAccount:(NSString *)account service:(NSString *)service ;

+ (BOOL)saveOrUpdatePassword:(NSString *)password account:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;
+ (NSDictionary *)fetchPasswordWithAccount:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;
+ (BOOL)deletePasswordWithAccount:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;

@end
