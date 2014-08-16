//
//  main.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWMainCarWash.h"

#import "CWCar.h"

#import "CWRoom.h"
#import "CWWasher.h"
#import "CWWashBuilding.h"

static const NSUInteger carsQuantity = 1000;
static const NSUInteger	CWCarArriveDelay = 0;

int main(int argc, const char * argv[])
{
    @autoreleasepool {
		NSLog(@"Start generating cars");
		NSMutableArray *cars = [NSMutableArray array];
		for (NSUInteger i = 0; i < carsQuantity; i++) {
			CWCar *car =[CWCar object];
            //NSLog(@"Car %lu is %@", (unsigned long)i+1, [car registrationPlate]);
			[cars addObject:car];
		}
		NSLog(@"Cars generation done");
		NSLog(@"<<<< Starting Car Wash >>>>>\n\n");
		CWMainCarWash *mainCarWash = [CWMainCarWash object];
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			for (CWCar *car in cars) {
				sleep(CWCarArriveDelay);
                [mainCarWash process:car];
			}
			NSLog(@">>>>>>>>>No more new cars<<<<<<<<<<<");
		});        
        NSLog(@"<<<<<Car wash is working>>>>>\n\n");
        
		[[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}

