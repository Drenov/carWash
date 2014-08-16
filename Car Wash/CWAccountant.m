//
//  CWAccountant.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWAccountant.h"
#import "CWWasher.h"

static const NSUInteger	CWMaxCountTime = 0;

@implementation CWAccountant

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(CWWorker *)worker {
	@synchronized (self) {
		if ([worker isMemberOfClass:[CWWasher class]]) {
			self.isBusy = YES;
			NSUInteger workerPocket = worker.pocket;
			NSUInteger cash = (self.pocket += workerPocket);
			worker.pocket = 0;
			NSLog(@"%@ get %lu from %@ and has %lu in total", self.name,
															  workerPocket,
															  worker.name,
															  cash);
            worker.isBusy = NO;
            [worker isReadyToWork];
			dispatch_async((dispatch_get_global_queue(0, 0)), ^{
				NSLog(@"Accountant counting money");
				sleep(CWMaxCountTime);
				NSLog(@"Accountanf has finished counting and notify");
				[self didFinishWork];
			});
		}
	}
}

@end
