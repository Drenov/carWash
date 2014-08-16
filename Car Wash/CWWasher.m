//
//  CWWasher.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWWasher.h"
#import "CWCar.h"
#import "CWWeakLink.h"
#import "CWAccountant.h"

static const NSUInteger	CWMaxWashTime = 0;

@implementation CWWasher

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(CWCar *)car {
	@synchronized (self) {
        self.isBusy = YES;
        [self notifyObserversWithSelector:@selector(willProcess:target:) andObject:car];
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString *workerName = self.name;
			NSString *carName =	car.registrationPlate;
			NSUInteger needTime = CWMaxWashTime;//(arc4random() % CWMaxWashTime + 1);
            
			NSLog(@"%@ started to wash car %@", workerName, carName);
			NSLog(@"%@ need >>> %lu <<< seconds to wash car", workerName, (unsigned long)needTime);
			sleep((uint32_t)needTime);
            
            car.isDirty = NO;
			NSLog(@"%@ finished wash car %@", workerName, carName);
            [car process:self];
			[self didFinishWork];
		});
	}
}

@end
