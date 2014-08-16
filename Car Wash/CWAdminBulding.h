//
//  CWAdminBulding.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWBuilding.h"

@class CWAdminRoom;

@interface CWAdminBulding : CWBuilding
@property (nonatomic, readonly) CWAdminRoom	*adminRoom;

@end
