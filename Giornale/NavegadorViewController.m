//
//  NavegadorViewController.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "NavegadorViewController.h"

@interface NavegadorViewController (){
   // NSMutableArray *articulos;
}

@end

@implementation NavegadorViewController

- (void)viewDidLoad {
    self.vistaWeb.delegate = self;
    self.singleArticulos = [SingletonArticulos getSharedInstance];
    //articulos = [self.singleArticulos getArticulos];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadPage];
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loading.frame = CGRectMake(0, 0, 40, 40);
    self.loading.center = self.view.center;
    [self.view addSubview:self.loading];
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

- (IBAction)irWikipedia:(id)sender {
    
    [self reloadPage];

}

- (void) reloadPage{
    [self checkInternet:^(BOOL isConnected)
     {
         if (isConnected)
         {
             NSString *fullURL = @"http://en.wikipedia.com";
             
             NSURL *url = [NSURL URLWithString:fullURL];
             NSURLRequest *request = [NSURLRequest requestWithURL:url];
             [self.vistaWeb loadRequest:request];
             
         }
         else
         {
             //alert
             [self.vistaWeb loadHTMLString:@"<html>	<h1>Uh-oh! No internet conection detected<br>   x_x</h1></html>" baseURL:nil];
             NSLog(@"Internet is NOT working");
             // No "Internet" aka no Google
         }
     }];
    
}

- (IBAction)guardarArticulo:(id)sender {
    //NSLog(@"hola en guardar");
    NSString *urlOriginal = self.vistaWeb.request.URL.absoluteString;
    
    if (urlOriginal.length > 31){
    
        NSString *titulo = [urlOriginal substringFromIndex:31];
        titulo = [titulo capitalizedString]; //capitaliza titulo
        titulo = [titulo stringByReplacingOccurrencesOfString:@"_And_" withString:@"_and_"];
        titulo = [titulo stringByReplacingOccurrencesOfString:@"_Of_" withString:@"_of_"];
        titulo = [titulo stringByReplacingOccurrencesOfString:@"_The_" withString:@"_the_"];
        NSString *url = [[NSString alloc] initWithFormat:@"http://en.wikipedia.org/w/index.php?title=%@&action=raw", titulo];
        NSLog(url);
        titulo = [titulo stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        NSURL *urlRequest = [NSURL URLWithString:url];
        
        NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:nil];
        //NSLog(html);
        
        NSDictionary *artPorAgregar = [NSDictionary dictionaryWithObjectsAndKeys:
                                       titulo,@"titulo",
                                       urlOriginal,@"url",
                                       html,@"contenido",
                                       nil];
        
        [self.singleArticulos agregarArticulo:artPorAgregar];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[artPorAgregar objectForKey:@"titulo"] message:@"Your article has been added to your news." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"URL error" message:@"The page you're trying to save is not an article. \nPage not saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)vistaWeb{
    
    [self.loading startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)vistaWeb{
    
    [self.loading stopAnimating];
}

- (IBAction)compartirFacebook:(id)sender {
    
    NSString *textToPost = [NSString stringWithFormat:@"I loved this article! %@ \nShared with Giornale.", self.vistaWeb.request.URL.absoluteString];
    
    NSArray *activityItems = @[textToPost];
    
    self.activityViewController = [[UIActivityViewController alloc]
                                   initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:self.activityViewController animated:YES completion:nil];
    
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
@end
