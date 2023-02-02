//
//  SGLXlogManager.h
//  CHeart
//
//  Created by jc on 2023/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGLXlogManager : NSObject

/// 初始化Xlog
+ (void)setupXlogWithLogPath:(NSString *)logPath;

/// 关闭Xlog
+ (void)closeXlog;

///写入日志
+ (void)writeToFile:(NSString*)str;

@end
NS_ASSUME_NONNULL_END
