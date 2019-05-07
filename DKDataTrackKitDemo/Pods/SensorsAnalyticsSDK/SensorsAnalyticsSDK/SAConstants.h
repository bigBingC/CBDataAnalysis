//
//  SAConstants.h
//  SensorsAnalyticsSDK
//
//  Created by 向作为 on 2018/8/9.
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

NS_ASSUME_NONNULL_BEGIN
#pragma mark--evnet
extern NSString * const SA_EVENT_TIME;
extern NSString * const SA_EVENT_TRACK_ID;
extern NSString * const SA_EVENT_NAME;
extern NSString * const SA_EVENT_FLUSH_TIME;
extern NSString * const SA_EVENT_DISTINCT_ID;
extern NSString * const SA_EVENT_PROPERTIES;
extern NSString * const SA_EVENT_TYPE;
extern NSString * const SA_EVENT_LIB;
extern NSString * const SA_EVENT_PROJECT;
extern NSString * const SA_EVENT_TOKEN;

#pragma mark--evnet nanme

// App 启动或激活
extern NSString * const SA_EVENT_NAME_APP_START;
// App 退出或进入后台
extern NSString * const SA_EVENT_NAME_APP_END;
// App 浏览页面
extern NSString * const SA_EVENT_NAME_APP_VIEW_SCREEN;
// App 元素点击
extern NSString * const SA_EVENT_NAME_APP_CLICK;
// 自动追踪相关事件及属性
extern NSString * const SA_EVENT_NAME_APP_START_PASSIVELY;

extern NSString * const SA_EVENT_NAME_APP_SIGN_UP;

#pragma mark--app install property
extern NSString * const SA_EVENT_PROPERTY_APP_INSTALL_SOURCE;
extern NSString * const SA_EVENT_PROPERTY_APP_INSTALL_DISABLE_CALLBACK;
extern NSString * const SA_EVENT_PROPERTY_APP_INSTALL_USER_AGENT;
extern NSString * const SA_EVENT_PROPERTY_APP_INSTALL_FIRST_VISIT_TIME;

#pragma mark--autoTrack property
// App 首次启动
extern NSString * const SA_EVENT_PROPERTY_APP_FIRST_START;
// App 是否从后台恢复
extern NSString * const SA_EVENT_PROPERTY_RESUME_FROM_BACKGROUND;
// App 浏览页面 Url
extern NSString * const SA_EVENT_PROPERTY_SCREEN_URL;
// App 浏览页面 Referrer Url
extern NSString * const SA_EVENT_PROPERTY_SCREEN_REFERRER_URL;
extern NSString * const SA_EVENT_PROPERTY_ELEMENT_ID;
extern NSString * const SA_EVENT_PROPERTY_SCREEN_NAME;
extern NSString * const SA_EVENT_PROPERTY_TITLE;
extern NSString * const SA_EVENT_PROPERTY_ELEMENT_POSITION;
extern NSString * const SA_EVENT_PROPERTY_ELEMENT_SELECTOR;
extern NSString * const SA_EVENT_PROPERTY_ELEMENT_CONTENT;
extern NSString * const SA_EVENT_PROPERTY_ELEMENT_TYPE;

#pragma mark--common property
//常规参数
extern NSString * const SA_EVENT_COMMON_PROPERTY_LIB;
extern NSString * const SA_EVENT_COMMON_PROPERTY_LIB_VERSION;
extern NSString * const SA_EVENT_COMMON_PROPERTY_LIB_DETAIL;
extern NSString * const SA_EVENT_COMMON_PROPERTY_LIB_METHOD;

extern NSString * const SA_EVENT_COMMON_PROPERTY_APP_VERSION;

extern NSString * const SA_EVENT_COMMON_PROPERTY_MODEL;
extern NSString * const SA_EVENT_COMMON_PROPERTY_MANUFACTURER;

extern NSString * const SA_EVENT_COMMON_PROPERTY_OS;
extern NSString * const SA_EVENT_COMMON_PROPERTY_OS_VERSION;

extern NSString * const SA_EVENT_COMMON_PROPERTY_SCREEN_HEIGHT;
extern NSString * const SA_EVENT_COMMON_PROPERTY_SCREEN_WIDTH;

extern NSString * const SA_EVENT_COMMON_PROPERTY_NETWORK_TYPE;
extern NSString * const SA_EVENT_COMMON_PROPERTY_WIFI;
extern NSString * const SA_EVENT_COMMON_PROPERTY_CARRIER;
extern NSString * const SA_EVENT_COMMON_PROPERTY_DEVICE_ID;
extern NSString * const SA_EVENT_COMMON_PROPERTY_IS_FIRST_DAY;


//可选参数
extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_LATITUDE;
extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_LONGITUDE;
extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_SCREEN_ORIENTATION;
extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_APP_STATE;

extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_PROJECT;
extern NSString * const SA_EVENT_COMMON_OPTIONAL_PROPERTY_TOKEN;

#pragma mark--profile
extern NSString * const SA_PROFILE_SET;
extern NSString * const SA_PROFILE_SET_ONCE;
extern NSString * const SA_PROFILE_UNSET;
extern NSString * const SA_PROFILE_DELETE;
extern NSString * const SA_PROFILE_APPEND;
extern NSString * const SA_PROFILE_INCREMENT;

#pragma mark--others
extern NSString * const SA_SDK_TRACK_CONFIG;
extern NSString * const SA_HAS_LAUNCHED_ONCE;
extern NSString * const SA_HAS_TRACK_INSTALLATION;
extern NSString * const SA_HAS_TRACK_INSTALLATION_DISABLE_CALLBACK;

NS_ASSUME_NONNULL_END
