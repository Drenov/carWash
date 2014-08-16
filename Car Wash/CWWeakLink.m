//
//  CWWeakLink.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/14/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWWeakLink.h"

@implementation CWWeakLink

@synthesize object	= _object;

#pragma mark
#pragma mark Class Methods

+ (CWWeakLink *)weakLinkToObject:(id)object {
	CWWeakLink *weakLinkObject = [CWWeakLink object];
	weakLinkObject.object = object;
    
	return weakLinkObject;
}

#pragma mark
#pragma mark Overriden Methods

- (BOOL)isEqual:(CWWeakLink *)object {
	if ([object	isMemberOfClass:[CWWeakLink class]]) {
        
		return object.object == self.object;
	}
    
	return NO;
}

- (NSUInteger)hash {
    
    return (NSUInteger)self.object;
}

@end
