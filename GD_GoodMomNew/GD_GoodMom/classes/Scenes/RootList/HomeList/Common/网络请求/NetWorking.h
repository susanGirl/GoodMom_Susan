//
//  NetWorking.h
//  senior7_封装数据请求方法
//
//  Created by 80time on 16/4/8.
//  Copyright © 2016年 郝凤佩. All rights reserved.
//

#import <Foundation/Foundation.h>
// --------------------GET请求的block和代理回调传值方法--------------------
// 定义block
typedef void(^handleData)(NSData *_Nullable data);
// 定义代理
@protocol netWorkingDelegate <NSObject>

- (void)netWorkingHandleData:(NSData *_Nullable)data;
// ---------------------------------------------------------------------

@end

@interface NetWorking : NSObject
// --------------------GET请求的block和代理回调传值方法--------------------
// block回调传值方法
+ (void)netWorkingGetActionWithURLString:(NSString *_Nonnull)urlString
                           completeHandle:(handleData _Nullable)handleData;
// 代理回调传值方法
+ (void)networkingGetActionWithURLString:(NSString *_Nonnull)urlString
                                delegate:(id<netWorkingDelegate> _Nullable)delegate;
// ---------------------------------------------------------------------

// --------------------POST请求的block和代理回调传值方法--------------------
// block回调传值方法
+ (void)netWorkingPostActionWithURLString:(NSString *_Nonnull)urlString
                               bodyURLString:(NSString *_Nonnull)bodyURLString
                           completeHandle:(handleData _Nullable)handleData;
// 代理回调传值方法
+ (void)netWorkingPostActionWithURLString:(NSString *_Nonnull)urlString
                            bodyURLString:(NSString *_Nonnull)bodyURLString
                           delegate:(id<netWorkingDelegate> _Nullable)delegate;
// ---------------------------------------------------------------------

// --------------------代理请求的block和代理回调传值方法--------------------
+ (void)netWorkingDelegateActionWithURLString:(NSString *_Nonnull)urlString
                               completeHandle:(handleData _Nullable)handleData;
+ (void)netWorkingDelegateActionWithURLString:(NSString *_Nonnull)urlString
                                     delegate:(id<netWorkingDelegate> _Nullable)delegate;

// ---------------------------------------------------------------------

@end
