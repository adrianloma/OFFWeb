//
//  TablaArticulosTableViewController.m
//  Giornale
//
//  Created by Roberto Mtz on 11/12/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "TablaArticulosTableViewController.h"
#import "ArticuloViewController.h"

@interface TablaArticulosTableViewController (){
    NSMutableArray *articulos;
    int actual;
}

@end

@implementation TablaArticulosTableViewController

- (void)viewDidLoad {
    self.singleArticulos = [SingletonArticulos getSharedInstance];
    [self cargarArticulos];
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) cargarArticulos{
    articulos = [self.singleArticulos getArticulos];
}

-(void) viewDidAppear:(BOOL)animated{
    //NSLog(@"apareci");
    [self cargarArticulos];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return articulos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *object =articulos[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UISwipeGestureRecognizer *g = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellWasSwiped:)];
    [cell addGestureRecognizer:g];
    //[g release];
    
    //NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object objectForKey:@"titulo"];
    cell.detailTextLabel.text = [object objectForKey:@"url"];
    return cell;
}

- (void)cellWasSwiped:(UIGestureRecognizer *)g {
    //NSLog(@"Swiped");
    
    CGPoint location = [g locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"Row: %d",swipedIndexPath.row]  message:@"Your articles will be opened using internet connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self.singleArticulos borrarArticulo:swipedIndexPath.row];
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [articulos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    bool internet;
    internet = false;
    if ([[segue identifier] isEqualToString:@"mostrarArticulo"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *artSeleccionado = articulos[indexPath.row];
        
        if ([self.switchInternet isOn]){
            internet = true;
        }
        [[segue destinationViewController] setArtRec:artSeleccionado conexion:internet];
    }
}

- (IBAction)conectar:(id)sender {
    if ([self.switchInternet isOn]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Internet activated" message:@"Your articles will be opened using internet connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}
@end
