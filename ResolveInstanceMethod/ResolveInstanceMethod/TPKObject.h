//
//  TPKObject.h
//  HXPay
//
//  Created by AZoo on 31/03/2017.
//  Copyright © 2017 AZoo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TPKObject;
typedef void(^TPKBlock)(TPKObject *obj);

@interface TPKObject : NSObject

+ (id)shareInstance;

- (void)TPKObjectAction:(NSString *)action block:(TPKObject *)block;

@end
