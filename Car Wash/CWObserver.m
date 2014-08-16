//
//  CWObserver.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/13/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWObserver.h"
#import "CWWeakLink.h"

@interface CWObserver ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservers;
@property (nonatomic, retain)	NSMutableArray	*mutableObservingObjects;

- (void)addObservingObject:(id)observingObject;
- (void)removeObservingObject:(id)observingObject;

@end

@implementation CWObserver

@synthesize mutableObservers	= _mutableObservers;
@synthesize mutableObservingObjects	= _mutableObservingObjects;

@dynamic observers;
@dynamic observingObjects;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
	NSArray *objects = self.observingObjects;
	for (id object in objects) {
		[object removeObserver:self];
	}
    
	self.mutableObservers = nil;
	self.mutableObservingObjects = nil;
    
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableObservers =	[NSMutableArray array];
		self.mutableObservingObjects = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark-
#pragma mark Accessors

- (NSArray *)observers {
	id syncObject = self.mutableObservers;
	@synchronized (syncObject) {
		NSMutableArray *observers = syncObject;
		NSMutableArray *result = [NSMutableArray arrayWithCapacity:[observers count]];
		for (CWWeakLink *link in observers) {
			[result addObject:link.object];
		}
		
		return [[result copy] autorelease];
	}
}

- (NSArray *)observingObjects {
	id syncObject = self.mutableObservingObjects;
	@synchronized (syncObject) {
        
		return [[syncObject copy] autorelease];
	}
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer {
	id syncObject = self.mutableObservers;
	@synchronized (syncObject) {
		CWWeakLink *weakLink = [CWWeakLink weakLinkToObject:observer];
		NSMutableArray *observers = syncObject;
		if ([observers containsObject:weakLink]) {
			
			return;
		}
		
		[observers addObject:weakLink];
		[observer addObservingObject:self];
	}
}

- (void)removeObserver:(id)observer {
	id syncObject = self.mutableObservers;
	@synchronized (syncObject) {
		CWWeakLink *weakLink = [CWWeakLink weakLinkToObject:observer];
		[syncObject removeObject:weakLink];
		[observer removeObservingObject:self];
	}
}

- (void)notifyObserversWithSelector:(SEL)selector {
	NSArray *observers = [self observers];
	for (id <NSObject> observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self];
        }
	}
}

- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector {
	dispatch_async(dispatch_get_main_queue(), ^{
		[self notifyObserversWithSelector:selector];
	});
}

- (void)notifyObserversWithSelector:(SEL)selector andObject:(id)object {
    NSArray *observers = [self observers];
    for (id <NSObject> observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self withObject:object];
        }
	}
    
}

#pragma mark-
#pragma mark Private Methods

- (void)addObservingObject:(id)observingObject {
	id syncObject = self.mutableObservingObjects;
	@synchronized (syncObject) {
		[syncObject addObject:observingObject];
	}
}

- (void)removeObservingObject:(id)observingObject {
	id syncObject = self.mutableObservingObjects;
	@synchronized (syncObject) {
		[syncObject removeObject:observingObject];
	}
}

@end
