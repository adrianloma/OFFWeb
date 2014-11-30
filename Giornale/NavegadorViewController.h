//
//  NavegadorViewController.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "SingletonArticulos.h"

@interface NavegadorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *vistaWeb;
@property (strong, nonatomic) UIActivityViewController *activityViewController;
@property (strong, nonatomic) UIActivityIndicatorView *loading;
- (IBAction)irWikipedia:(id)sender;
- (IBAction)guardarArticulo:(id)sender;
- (IBAction)compartirFacebook:(id)sender;

@property (strong,nonatomic) SingletonArticulos *singleArticulos;

@end
