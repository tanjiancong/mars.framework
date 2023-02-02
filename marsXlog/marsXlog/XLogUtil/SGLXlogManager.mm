//
//  SGLXlogManager.m
//  CHeart
//
//  Created by jc on 2023/2/14.
//

#import "SGLXlogManager.h"
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/appender.h>
#import <mars/xlog/xlogger.h>
#import <sys/xattr.h>

@implementation SGLXlogManager

+ (void)setupXlogWithLogPath:(NSString *)logPath {
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
    
    // init xlog
    mars::xlog::appender_set_console_log(false);
    xlogger_SetLevel(kLevelInfo);
    mars::xlog::XLogConfig config;
    config.mode_ = mars::xlog::kAppenderAsync;
    config.logdir_ = [logPath UTF8String];
    config.compress_mode_ = mars::xlog::kZlib;
    config.compress_level_ = 0;
    config.cachedir_ = "";
    config.cache_days_ = 0;
//        config.pub_key_ = "
    appender_open(config);
}

// 关闭Xlog
+ (void)closeXlog {
    mars::xlog::appender_close();
}

+ (void)writeToFile:(NSString*)str {
    xlogger_Write(NULL, str.UTF8String);
    mars::xlog::appender_flush();
}

@end
