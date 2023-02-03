//
//  ViewController.m
//  marsXlog
//
//  Created by jc on 2023/2/2.
//

#import "ViewController.h"
#import "SGLXlogManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    //初始化
    [SGLXlogManager setupXlogWithLogPath:[self logPath]];
}

- (NSString *)logPath {
    NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"localLog"];
    return logPath;
}

- (IBAction)writeClick:(id)sender {
    //初始化
    [SGLXlogManager writeToFile:@"写入test"];
}


- (IBAction)uploadClick:(id)sender {

    NSString *tmpPath = NSTemporaryDirectory();
    NSString *tmpLogPath = [self logPath];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM-dd_HH-mm";
    NSString *zipPath = [tmpPath stringByAppendingPathComponent:[NSString stringWithFormat:@"logs_%@.zip", [formatter stringFromDate:NSDate.date]]];

    NSURL *url = [NSURL fileURLWithPath:zipPath];
    [self showsUIActivityVControllerWithUrlrs:@[url]];

}

- (void)showsUIActivityVControllerWithUrlrs:(NSArray<NSURL *> *)urls {
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:urls applicationActivities:nil];
    
    if ([(NSString *)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        controller.popoverPresentationController.sourceView = self.view;
        controller.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height, 10, 10);
    }
    [self presentViewController:controller animated:YES completion:^{
    }];
}

@end
