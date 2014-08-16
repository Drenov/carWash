//
//  CWFlowOfWorking.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/11/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CWWorkflow <NSObject>

@required

- (void)process:(id)object;

@optional

- (void)readyToProcess:(id)object;
- (void)didFinishProcessing:(id)object;
- (void)willProcess:(id)object target:(id)target;


@end
