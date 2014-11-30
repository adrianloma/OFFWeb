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
@property (nonatomic, strong) NSMutableArray *archivados;

-(void) agregarArticulo:(NSDictionary *)articulo;
-(void) borrarArticulo:(NSInteger) pos;
//-(void) crearPlista;
-(void) initArticulos;
-(NSMutableArray *) getArticulos;

+(SingletonArticulos *) getSharedInstance;

@end
