//
//  CWRoom.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//
//Class have to add room, remove room, keep room capacity
//add workers, remove workers, keep workers array(with write protection)

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"
#import "CWObserver.h"

@class CWWorker;
@class CWDirector;

@interface CWRoom : CWObserver
@property (nonatomic, copy)		NSString	*roomTitle;
@property (nonatomic, assign)	NSInteger	workersCapacity;
@property (nonatomic, readonly)	NSArray		*workers;
@property (nonatomic, readonly)	NSInteger	freeWorkers;

+ (id)roomWithCapacity:(NSUInteger)workersCapacity
                roomTitle:(NSString *)roomTitle;

- (void)addWorker:(CWWorker *)worker;
- (void)removeWorker:(CWWorker *)worker;

- (void)reservWorker;
- (void)unReservWorker;

@end
