//
//  imageNetWork.h
//  调用相册New
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^handleData)(UIImage *_Nullable image);


@interface imageNetWork : NSObject



+(void)imageNetWorkWithURLString:(NSString * _Nullable )urlString completeMethod:(handleData _Nullable )complete;


@end
