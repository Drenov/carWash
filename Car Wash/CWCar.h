//
//  CWCar.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/26/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//
/*Class have to create cars, remove cars,
strore car data (govNumber,pocket,cleanes status)
give money to carwashers
*/

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"
#import	"CWWorkflow.h"
#import "CWObserver.h"

@class CWWorker;

@interface CWCar : NSObject <CWWorkflow>
@property (atomic, assign)		NSInteger   pocket;
@property (nonatomic, copy)		NSString    *registrationPlate;
@property (nonatomic, assign)	BOOL        isDirty;
@property (nonatomic, assign)   NSUInteger  washPrice;

- (void)payToWorker:(CWWorker *)worker
			invoice:(NSInteger)invoice;

@end