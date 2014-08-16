//
//  CWMainCarWash
//  Car Wash
//
//  Created by Dren Drenov on 03.03.14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"
#import "CWObserver.h"
#import "CWWorkflow.h"

@class CWAdminBulding;
@class CWWashBuilding;

@class CWQueueHandler;
@class CWCar;

@interface CWMainCarWash : CWObserver <CWWorkflow>
@property (nonatomic, readonly) CWWashBuilding	*washBuilding;
@property (nonatomic, readonly) CWAdminBulding	*adminBuilding;

@property (nonatomic, readonly) CWQueueHandler *carAdministrator;
@property (nonatomic, readonly) CWQueueHandler *workerAdministrator;

@end
