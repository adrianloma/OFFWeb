//
//  NavegadorViewController.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "NavegadorViewController.h"

@interface NavegadorViewController (){
    NSMutableArray *articulos;
}

@end

@implementation NavegadorViewController

- (void)viewDidLoad {
    self.singleArticulos = [SingletonArticulos getSharedInstance];
    articulos = [self.singleArticulos getArticulos];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    NSString *fullURL = @"http://www.wikipedia.com";
    
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.vistaWeb loadRequest:request];
    
}

- (IBAction)guardarArticulo:(id)sender {
    //NSLog(@"hola en guardar");
    NSString *urlOriginal = self.vistaWeb.request.URL.absoluteString;
    NSString *titulo = [urlOriginal substringFromIndex:31];
    NSString *url = [[NSString alloc] initWithFormat:@"http://en.wikipedia.org/w/index.php?title=%@&action=raw", titulo];
    //NSLog(url);
    NSURL *urlRequest = [NSURL URLWithString:url];
    
    NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:nil];
    //NSLog(html);
    
    NSDictionary *artPorAgregar = [NSDictionary dictionaryWithObjectsAndKeys:
                                   titulo,@"titulo",
                                   urlOriginal,@"url",
                                   html,@"contenido",
                                   nil];
    
    [self.singleArticulos agregarArticulo:artPorAgregar];
    
}
@end
