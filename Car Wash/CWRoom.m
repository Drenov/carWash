//
//  CWRoom.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWRoom.h"
#import "CWWorker.h"
#import "CWDirector.h"

@interface CWRoom()
@property (atomic, assign)      NSInteger		freeWorkers;
@property (nonatomic, retain)	NSMutableArray	*mutableWorkers;

@end

@implementation CWRoom

@synthesize freeWorkers	= _freeWorkers;
@synthesize roomTitle	= _roomTitle;
@synthesize mutableWorkers	= _mutableWorkers;
@synthesize workersCapacity	= _workersCapacity;

@dynamic workers;

#pragma mark -
#pragma mark Class Methods

+ (id)roomWithCapacity:(NSUInteger)workersCapacity
			 roomTitle:(NSString *)roomTitle
{
	CWRoom *room = [self object];
	room.workersCapacity = workersCapacity;
	room.roomTitle = roomTitle;

	return room;
}

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.roomTitle = nil;
	self.mutableWorkers = nil;
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
		self.freeWorkers = 0;
        self.mutableWorkers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark-
#pragma mark Accessors

- (NSArray *)workers {
	id syncObject = self.mutableWorkers;
	@synchronized (syncObject) {
        
		return [[syncObject copy] autorelease];
	}
}

#pragma mark -
#pragma mark Public Methods

- (void)addWorker:(CWWorker *)worker {
    if ([worker isMemberOfClass:[CWWorker class]]) {
        NSLog(@"Error. Add worker can accept workers only");
        
        return;
    }
	id syncObject = self.mutableWorkers;
	@synchronized (syncObject) {
		if (!worker.isBusy && ![worker isMemberOfClass:[CWDirector class]]) {
			self.freeWorkers ++;
		}
		[syncObject addObject:worker];
	}
}

- (void)removeWorker:(CWWorker *)worker {
	id syncObject = self.mutableWorkers;
	@synchronized (syncObject) {
		if ([syncObject containsObject:worker]){
			[syncObject removeObjectIdenticalTo:worker];
			if (!worker.isBusy && ![worker isMemberOfClass:[CWDirector class]]) {
				self.freeWorkers --;
			}
			NSLog(@"Worker %@ removed from room %@", worker.name, self.roomTitle);
		} else {
			NSLog(@"No worker with name %@ in room %@", worker.name, self.roomTitle);
		}
	}
}

- (void)reservWorker {
    @synchronized (self) {
        NSLog(@"In the room %@ %lu free workers now", self.roomTitle, -- self.freeWorkers);   
    }
}

- (void)unReservWorker {
    @synchronized (self) {
        NSLog(@"In the room %@ %lu free workers now", self.roomTitle, ++ self.freeWorkers);
    }
}

@end
