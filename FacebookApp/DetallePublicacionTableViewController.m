//
//  DetallePublicacionTableViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 16/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "DetallePublicacionTableViewController.h"
#import "ObjectDataMaper.h"
#import "WebServices.h"

@interface DetallePublicacionTableViewController ()

@end

@implementation DetallePublicacionTableViewController {
    BOOL editando;
    ObjectDataMaper *odm;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    odm = [[ObjectDataMaper alloc] init];
    // muestro el contenido del objeto publicación del timeline
    // en las propieades label y textview
    
    self.lblAutor.text = [[self.publicacion objectForKey:@"user"] objectForKey:@"username"];
    self.textMensaje.text = [self.publicacion objectForKey:@"message"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    editando = NO;
    
    if ([[[self.publicacion objectForKey:@"user"] objectForKey:@"_id"] isEqualToString:@"54149abb96752e0000654bb9"]) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    else {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark - Actions

- (IBAction)cerrar:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editarPublicacion:(id)sender {
    
    if (editando) {
        editando = NO;
        self.navigationItem.rightBarButtonItem.title = @"Editar";
        
        NSDictionary *pub = @{
                              @"_id": [self.publicacion objectForKey:@"_id"],
                              @"message": self.textMensaje.text
                             };
        
        NSDictionary *response = [WebServices editPublication:pub];
        
        if (![[response objectForKey:@"success"] boolValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        editando = YES;
        self.navigationItem.rightBarButtonItem.title = @"Guardar";
    }
    
    [self.textMensaje setEditable:editando];
    [self.textMensaje setSelectable:editando];
    [self.textMensaje becomeFirstResponder];
    self.textMensaje.selectedRange = NSMakeRange([self.textMensaje.text length], 0);
}

- (IBAction)editarPublicacionCoreData:(id)sender {
    if (editando) {
        editando = NO;
        self.navigationItem.rightBarButtonItem.title = @"Editar";
        
        // el error al editar, es que no estabamos actualizando la información y no se veía reflejado el cambio, error tonto
        NSDictionary *pubActualizada = @{
                                         @"id": [self.publicacion objectForKey:@"id"],
                                         @"autor": [self.publicacion objectForKey:@"autor"],
                                         @"mensaje": self.textMensaje.text,
                                         @"latitud": [self.publicacion objectForKey:@"latitud"],
                                         @"longitud": [self.publicacion objectForKey:@"longitud"]
                                         };
        
        // método para actualizar
        if (![odm editarPublicacion:pubActualizada]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Ocurrió un error al editar la publicación" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        editando = YES;
        self.navigationItem.rightBarButtonItem.title = @"Guardar";
    }
    
    [self.textMensaje setEditable:editando];
    [self.textMensaje setSelectable:editando];
    [self.textMensaje becomeFirstResponder];
    self.textMensaje.selectedRange = NSMakeRange([self.textMensaje.text length], 0);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
