//
//  CWAdminRoom.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/3/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWAdminRoom.h"
#import "CWAccountant.h"
#import "CWDirector.h"

@interface CWAdminRoom ();
@property (nonatomic, retain)	CWDirector		*director;
@property (nonatomic, retain)	CWAccountant	*accountant;
@property (nonatomic, retain)	NSMutableArray	*mutableWorkers;

@end

@implementation CWAdminRoom

@synthesize director	= director;
@synthesize accountant	= accountant;
@synthesize mutableWorkers	= _mutableWorkers;

#pragma mark
#pragma mark Initialization and Deallocation

- (void)dealloc {
	self.director = nil;
	self.accountant = nil;
	[super dealloc];
}

#pragma mark-
#pragma mark Public Methods

- (void)addWorker:(id)worker {
	[super addWorker:worker];
	if ([worker isKindOfClass:[CWDirector class]]) {
		self.director = worker;
	}
	if ([worker isKindOfClass:[CWAccountant class]]) {
		self.accountant = worker;
	}
}

- (void)removeWorker:(CWWorker *)worker {
	id syncObject = self.mutableWorkers;
    @synchronized (syncObject) {
        if ([worker isKindOfClass:[CWDirector class]] & [syncObject containsObject:worker]){
            [syncObject removeObjectIdenticalTo:worker];
            self.director = nil;
            NSLog(@"Worker %@ removed from room %@", worker.name, self.roomTitle);
        } else {
            NSLog(@"No worker with name %@ in room %@", worker.name, self.roomTitle);
        }
        if ([worker isKindOfClass:[CWAccountant class]] & [syncObject containsObject:worker]){
            [syncObject removeObjectIdenticalTo:worker];
            self.accountant = nil;
            NSLog(@"Worker %@ removed from room %@", worker.name, self.roomTitle);
        } else {
            NSLog(@"No worker with name %@ in room %@", worker.name, self.roomTitle);
        }
    }
}

@end
