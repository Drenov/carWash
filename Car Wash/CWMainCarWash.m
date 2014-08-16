//
//  CWMainCarWash.m
//  Car Wash
//
//  Created by Dren Drenov on 03.03.14.
//  Copyright (c) 2014 Mykhailov Andrii. All rights reserved.
//

#import "CWMainCarWash.h"

#import "CWWashBuilding.h"
#import "CWAdminBulding.h"

#import "CWAdminRoom.h"
#import "CWQueueHandler.h"
#import "CWCarWashingRoom.h"

#import "CWCar.h"

#import "CWWasher.h"
#import "CWDirector.h"
#import "CWAccountant.h"

static const NSUInteger CWBossSalary = 1000;
static const NSUInteger CWWasherSalary = 100;
static const NSUInteger CWAccountantSalary = 500;

static const NSUInteger CWGenericExpirience = 1;

@interface CWMainCarWash ()
@property (nonatomic, retain) CWWashBuilding    *washBuilding;
@property (nonatomic, retain) CWAdminBulding	*adminBuilding;

@property (nonatomic, retain) CWQueueHandler *carAdministrator;
@property (nonatomic, retain) CWQueueHandler *workerAdministrator;

@property (nonatomic, retain)	NSMutableDictionary	*washerInCar;

- (void)initializeCarWash;

@end

@implementation CWMainCarWash

@synthesize washBuilding	= _washBuilding;
@synthesize adminBuilding	= _adminBuilding;
@synthesize carAdministrator   = _carAdministrator;
@synthesize workerAdministrator = _workerAdministrator;

@synthesize washerInCar = _washerInCar;

#pragma mark
#pragma mark Initializations and Deallocations

- (void)dealloc {
   	self.adminBuilding = nil;
	self.washBuilding = nil;
	self.carAdministrator = nil;
    self.workerAdministrator = nil;
    self.washerInCar = nil;
	[super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
        self.washerInCar = [NSMutableDictionary dictionary];
		[self initializeCarWash];
	}
	
	return self;
}

#pragma mark-
#pragma mark Public Methods

- (void)process:(CWCar *)car {
    if (![car isMemberOfClass:[CWCar class]]) {
        NSLog(@"Error. Car wash can process cars only");
        return;
    }
    NSLog(@"Car %@ ask for washing", car.registrationPlate);
    CWQueueHandler *carAdministrator = self.carAdministrator;
    [carAdministrator process:car];
}

#pragma mark-
#pragma mark Private Methods
	 
- (void)generateBuildings {
	self.washBuilding =	[CWWashBuilding object];
	self.adminBuilding = [CWAdminBulding object];
	[self.washBuilding addRoom: [CWCarWashingRoom roomWithCapacity:2 roomTitle:@"Big Wash Station"]];
	[self.washBuilding addRoom: [CWCarWashingRoom roomWithCapacity:3 roomTitle:@"Small Wash station"]];
	[self.adminBuilding addRoom: [CWAdminRoom roomWithCapacity:2 roomTitle:@"Mangers room"]];
    
	NSLog(@"Buildings generation done");
}

- (void)generateWorkers {
	[self.adminBuilding.adminRoom addWorker:[CWDirector workerWithName:@"Boss"
																salary:CWBossSalary
															 experince:CWGenericExpirience]];
	[self.adminBuilding.adminRoom addWorker:[CWAccountant workerWithName:@"Buh Elena"
																  salary:CWAccountantSalary
															   experince:CWGenericExpirience]];
	[[self.washBuilding.rooms objectAtIndex:0] addWorker:[CWWasher workerWithName:@"Washer Vasily"
																		   salary:CWWasherSalary
																		experince:CWGenericExpirience]];
	[[self.washBuilding.rooms objectAtIndex:0] addWorker:[CWWasher workerWithName:@"Washer Petrovich"
																		   salary:CWWasherSalary
																		experince:CWGenericExpirience]];
    [[self.washBuilding.rooms objectAtIndex:1] addWorker:[CWWasher workerWithName:@"Washer Mevlan"
																		   salary:CWWasherSalary
																		experince:CWGenericExpirience]];
    
	NSLog(@"Workers generation done");
}

