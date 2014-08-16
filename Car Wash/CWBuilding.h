//
//  CWBuilding.h
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/27/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//
/*Class have to add buldings, remove bulding -no
 add rooms, remove rooms; keep array of rooms for each class instance*/

#import <Foundation/Foundation.h>
#import "NSObject+CWExtensions.h"

@class CWRoom;

@interface CWBuilding : NSObject
@property (nonatomic, readonly)		NSArray		*rooms;

- (void)addRoom:(CWRoom *)room;
- (void)removeRoom:(CWRoom *)room;

@end
