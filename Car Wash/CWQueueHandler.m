//
//  CWWorkerAdministrator.m
//  Car Wash
//
//  Created by Dren Drenov on 27.03.14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWQueueHandler.h"

@interface CWQueueHandler ()
@property (atomic, retain)      NSMutableArray  *mutableHandlers;
@property (nonatomic, retain)   NSMutableArray  *mutableProcessingQueue;

@end

@implementation CWQueueHandler            
@synthesize mutableHandlers = _mutableHandlers;
@synthesize mutableProcessingQueue  = _mutableProcessingQueue;

@dynamic handlers;
@dynamic processingQueue;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableHandlers = nil;
    self.mutableProcessingQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableHandlers = [NSMutableArray array];
        self.mutableProcessingQueue = [NSMutableArray array];
    }
    return self;
}

#pragma mark-
#pragma mark Accessors

- (NSArray *)processingQueue {
	id syncObject = self.mutableProcessingQueue;
	@synchronized (syncObject) {
		return [[syncObject copy] autorelease];
	}
}

- (NSArray *)handlers {
    id syncObject = self.mutableHandlers;
    @synchronized (syncObject) {
        return [[syncObject copy] autorelease];
    }
}

#pragma mark-
#pragma mark Public Methods

- (void)addHandler:(id <CWHandling>)object {
    if (![object respondsToSelector:@selector(isBusy)]) {
        NSLog(@"Error. Handler can not perform handling");
        return;
    }
	id syncObject = self.mutableHandlers;
	@synchronized (syncObject) {
        if ([syncObject containsObject:object]) {
            NSLog(@"Error. Handler is already present.");
            return;
        }
        [syncObject addObject:object];
        NSLog(@"Handler %@ added. %lu in total", [object class], [syncObject count]);
	}
}

- (void)removeHandler:(id <CWHandling>)object {
	id syncObject = self.mutableHandlers;
	@synchronized (syncObject) {
        if ([syncObject containsObject:object]) {
            [syncObject removeObject:object];
            NSLog(@"Handler %@ removed. %lu in total", [object class], [syncObject count]);
            return;
        }
        NSLog(@"Error. Such handler not found");
	}
}

#pragma mark-
#pragma mark Private Methods

- (id)availableHandler {
   	@synchronized (self) {
        for (id object in self.handlers) {
            if (![object isBusy]) {
                
                return object;
            }
        }
        
        return nil;
    }
}

- (void)addToQueue:(id)object {
	id syncObject = self.mutableProcessingQueue;
	@synchronized (syncObject) {
        if ([syncObject containsObject:object]) {
            NSLog(@"Error. Handling object is already present.");
			
            return;
        }
        [syncObject addObject:object];
        NSLog(@"Handling object %@ added. %lu in queue", [object class], [syncObject count]);
	}
}

- (void)removeFromQueue:(id)object {
	id syncObject = self.mutableProcessingQueue;
	@synchronized (syncObject) {
        if ([syncObject containsObject:object]) {
            [syncObject removeObject:object];
            NSLog(@"Handling object %@ removed and forwarded for processing. %lu in queue", 
                  [object class], 
                  [syncObject count]);
			
            return;
        }
		
        NSLog(@"Error. Such handling object not found");
	}
}

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(id)object {
	@synchronized (self) {
        if ([self availableHandler] == nil) {
			NSLog(@"Handler not found. Queue will add object %@", [object class]);
            [self addToQueue:object];
        } else {
            NSLog(@"Handler for %@ found. Processing started", [object class]);
            [self.availableHandler process:object];
        }
	}
}

- (void)readyToProcess:(id)object {
    @synchronized (self) {
        if (![self.handlers containsObject:object]) {
            NSLog(@"Drop notify from %@", [object class]);
            return;
        }
        NSLog(@"Queue got 'readyToProcess' notification from %@", [object class]);
        NSArray *queue = self.processingQueue;
        if ([queue count] > 0) {
            id object = [queue firstObject];
            [self removeFromQueue:object];
            [self process:object];
        } else {
            NSLog(@"Queue is empty. No actions required");
        }
    }
}

@end
