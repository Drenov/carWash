//
//  CWDirector.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//


#import "CWDirector.h"
#import "CWAccountant.h"

@implementation CWDirector

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(CWAccountant *)accountant {
    @synchronized (self) {
		if ([accountant isMemberOfClass:[CWAccountant class]]) {
			NSString *bossName = self.name;
			NSLog(@"%@ come to room", bossName);
			NSUInteger workerPocket = accountant.pocket;
			NSUInteger cash = (self.pocket += workerPocket);
			accountant.pocket = 0;
			if (workerPocket > 10) {
				NSLog(@"!!!!!!!!!!Warning.Director money take");
			}
			NSLog(@"%@ take profit of %lu$ from %@ and has %lu in total",	bossName,
																			workerPocket,
																			accountant.name,
																			cash);
            accountant.isBusy = NO;
            [accountant isReadyToWork];
		}
	}
}

- (void)didFinishProcessing:(id)worker {
	[self process:worker];
}

@end
