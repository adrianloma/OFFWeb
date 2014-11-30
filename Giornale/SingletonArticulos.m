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
}

-(void) initArticulos{
    _articulos = [NSMutableArray arrayWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:
                  @"Articulo 1",@"titulo",
                  @"www.wikipedia.com",@"url",
                  @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vehicula in elit id scelerisque. Fusce consequat bibendum enim sit amet finibus. Aliquam non diam mauris. Donec turpis lorem, bibendum at consectetur at, accumsan quis turpis. Fusce nec mollis sapien. Ut dapibus euismod vulputate. Duis non felis at purus mollis sollicitudin laoreet at velit. Mauris a congue dui. Maecenas vestibulum convallis nisl, quis molestie metus. Integer aliquet sed metus non tincidunt. Integer mauris urna, lacinia nec hendrerit eget, placerat non sem. Cras posuere, arcu ut molestie imperdiet, tortor nunc venenatis urna, ut efficitur augue diam efficitur mi. Quisque sed consequat mi. Quisque pretium accumsan pretium. Vivamus sem augue, iaculis vel egestas quis, tristique ut leo. Suspendisse rutrum nisl vitae volutpat bibendum. Aenean sed felis vel eros congue tristique. Curabitur ut suscipit mauris, et semper tellus. Sed ac scelerisque arcu. Morbi et erat tellus. Phasellus sodales sem mauris, ut iaculis mi vehicula id. Curabitur sit amet nisi dictum, blandit mauris sed, volutpat odio. Nulla facilisi. Sed iaculis pretium rhoncus. Pellentesque luctus quis ipsum in porta.",@"contenido",
                  nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:
                  @"Articulo 2",@"titulo",
                  @"www.mashable.com",@"url",
                  @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vehicula in elit id scelerisque. Fusce consequat bibendum enim sit amet finibus. Aliquam non diam mauris. Donec turpis lorem, bibendum at consectetur at, accumsan quis turpis. Fusce nec mollis sapien. Ut dapibus euismod vulputate. Duis non felis at purus mollis sollicitudin laoreet at velit. Mauris a congue dui. Maecenas vestibulum convallis nisl, quis molestie metus. Integer aliquet sed metus non tincidunt. Integer mauris urna, lacinia nec hendrerit eget, placerat non sem. Cras posuere, arcu ut molestie imperdiet, tortor nunc venenatis urna, ut efficitur augue diam efficitur mi. Quisque sed consequat mi. Quisque pretium accumsan pretium. Vivamus sem augue, iaculis vel egestas quis, tristique ut leo. Suspendisse rutrum nisl vitae volutpat bibendum. Aenean sed felis vel eros congue tristique. Curabitur ut suscipit mauris, et semper tellus. Sed ac scelerisque arcu. Morbi et erat tellus. Phasellus sodales sem mauris, ut iaculis mi vehicula id. Curabitur sit amet nisi dictum, blandit mauris sed, volutpat odio. Nulla facilisi. Sed iaculis pretium rhoncus. Pellentesque luctus quis ipsum in porta.",@"contenido",
                  nil],
                 nil];
    posArtAct=2;

}

-(void) agregarArticulo:(NSDictionary *)articulo{
    [self.articulos insertObject:articulo atIndex:posArtAct];
    posArtAct++;

}

-(void) borrarArticulo:(NSInteger) pos{
    [self.articulos removeObjectAtIndex:pos];
}

+(SingletonArticulos *) getSharedInstance{
    static SingletonArticulos *_sharedInstance;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{_sharedInstance = [[SingletonArticulos alloc] init];
    });
    
    [_sharedInstance initArticulos];
    return _sharedInstance;
}

-(NSMutableArray *) getArticulos{
    return self.articulos;
}

-(NSMutableArray *) getArchivados{
    return self.archivados;
}




@end