- (void)designateObserversAndQueueHandlers {
    CWQueueHandler *carAdministrator = [CWQueueHandler object];
    CWQueueHandler *workerAdministrator = [CWQueueHandler object];
    self.carAdministrator = carAdministrator;
    self.workerAdministrator = workerAdministrator;
    
    CWDirector *director = self.adminBuilding.adminRoom.director;
    CWAccountant *accountant = self.adminBuilding.adminRoom.accountant;

	for (CWRoom *washingRoom in self.washBuilding.rooms) {
		for (CWWasher *washer in washingRoom.workers) {
            [washer addObserver:self];
            [washer addObserver:workerAdministrator];
            [washer addObserver:carAdministrator];
            [carAdministrator addHandler:washer];
        }
	}
   	[accountant addObserver:director];
	[accountant addObserver:workerAdministrator];
    [workerAdministrator addHandler:accountant];
    
    NSLog(@"Observers and queue handlers designation done");
}

- (void)initializeCarWash {
	NSLog(@"Generating envirement");
    [self generateBuildings];
	NSLog(@"Generating workers");
    [self generateWorkers];
	NSLog(@"Designate observers and queue handlers");
    [self designateObserversAndQueueHandlers];
    NSLog(@"Initialization done\nCar wash is ready for operation");
}

- (CWBuilding *)buildingForWorker:(CWWorker *)worker {
    if ([worker isMemberOfClass:[CWWasher class]]) {
       
		return self.washBuilding;
    }
    if ([worker isMemberOfClass:[CWAccountant class]]
        || [worker isMemberOfClass:[CWDirector class]]) {
        
        return self.adminBuilding;
    }
    
    return nil;
}

- (CWRoom *)roomForWorker:(CWWorker *)worker {
    CWBuilding *building = [self buildingForWorker:worker];
    if (building == nil) {
        NSLog(@"Error. Bulding search");
        
        return nil;
    }
    for (CWRoom *room in building.rooms){
        if ([room.workers containsObject:worker]) {
            
            return room;
        }
    }
    NSLog(@"Error. Worker search");
    
    return nil;
}

#pragma mark-
#pragma mark Protocol Related Methods

- (void)willProcess:(CWWorker *)washer target:(id)target {
    @synchronized (self) {
        NSLog(@"Will process message recived from %@", washer.name);
        CWCarWashingRoom *washingRoom = (CWCarWashingRoom *)[self roomForWorker:washer];
        if (washingRoom == nil) {
            NSLog(@"Error. Proccesing fault");
            
            return;    
        }
        [self.washerInCar setObject:target forKey:washer.name];
        [washingRoom addCar:target];
        [washingRoom reservWorker];
        
    }
}

- (void)didFinishProcessing:(CWWorker *)worker {
    id syncObject = self.washerInCar;
    @synchronized (syncObject) {
        if ([worker isKindOfClass:[CWWasher class]]) {
            NSString *workerName = worker.name;
            NSLog(@"Main car wash has got did finish notification from %@", workerName); 
            CWCar *car = [syncObject objectForKey: workerName];
            CWCarWashingRoom *washingRoom = (CWCarWashingRoom *)[self roomForWorker:worker];
            [washingRoom removeCar:car];
            [syncObject removeObjectForKey:workerName];
            [self.workerAdministrator process:worker];
        } 
    }
}

- (void)readyToProcess:(CWWasher *)object {
    if ([object isKindOfClass:[CWWasher class]]) {
        CWRoom *washingRoom = [self roomForWorker:object];
        [washingRoom unReservWorker];  
    }
}

@end
