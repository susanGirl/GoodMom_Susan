//
//  NetWorking.m
//  senior7_封装数据请求方法
//
//  Created by 80time on 16/4/8.
//  Copyright © 2016年 郝凤佩. All rights reserved.
//

#import "NetWorking.h"

@interface NetWorking ()<NSURLSessionDataDelegate>
@property (strong, nonatomic) NSMutableData *mutableData;
@end


@implementation NetWorking
// --------------------GET请求的block和代理回调传值方法--------------------
// block回调传值方法
+ (void)netWorkingGetActionWithURLString:(NSString *_Nonnull)urlString
                           completeHandle:(handleData _Nullable)handleData {
    // 创建数据请求任务
    NSURLSessionDataTask *dataTask  = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            // 如果data为空，则通知外界错误代码，不再执行其他操作
            NSLog(@"%@", error);
            return;
        }
        // 通过block回调值，将请求完成的data传递出去
        handleData(data);
    }];
    [dataTask resume];
}


// 代理回调传值方法
+ (void)networkingGetActionWithURLString:(NSString *_Nonnull)urlString
                                delegate:(id<netWorkingDelegate> _Nullable)delegate {
    // 创建数据请求任务
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            // 如果data为空，则通知外界错误代码，不再执行其他操作
            NSLog(@"%@", error);
            return;
        }
        if (delegate && [delegate respondsToSelector:@selector(netWorkingHandleData:)]) {
            [delegate netWorkingHandleData:data];
        }
    }];
    [dataTask resume];
}
// ---------------------------------------------------------------------

// --------------------POST请求的block和代理回调传值方法--------------------
// block回调传值方法
// block回调传值方法
+ (void)netWorkingPostActionWithURLString:(NSString *_Nonnull)urlString
                            bodyURLString:(NSString *_Nonnull)bodyURLString
                           completeHandle:(handleData _Nullable)handleData {
    // 创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    // 根据url对象创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 设置请求方式
    [request setHTTPMethod:@"POST"];
        // 设置请求体
    NSData *bodyData = [bodyURLString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    // 获取会话(网络请求的主体内容）
    NSURLSession *session = [NSURLSession sharedSession];
    // 建立请求任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            NSLog(@"%@", error);
        }
        handleData(data);
    }];
    [dataTask resume];
}
// 代理回调传值方法
+ (void)netWorkingPostActionWithURLString:(NSString *_Nonnull)urlString
                            bodyURLString:(NSString *_Nonnull)bodyURLString
                                 delegate:(id<netWorkingDelegate> _Nullable)delegate {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData = [bodyURLString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            NSLog(@"%@", error);
        }
        if (delegate && [delegate respondsToSelector:@selector(netWorkingHandleData:)]) {
            [delegate netWorkingHandleData:data];
        }
    }];
    [dataTask resume];
}
// ---------------------------------------------------------------------

// --------------------代理请求的block和代理回调传值方法--------------------
+ (void)netWorkingDelegateActionWithURLString:(NSString *_Nonnull)urlString
                               completeHandle:(handleData _Nullable)handleData {
    // 创建网络调配会话
    // 需要借助于configuration来进行资源配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 根据调配配置会话
    // 创建会话时，若使用代理方式参数分别为：负责调配的会话、当前代理对象、执行代理的队列（此处为主队列）
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:[self new] delegateQueue:[NSOperationQueue mainQueue]];
    // 3. 创建数据处理任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString]];
    // 4. 启动任务
    [dataTask resume];
    
}
// 实现代理方法
// 1. 收到响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许服务器响应
    completionHandler(NSURLSessionResponseAllow);
    // 开辟空间
    self.mutableData = @[].mutableCopy;
}
// 2. 接受数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 接收数据，拼接获取的数据（当数据量较大时，此方法会反复执行，直到数据全部拼接完成）
    [self.mutableData appendData:data];
}
// 3. 完成请求，处理错误
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"%@", error);
}
+ (void)netWorkingDelegateActionWithURLString:(NSString *_Nonnull)urlString
                                     delegate:(id<netWorkingDelegate> _Nullable)delegate {
    
}

// ---------------------------------------------------------------------
@end
