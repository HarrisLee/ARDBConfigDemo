//
//  TPKObject.m
//  HXPay
//
//  Created by AZoo on 31/03/2017.
//  Copyright © 2017 AZoo. All rights reserved.
//

#import "TPKObject.h"
#import <UIKit/UIKit.h>
#import "NKMObject.h"

@interface TPKObject ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webview;

@end

@implementation TPKObject

+ (id)shareInstance{
    static TPKObject *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TPKObject alloc]init];
    });
    return obj;
}

- (void)TPKObjectAction:(NSString *)action block:(TPKObject *)block
{
    NSLog(@"%@",self.webview.description);
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webview loadRequest:req];
    });
    
    NKMObject *obj = [[NKMObject alloc] init];
    [obj someAction:^{
        NSLog(@"url is %@",self.webview.request.URL);
    }];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad is %@",webView.request.URL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error %@",error.localizedDescription);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finish %@",webView.request.URL);
}

- (UIWebView *)webview
{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
        _webview.delegate = self;
        _webview.backgroundColor = [UIColor redColor];
        dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] addSubview:_webview];
        });
    }
    return _webview;
}

@end
