//
//  SingletonArticulos.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface SingletonArticulos : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//@property (nonatomic, strong) NSMutableArray *articulos;

-(void) agregarArticulo:(NSDictionary *)articulo;
-(void) borrarArticulo:(NSInteger) pos;
//-(void) crearPlista;
-(void) initArticulos;
-(NSMutableArray *) getArticulos;
-(BOOL)isAlreadySavedWithURL:(NSString *) url;

+(SingletonArticulos *) getSharedInstance;

@end
