//
//  CWCarWashingRoom.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/28/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWRoom.h"

@class CWCar;
@class CWWasher;

@interface CWCarWashingRoom : CWRoom
@property (nonatomic, assign) NSUInteger	totalyServed;
@property (nonatomic, readonly)	NSArray		*waitingLine;

- (void) addCar:(CWCar *)notServicedCar;
- (void) removeCar:(CWCar *) servicedCar;

@end
