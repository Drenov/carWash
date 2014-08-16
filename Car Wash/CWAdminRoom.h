//
//  CWAdminRoom.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 3/3/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWRoom.h"

@class CWDirector;
@class CWAccountant;

@interface CWAdminRoom : CWRoom
@property (nonatomic, readonly)	CWDirector *director;
@property (nonatomic, readonly)	CWAccountant *accountant;

@end
