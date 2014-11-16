//
//  ArticuloViewController.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ArticuloViewController.h"

@interface ArticuloViewController ()

@end

@implementation ArticuloViewController


- (void)setArtRec:(NSDictionary*)artRec{
    if (_artRec != artRec) {
        _artRec = artRec;
        
        // Update the view.
        [self setDetallesArticulo];
    }
}


- (void)setDetallesArticulo {
    if (self.artRec) {
    self.tituloArticulo.text = [_artRec objectForKey:@"titulo"];
    [self.urlArticulo setTitle:[_artRec objectForKey:@"url"] forState:UIControlStateNormal];
    self.contenidoArticulo.text = [_artRec objectForKey:@"contenido"];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDetallesArticulo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)irArticuloWeb:(id)sender {
}
@end
