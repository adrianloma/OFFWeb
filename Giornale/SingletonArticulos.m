//
//  SingletonArticulos.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "SingletonArticulos.h"

@implementation SingletonArticulos{
    int posArtAct;
    NSMutableArray *_articulos;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(void) initArticulos{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Articulo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    
    _articulos = [[NSMutableArray alloc] init];
    


    
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"titulo", @"url", @"contenido", nil];
    for (int i = 0; i < objects.count; i++) {
        [_articulos addObject:[objects[i] dictionaryWithValuesForKeys:keys]];
        
    }
    

}

-(void) agregarArticulo:(NSDictionary *)articulo{
    [_articulos addObject:articulo];
    NSManagedObjectContext *context = self.managedObjectContext;
    NSManagedObjectContext *newManagementObject = [NSEntityDescription insertNewObjectForEntityForName:@"Articulo" inManagedObjectContext:context];
    
    [newManagementObject setValuesForKeysWithDictionary:articulo];
    
    
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Unresolved log %@, %@", error, [error userInfo]);
    }

}

-(void) borrarArticulo:(NSInteger) pos{
    [_articulos removeObjectAtIndex:pos];
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Articulo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    
    [context deleteObject:objects[pos]];
    
    error = nil;
    if(![context save:&error]){
        NSLog(@"Unresolved log %@, %@", error, [error userInfo]);
    }
    
}

-(BOOL)isAlreadySavedWithURL:(NSString *) url{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Articulo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicado = [NSPredicate predicateWithFormat:@"(url = %@)",url];
    [request setPredicate:predicado];
    
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if([objects count] == 0){
        NSLog( @"No existen materias para cargar");
        return  FALSE;
    }else {
        return TRUE;
    }
}

+(SingletonArticulos *) getSharedInstance{
    static SingletonArticulos *_sharedInstance;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{_sharedInstance = [[SingletonArticulos alloc] init]; [_sharedInstance initArticulos];
    });
    
    
    return _sharedInstance;
}

-(NSMutableArray *) getArticulos{
    return _articulos;
}







#pragma mark - Model

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "mx.itesm._190757_Laboratotio_Core_Data" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Articulos" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Articulos.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
