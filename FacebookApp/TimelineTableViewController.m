//
//  TimelineTableViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 16/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "ObjectDataMaper.h"
#import "WebServices.h"
// Si se pone el .m hay error en compilación
// y se van a llevar su primer dolor de cabeza buscando que es :(
#import "DetallePublicacionTableViewController.h"

@interface TimelineTableViewController ()

@end

@implementation TimelineTableViewController {
    // Esta variable puede ser accedida en toda la clase (global)
    NSMutableArray *publicaciones;
    ObjectDataMaper *odm;
    
    UIRefreshControl *refreshControl;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Carga todas las configuraciones de la vista, antes de mostrarse
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadPublications) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    odm = [[ObjectDataMaper alloc] init];
    
    // Aquí se crea la instancia de la variable
    // Xcode pone de otro color las variables globales de la clase
    publicaciones = [[NSMutableArray alloc] init];

    /*
     Lo mismo que arriba
    NSMutableArray *publications;
    publications = [NSMutableArray alloc];
    publications = [NSMutableArray init];
    */
    
    /*
     JSON:
     {
       mensaje: "",
       autor: ""
     }
     */
    
    /*
    // Nuestro objeto publicacion tiene dos atributos, mensaje y autor
    NSMutableDictionary *publicacion = [[NSMutableDictionary alloc] init];
    [publicacion setValue:@"Curso de Programación iOS" forKey:@"mensaje"];
    [publicacion setValue:@"Red Rabbit" forKey:@"autor"];
    
    [publicaciones addObject:publicacion]; // Se agrega la primera publicación al listado de publicaciones
    
    publicacion = [[NSMutableDictionary alloc] init];
    [publicacion setValue:@"Sábados de 9 a 2 pm en el Centro de Computo Tec de Culiacán" forKey:@"mensaje"];
    [publicacion setValue:@"Red Rabbit" forKey:@"autor"];
    
    [publicaciones addObject:publicacion]; // agregamos la segunda publicación al listado de publicaciones
    
    // usamos la misma variable pero usamos otro espacio en memoria
    publicacion = [[NSMutableDictionary alloc] init];
    [publicacion setValue:@"Instructor Jesús Ruiz. Twitter: @jaruizlopez GitHub: @jesusruizlopez" forKey:@"mensaje"];
    [publicacion setValue:@"Red Rabbit" forKey:@"autor"];

    [publicaciones addObject:publicacion]; // agregamos la tercera publicación al listado de publicaciones
    
    NSLog(@"%@", publicaciones);
     */
}

// Antes de que se muestre la pantalla, después de que se cargaron las configuraciones (viewDidLoad)
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:@"publicaciones"] != nil) {
        publicaciones = [ud objectForKey:@"publicaciones"];
        
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [publicaciones count]];
        
        // cuando tenemos información actualizada y queremos notificarle a nuestra vista por medio del componente UITableView, hay que usar el siguiente método
        // este método recarga los datos usando cellForRowAtIndexPath (actualizando con los nuevos valores)
        [self.tableView reloadData];
    }
}
 */

- (void)loadPublications {
    
    NSDictionary *response = [WebServices getPublications];
    
    if ([[response objectForKey:@"success"] boolValue]) {
        publicaciones = [response objectForKey:@"publications"];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // publicaciones = [odm obtenerPublicaciones];
    [self loadPublications];
    self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [publicaciones count]];
    [self.tableView reloadData];
}

// Después de que se mostró la pantalla y se cargaron las configuraciones
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // obtenemos la publicación usando el número de celda que estamos eliminando
        
        // el error del eliminar, era porque estaba obteniendo mal el objeto de publicaciones, por alguna razón usaba [self.tableView indexPathForSelectedRow] en vez de simplemente usar el indexPath que recibo como parametro, otro error tonto, lo que hace el sueño y la desvelada
        NSDictionary *pub = [publicaciones objectAtIndex:indexPath.row];

        // ejecutamos eliminarPublicacion, si no se elimina de la base de datos, manda una alerta
        if (![odm eliminarPublicacion:[pub objectForKey:@"id"]]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudo eliminar la publicación" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            
            // si se elimina de la base de datos, removemos el objeto del arreglo publicaciones y visualmente de la tabla
            [publicaciones removeObjectAtIndex:indexPath.row];
            
            // actualizamos el indicador visualmente, con el nuevo número de publicaciones
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [publicaciones count]];
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [publicaciones count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath se conforma de una sección y una fila
    // solo tenemos una sección, entonces siempre será 0
    // tenemos 3 filas que irán del 0 al 2
    // enlazo la parte visual de la celda con el código por medio de un identificador único
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timelineCell" forIndexPath:indexPath];
    
    // obtenemos los elementos del arreglo con las publicaciones accediendo con un indice, que nos proporciona el row de indexPath
    NSMutableDictionary *obj = [publicaciones objectAtIndex:indexPath.row];
    
    // mostramos los valores del objeto por medio de la llave que asignamos y mostramos en los label de la celda
    cell.textLabel.text = [obj objectForKey:@"message"];
    
    NSString *name;
    if ([[obj objectForKey:@"edited"] boolValue]) {
        name = [NSString stringWithFormat:@"%@ - Editado", [[obj objectForKey:@"user"] objectForKey:@"username"]];
    }
    else {
        name = [[obj objectForKey:@"user"] objectForKey:@"username"];
    }
    
    cell.detailTextLabel.text = name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 69;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Eliminar";
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // obtenemos que elemento de la tabla está seleccionado y sacamos el indexPath (section, row)
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    
    // identifico que segue está haciendo uso del método, ya que en una pantalla puedo tener muchos segue para diferente navegación
    if ([[segue identifier] isEqualToString:@"detallePublicacionSegue"]) {

        // el destino del segue es un NavigationController
        UINavigationController *navigation = [segue destinationViewController];
        // el navigationController contiene nuestro viewController llamado DetallePublicacionTableViewController y accedemos a el de la siguiente forma
        DetallePublicacionTableViewController *dptvc = [navigation.viewControllers objectAtIndex:0];
        
        // obtenemos la publicación del arreglo con las publicaciones
        dptvc.publicacion = [publicaciones objectAtIndex:index.row];
    }
    else if ([[segue identifier] isEqualToString:@"detallePublicacionPushSegue"]) {
        DetallePublicacionTableViewController *dptvc = [segue destinationViewController];
        dptvc.publicacion = [publicaciones objectAtIndex:index.row];
    }
}

@end
