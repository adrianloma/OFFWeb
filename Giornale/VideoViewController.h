//
//  VideoViewController.h
//  Giornale
//
//  Created by Adrian Lozano on 11/30/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backButton:(id)sender;

@end
