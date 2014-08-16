//
//  CWWorker.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWWorker.h"

@implementation CWWorker

@synthesize name	= _name;
@synthesize	salary	= _salary;
@synthesize	pocket	= _pocket;
@synthesize	workExperience	= _workExperience;
@synthesize isBusy	= _isBusy;

#pragma mark
#pragma mark Class Methods

+ (id)workerWithName:(NSString *)name
			  salary:(NSUInteger)salary
		   experince:(NSUInteger)workExperience;
{
	CWWorker *worker = [self object];
	worker.name	= name;
	worker.salary	= salary;
	worker.workExperience	= workExperience;
	
    return worker;
}

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.name = nil;
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
		self.isBusy	= NO;
		self.pocket = 0;
    }
    
    return self;
}

#pragma mark-
#pragma mark Accessors

- (void)setIsBusy:(BOOL)isBusy {
    @synchronized (self) {
        _isBusy = isBusy;
        NSLog(@"Worker %@ busy state changed to %@", self.name, (_isBusy ? @"Yes" : @"No" ));
    }
}

#pragma mark-
#pragma mark Public Methods

- (void)didFinishWork {
    NSLog(@"Worker %@ sent 'didFinishProcessing' notification", self.name);
    [self notifyObserversOnMainThreadWithSelector:@selector(didFinishProcessing:)];
}

- (void)isReadyToWork {
    NSLog(@"Worker %@ sent 'readyToProcess' notification", self.name);
    [self notifyObserversOnMainThreadWithSelector:@selector(readyToProcess:)];
}

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(id)object {
    
}

@end
