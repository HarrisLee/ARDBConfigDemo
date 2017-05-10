//
//  Human.m
//  ResolveInstanceMethod
//
//  Created by JianRongCao on 3/22/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "Human.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "YellowHuman.h"

@interface Human()
{
    YellowHuman *yHuamn;
}
@end

@implementation Human

- (void)name
{
    NSLog(@"name");
}

//当找不到此实例方法的时候，会首先调用resolveInstanceMethod
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"%@",NSStringFromSelector(sel));
//    if ([@"name" isEqualToString:NSStringFromSelector(sel)]) {
//        Method method = class_getInstanceMethod([self class], @selector(showName));
//        IMP imp = method_getImplementation(method);
//        class_addMethod([self class], sel, imp, "v@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

//- (void)forwardInvocation:(NSInvocation *)invocation
//{
//    SEL invSEL = invocation.selector;
//    if ([yHuamn respondsToSelector:invSEL])
//        [anInvocation invokeWithTarget:yHuamn];
//    } else {
//        [self doesNotRecognizeSelector:invSEL];
//    }
//}

- (void)showName
{
    NSLog(@"showName");
}

@end
