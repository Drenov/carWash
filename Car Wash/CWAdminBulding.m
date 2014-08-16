//
//  CWAdminBulding.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWAdminBulding.h"
#import "CWAdminRoom.h"

@interface CWAdminBulding ()
@property (nonatomic, retain)   CWAdminRoom *adminRoom;

@end

@implementation CWAdminBulding

@synthesize adminRoom	= _adminRoom;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.adminRoom = nil;
	[super dealloc];
}

#pragma mark-
#pragma mark Public Methods

- (void)addRoom:(CWRoom *)room {
	[super addRoom:room];
	self.adminRoom = (CWAdminRoom *)room;
}

- (void)removeRoom:(CWRoom *)room {
	[super removeRoom:room];
	self.adminRoom = nil;
}

@end
