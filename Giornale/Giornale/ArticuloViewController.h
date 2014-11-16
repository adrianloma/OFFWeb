//
//  ArticuloViewController.h
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticuloViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *tituloArticulo;
@property (strong, nonatomic) IBOutlet UILabel *contenidoArticulo;
@property (strong, nonatomic) IBOutlet UIButton *urlArticulo;
- (IBAction)irArticuloWeb:(id)sender;

@property (strong, nonatomic) NSDictionary *artRec;

@end
