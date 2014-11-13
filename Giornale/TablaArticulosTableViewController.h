//
//  TablaArticulosTableViewController.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonArticulos.h"

@interface TablaArticulosTableViewController : UITableViewController

@property (strong,nonatomic) SingletonArticulos *singleArticulos;

@end
