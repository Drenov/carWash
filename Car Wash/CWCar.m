//
//  CWCar.m
//  Car Wash
//
//  Created by Mykhailov Andrii on 2/26/14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWCar.h"
#import "CWWorker.h"

@interface CWCar ()

- (NSString *)randomRegistrationPlate;

@end

@implementation CWCar
@synthesize pocket	= _pocket;
@synthesize isDirty	= _isDirty;
@synthesize washPrice	= _washPrice;
@synthesize registrationPlate	= _registrationPlate;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.registrationPlate = nil;
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
		self.pocket = 100;
		self.isDirty = YES;
		self.registrationPlate = [self randomRegistrationPlate];
    }
    
    return self;
}

#pragma mark-
#pragma mark Public Methods

- (void)payToWorker:(CWWorker *)worker
			invoice:(NSInteger)invoice
{
    @synchronized (self) {
        self.pocket -= invoice;
        worker.pocket += invoice;
        NSLog(@"Car %@ payed to %@ invoice with %lu total", self.registrationPlate,
                                                            worker.name,
                                                            invoice);
    }
}

#pragma mark-
#pragma mark Private Methods

- (NSString *)randomRegistrationPlate {
    NSArray *capitals = [NSArray arrayWithObjects:@"AH",@"AE",@"AK",@"HA", @"EK", @"EKH", nil];
    uint32_t count = (uint32_t)[capitals count];
    NSUInteger indices[2] = {(arc4random() % count), (arc4random() % count)};
	uint digits = arc4random() % 9999;
    NSString *plate = [NSString stringWithFormat:@"%@%i%@",
                      [capitals objectAtIndex:(indices[0])],
                      (uint)digits,
                      [capitals objectAtIndex:(indices[1])]];
    
    return [plate uppercaseString];
}

#pragma mark-
#pragma mark Protocol Related Methods

- (void)process:(id)worker {
	if ([worker isKindOfClass:[CWWorker class]]) {
		[self payToWorker:worker invoice:self.washPrice];
	}
}

@end
