//
//  ArticuloViewController.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ArticuloViewController.h"

@interface ArticuloViewController (){
    bool conexion;
}

@end

@implementation ArticuloViewController


- (void)setArtRec:(NSDictionary*)artRec conexion:(bool)internet{
    if (_artRec != artRec) {
        _artRec = artRec;
        conexion = internet;
        // Update the view.
        //[self setDetallesArticulo];
    }
}

- (void)setDetallesArticulo {
    if (self.artRec) {
        
        self.tituloArticulo.text = [_artRec objectForKey:@"titulo"];
        [self.urlArticulo setTitle:[_artRec objectForKey:@"url"] forState:UIControlStateNormal];
        
        if (!conexion){
        
            int veces;
            bool sw;
            NSString *contenido;
        
            contenido=[_artRec objectForKey:@"contenido"];
            
            //cambia saltos de linea por espacios
            contenido =[contenido stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
            contenido =[contenido stringByReplacingOccurrencesOfString:@"[[" withString:@""];
            contenido =[contenido stringByReplacingOccurrencesOfString:@"]]" withString:@""];
            
            //esconde contenido extra
            contenido =[contenido stringByReplacingOccurrencesOfString:@"{{" withString:@"<span hidden>"];
            contenido =[contenido stringByReplacingOccurrencesOfString:@"}}" withString:@"</span>"];
            contenido =[contenido stringByReplacingOccurrencesOfString:@"</span><br/><span hidden>" withString:@"</span><span hidden>"];
            
            //agrega bolds
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
            
            //agrega italics
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
            
            //agrega headings
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
            
            
            //NSLog(contenido);
            
        } else {
            NSURL *url = [NSURL URLWithString:[_artRec objectForKey:@"url"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.viewArticulo loadRequest:request];
        }
    }
}


- (void)viewDidLoad {
    self.viewArticulo.delegate = self;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cambiaOrientacion:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    // Do any additional setup after loading the view.
    
    if(conexion){
        
        //ESTA FUNCION checkInternet SE LLAMA ASINCRONICAMENTE
        [self checkInternet:^(BOOL isConnected)
         {
             if (!isConnected)
             {
                 //alerta
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No internet connection!" message:@"It seems you don't have an internet connection! The offline version of this article will be displayed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alertView show];
                 //
                 conexion = false;
             }
             
             [self setDetallesArticulo];
         }];
        
        //end funcion asincronica
    } else{
        [self setDetallesArticulo];
    }
    
    
    
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loading.frame = CGRectMake(0, 0, 40, 40);
    self.loading.center = self.view.center;
    [self.view addSubview:self.loading];
}

- (void)cambiaOrientacion:(NSNotification *)notification {
    
    
    UIDeviceOrientation orientation;
    
    //identifica la orientación en la que está el dispositivo
    orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
            [self.orientacionBtn setTitle:@"Face Up" ];
            break;
        case UIDeviceOrientationFaceDown:
            [self.orientacionBtn setTitle:@"Face Down"];
            break;
        case UIDeviceOrientationPortrait:
            [self.orientacionBtn setTitle:@"Portrait Mode"];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self.orientacionBtn setTitle:@"Portrait Mode"];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self.orientacionBtn setTitle:@"Landscape Mode"];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self.orientacionBtn setTitle:@"Landscape Mode"];
            break;
        default:
            [self.orientacionBtn setTitle:@""];
            break;
    }
}



-(void)webViewDidStartLoad:(UIWebView *)vistaWeb{
    
    [self.loading startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)vistaWeb{
    
    [self.loading stopAnimating];
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


- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Connectivity

typedef void(^connection)(BOOL);

- (void)checkInternet:(connection)block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 10.0;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         block([(NSHTTPURLResponse *)response statusCode] == 200);
     }];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //check if shake gesture was invoked
    if (UIEventSubtypeMotionShake && !conexion) {
        //check if user has internet
        [self checkInternet:^(BOOL isConnected)
         {
             if (isConnected)
             {
                 NSLog(@"Internet is working");
                 UIAlertView *alert = [[UIAlertView alloc]
                                       initWithTitle:@"Internet connection found!"
                                       message:@"Do you want to view the online version?"
                                       delegate:self  // set nil if you don't want the yes button callback
                                       cancelButtonTitle:@"No"
                                       otherButtonTitles:@"Yes", nil];
                 [alert show];
             }
             else
             {
                 //alert
                 NSLog(@"Internet is NOT working");
             }
         }];
    }
}



// yes button callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        conexion = true;
        //alert
        [self setDetallesArticulo];
    }
}



@end
