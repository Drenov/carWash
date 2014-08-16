//
//  CWBuilding.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWBuilding.h"

@interface CWBuilding ()
@property (nonatomic, retain)	NSMutableArray	*mutableRooms;

@end

@implementation CWBuilding

@dynamic rooms;

@synthesize mutableRooms	= _mutableRooms;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableRooms = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark-
#pragma mark Accessors

//Gain acces to internal array by delivering its copy after external call for "rooms"
//which is virual interface in real

- (NSArray *)rooms {
	@synchronized (self.mutableRooms) {
        
		return [[self.mutableRooms copy] autorelease];
	}
}

#pragma mark-
#pragma mark Public Methods

- (void)addRoom:(CWRoom *)room {
	id syncObject = self.mutableRooms;
	@synchronized (syncObject) {
        [syncObject addObject:room];
	}
}

- (void)removeRoom:(CWRoom *)room {
	id syncObject = self.mutableRooms;
	@synchronized (syncObject) {
        [syncObject removeObject:room];
	}
}

@end
