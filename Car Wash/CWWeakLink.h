//
//  CWWeakLink.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/14/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"

@interface CWWeakLink : NSObject
@property (nonatomic, assign)	id	object;

+ (CWWeakLink *)weakLinkToObject:(id)object;

@end
