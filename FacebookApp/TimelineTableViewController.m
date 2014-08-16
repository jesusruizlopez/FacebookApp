//
//  TimelineTableViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 16/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "TimelineTableViewController.h"

// Si se pone el .m hay error en compilación
// y se van a llevar su primer dolor de cabeza buscando que es :(
#import "DetallePublicacionTableViewController.h"

@interface TimelineTableViewController ()

@end

@implementation TimelineTableViewController {
    // Esta variable puede ser accedida en toda la clase
    NSMutableArray *publicaciones;
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
       mensaje: "Atrapan al chapo !!!!",
       autor: "EL DEBATE"
     }
     */
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
}

// Antes de que se muestre la pantalla, después de que se cargaron las configuraciones
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    cell.textLabel.text = [obj objectForKey:@"mensaje"];
    cell.detailTextLabel.text = [obj objectForKey:@"autor"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 69;
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
    // identifico que segue está haciendo uso del método, ya que en una pantalla puedo tener muchos segue para diferente navegación
    if ([[segue identifier] isEqualToString:@"detallePublicacionSegue"]) {
        // obtenemos que elemento de la tabla está seleccionado y sacamos el indexPath (section, row)
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];

        // el destino del segue es un NavigationController
        UINavigationController *navigation = [segue destinationViewController];
        // el navigationController contiene nuestro viewController llamado DetallePublicacionTableViewController y accedemos a el de la siguiente forma
        DetallePublicacionTableViewController *dptvc = [navigation.viewControllers objectAtIndex:0];
        
        // obtenemos la publicación del arreglo con las publicaciones
        dptvc.publicacion = [publicaciones objectAtIndex:index.row];
    }
}



















@end
