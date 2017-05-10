//
//  NKMObject.h
//  HXPay
//
//  Created by AZoo on 31/03/2017.
//  Copyright © 2017 AZoo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Sometest)();

@interface NKMObject : NSObject

@property (nonatomic,strong) NSString *name;

- (void)someAction:(Sometest)test;

@end
