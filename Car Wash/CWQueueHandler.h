//
//  CWWorkerAdministrator.h
//  Car Wash
//
//  Created by Dren Drenov on 27.03.14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWObserver.h"
#import "CWWorkflow.h"
#import "CWHandling.h"

@interface CWQueueHandler : CWObserver <CWWorkflow>
@property (nonatomic, readonly)     NSArray     *handlers;
@property (nonatomic, readonly)     NSArray     *processingQueue;

- (void)addHandler:(id <CWHandling>)object;
- (void)removeHandler:(id <CWHandling>)object;

@end
