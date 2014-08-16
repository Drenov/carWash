//
//  CWWorker.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/25/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//
/*Class have to create workers, remove workers, transfer money from pockets
 strore worker data (name,salary,pocket,experience)
 
 */

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"
#import "CWHandling.h"
#import "CWObserver.h"

@interface CWWorker : CWObserver <CWHandling>
@property (atomic, assign)      NSUInteger	pocket;
@property (nonatomic, copy)		NSString	*name;
@property (nonatomic, assign)	BOOL		isBusy;
@property (nonatomic, assign)	NSUInteger	salary;
@property (nonatomic, assign)	NSUInteger	workExperience;

+ (id)workerWithName:(NSString *)name
			  salary:(NSUInteger)salary
		   experince:(NSUInteger)workExperience;

- (void)didFinishWork;
- (void)isReadyToWork;

@end
