//
//  CWHandling.h
//  Car Wash
//
//  Created by Dren Drenov on 06.04.14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWWorkflow.h"

@protocol CWHandling <CWWorkflow>

@required

- (BOOL)isBusy;

@end
