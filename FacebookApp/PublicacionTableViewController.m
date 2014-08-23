//
//  PublicacionTableViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 23/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "PublicacionTableViewController.h"

// un macro es una buena práctica para crear constantes, aunque oficialmente no son las constantes en Objective-C
// un macro puede contener cualquier cosa, una función, un objeto, cualquier valor
#define CARACTERES 140

@interface PublicacionTableViewController ()

@end

@implementation PublicacionTableViewController

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
    
    // Creamos un gesture, un componente 100% de interacción
    // Cuando se crea un tap hay que agregarlo siempre a la vista y expecificar la acción (método)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cerrarTeclado)];
    [self.view addGestureRecognizer:tap];
    
    self.caracteres.text = [NSString stringWithFormat:@"%d", CARACTERES];
    
    // El componente txtEstado delega de la clase PublicacionTableViewController, por lo cual puede usar comportamientos, métodos y propiedades que disponga esta clase
    self.txtEstado.delegate = self;
}

#pragma mark - TextFieldDelegate

- (void)cerrarTeclado {
    [self.txtEstado resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int count = CARACTERES - [text length];
    if (count > 0) {
        self.caracteres.textColor = [[UIColor alloc] initWithRed:69.0/255 green:97.0/255 blue:157.0/255 alpha:1];
        self.caracteres.text = [NSString stringWithFormat:@"%d", count];
    }
    else {
        self.caracteres.textColor = [UIColor redColor];
        self.caracteres.text = @"0";
    }
    
    if ([text length] > CARACTERES)
        return NO;
    else
        return YES;
}

#pragma mark - IBAction

- (IBAction)publicar:(id)sender {
    // UserDefault, podemos instaciar de esta forma o con alloc, init (forma tradicional) y funcionará igual
    // UserDefault nos permite gaurdar configuraciones, datos sensibles de la aplicación, estados, etc. Tiene un limite, para eso está la opción de CoreData (almacenar cantidades de datos más grandes)
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *obj = @{
                          @"autor": @"Jesús Ruiz",
                          @"mensaje": self.txtEstado.text
                         };
    
    // Aquí empieza la actualización de las publicaciones existentes con la nueva publicación que estamos agregando
    NSMutableArray *publicaciones = [[NSMutableArray alloc] init];
    [publicaciones addObject:obj];
    [publicaciones addObjectsFromArray:[ud objectForKey:@"publicaciones"]];
    [ud setObject:publicaciones forKey:@"publicaciones"];
    
    // El método synchronize no es necesario, pero forza al SO para que guarde en ese momento
    // Sino se usa, el sistema operativo verá cuando guardar tu información, quizás ya que acabe un proceso o tarea
    [ud synchronize];
    
    self.txtEstado.text = @"";
    self.caracteres.text = [NSString stringWithFormat:@"%d", CARACTERES];
    self.caracteres.textColor = [[UIColor alloc] initWithRed:69.0/255 green:97.0/255 blue:157.0/255 alpha:1];
    [self.txtEstado resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else if (section == 1)
        return 2;
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
