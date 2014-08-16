//
//  NSObject+CWExtensions.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/12/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "NSObject+CWExtensions.h"

@implementation NSObject (CWExtensions)

+ (id)object {
	return [[[self alloc] init] autorelease];
}

@end
