//
//  NKMObject.m
//  HXPay
//
//  Created by AZoo on 31/03/2017.
//  Copyright © 2017 AZoo. All rights reserved.
//

#import "NKMObject.h"
#import <UIKit/UIKit.h>

@interface NKMObject ()<UIWebViewDelegate>

@property (nonatomic,strong) __block UIWebView *webview;

@end

@implementation NKMObject

- (void)someAction:(Sometest)test{
    NSLog(@"someAction");
    self.name = @"my obj name is NKMObj";
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        test();
//    });
//    NSLog(@"web is %@",self.webview.description);
////    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    
////      do some other actions
//        dispatch_async(dispatch_get_main_queue(), ^{
////            NSLog(@"before");
////            NSURL *url = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
////            NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url];
////            [self.webview loadRequest:req];
////            NSLog(@"self.webview.description is %@",self.webview.description);
////            NSLog(@"after");
//        });
//    
////    });
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad is %@",webView.request.URL);
}

- (UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.delegate = self;
        _webview.frame = CGRectZero;
    }
    return _webview;
}


@end
