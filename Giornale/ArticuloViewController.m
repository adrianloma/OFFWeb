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
        int veces;
        bool sw;
        NSString *textEnMedio;
        NSString *contenido;
        self.tituloArticulo.text = [_artRec objectForKey:@"titulo"];
        [self.urlArticulo setTitle:[_artRec objectForKey:@"url"] forState:UIControlStateNormal];
    
        contenido=[_artRec objectForKey:@"contenido"];
        
        contenido =[contenido stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
        contenido =[contenido stringByReplacingOccurrencesOfString:@"[[" withString:@""];
        contenido =[contenido stringByReplacingOccurrencesOfString:@"]]" withString:@""];
        
        contenido =[contenido stringByReplacingOccurrencesOfString:@"{{" withString:@"<span hidden>"];
        contenido =[contenido stringByReplacingOccurrencesOfString:@"}}" withString:@"</span>"];
        contenido =[contenido stringByReplacingOccurrencesOfString:@"</span><br/><span hidden>" withString:@"</span><span hidden>"];
        
        veces = [[contenido componentsSeparatedByString:@"'''"] count]-1;
        sw = false;
        for (int x=0; x<veces; x++) {
            if (!sw) {
                NSRange loc = [contenido rangeOfString:@"'''"];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"<b>"];
                sw =true;
            } else {
                NSRange loc = [contenido rangeOfString:@"'''"];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"</b>"];
                sw =false;
            }
        }
        
        veces = [[contenido componentsSeparatedByString:@"\""] count]-1;
        sw = false;
        for (int x=0; x<veces; x++) {
            if (!sw) {
                NSRange loc = [contenido rangeOfString:@"\""];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"<i>"];
                sw =true;
            } else {
                NSRange loc = [contenido rangeOfString:@"\""];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"</i>"];
                sw =false;
            }
        }
        
        veces = [[contenido componentsSeparatedByString:@"''"] count]-1;
        sw = false;
        for (int x=0; x<veces; x++) {
            if (!sw) {
                NSRange loc = [contenido rangeOfString:@"''"];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"<i>"];
                sw =true;
            } else {
                NSRange loc = [contenido rangeOfString:@"''"];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"</i>"];
                sw =false;
            }
        }
        
        
        veces = [[contenido componentsSeparatedByString:@"==="] count]-1;
        sw = false;
        for (int x=0; x<veces; x++) {
            if (!sw) {
                NSRange loc = [contenido rangeOfString:@"==="];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"<h4>"];
                sw =true;
            } else {
                NSRange loc = [contenido rangeOfString:@"==="];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"</h4>"];
                sw =false;
            }
        }
        
        
        
        veces = [[contenido componentsSeparatedByString:@"=="] count]-1;
        sw = false;
        for (int x=0; x<veces; x++) {
            if (!sw) {
                NSRange loc = [contenido rangeOfString:@"=="];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"<h3>"];
                sw =true;
            } else {
                NSRange loc = [contenido rangeOfString:@"=="];
                contenido = [contenido stringByReplacingCharactersInRange:loc withString:@"</h3>"];
                sw =false;
            }
        }
        
        
        
        
        [self.viewArticulo loadHTMLString:contenido baseURL:nil];
        
        NSLog(contenido);
    
        
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
