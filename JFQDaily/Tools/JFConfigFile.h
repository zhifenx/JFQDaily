//
//  JFConfigFile.h
//  LivePlayerDemo
//
//  Created by 张志峰 on 16/8/25.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#ifndef JFConfigFile_h
#define JFConfigFile_h

#define JFSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define JFSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高度


#define KMainBodyColor [UIColor colorWithRed:238/255.0f green:105/255.0f blue:158/255.0f alpha:1]//navigationBar主题颜色

#define JFRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]//获取随机颜色

#define JFRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define JFClearColor [UIColor clearColor]// clear背景颜色
/** 自定义Log */
#ifdef DEBUG
#define JFLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define JFLog(...)

#endif

#define JFWeakSelf(type)  __weak typeof(type) weak##type = type;//弱引用
#define JFStrongSelf(type)  __strong typeof(type) type = weak##type;//强引用

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//当前版本
#define RCDLive_IOS_FSystenVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

#endif /* JFConfigFile_h */
