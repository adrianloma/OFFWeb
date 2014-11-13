//
//  NavegadorViewController.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonArticulos.h"

@interface NavegadorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *vistaWeb;
- (IBAction)irWikipedia:(id)sender;
- (IBAction)guardarArticulo:(id)sender;

@property (strong,nonatomic) SingletonArticulos *singleArticulos;

@end
