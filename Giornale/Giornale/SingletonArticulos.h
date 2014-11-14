//
//  SingletonArticulos.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonArticulos : NSObject

@property (nonatomic, strong) NSMutableArray *articulos;

-(void) agregarArticulo:(NSDictionary *)articulo;
//-(void) crearPlista;
-(void) initArticulos;
-(NSMutableArray *) getArticulos;

+(SingletonArticulos *) getSharedInstance;

@end
