//
//  CWCarWashingRoom.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/28/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWCarWashingRoom.h"
#import "CWCar.h"

static const	NSUInteger	CWWashPrice = 10;

@interface CWCarWashingRoom ()
@property (nonatomic, retain)	NSMutableArray		*mutableWaitingLine;

@end

@implementation CWCarWashingRoom

@dynamic waitingLine;

@synthesize totalyServed	= _totalyServed;
@synthesize mutableWaitingLine	= _mutableWaitingLine;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableWaitingLine = nil;
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableWaitingLine = [NSMutableArray array];
		self.totalyServed = 0;
    }
    
    return self;
}

#pragma mark-
#pragma mark Accessors

- (NSArray *)waitingLine {
	id syncObject = self.mutableWaitingLine;
	@synchronized (syncObject) {
		return [[syncObject copy] autorelease];
	}
}

#pragma mark-
#pragma mark Public Methods

- (void) addCar:(CWCar *)cameCar {
    if (![cameCar isMemberOfClass:[CWCar class]]) {
        NSLog(@"Error. Add car can accept cars only");
        return;
    }
	id syncObject = self.mutableWaitingLine;
	@synchronized (syncObject) {
		[syncObject addObject:cameCar];
		cameCar.washPrice = CWWashPrice;
        NSLog(@"Car %@ is in %@ now", cameCar.registrationPlate, self.roomTitle);
	}
}

- (void) removeCar:(CWCar *) servicedCar {
    if (![servicedCar isMemberOfClass:[CWCar class]]) {
        NSLog(@"Error. Remove car can accept cars only");
        return;
    }
	id syncObject = self.mutableWaitingLine;
	@synchronized (syncObject) {
        if (![syncObject containsObject:servicedCar]) {
            NSLog(@"Error. There is no %@ in %@", servicedCar.registrationPlate, self.roomTitle);
            return;
        }
		
        NSString *roomTitle = self.roomTitle;
		NSUInteger totalyServed = ++ self.totalyServed;
        NSLog(@"Car %@ left %@", servicedCar.registrationPlate, roomTitle);
        NSLog(@"Total %lu cars has been washed in %@", totalyServed, roomTitle);
        [syncObject removeObjectIdenticalTo:servicedCar];
	}
}

@end

