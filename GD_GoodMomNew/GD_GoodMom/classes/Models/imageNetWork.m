//
//  imageNetWork.m
//  调用相册New
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "imageNetWork.h"

@implementation imageNetWork

+ (void)imageNetWorkWithURLString:(NSString *)urlString completeMethod:(handleData)complete
{
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession]downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!location) {
            
            NSLog(@"%@",error);
        }
        
        else
        {
            NSData *data = [NSData dataWithContentsOfURL:location];
            @autoreleasepool {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    complete([UIImage imageWithData:data]);
                    
                    
                });
                
            }
        
        }
        
        
        
    }];
    [downloadTask resume];
    


}





@end
