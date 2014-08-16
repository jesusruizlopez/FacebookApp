//
//  DetallePublicacionTableViewController.h
//  FacebookApp
//
//  Created by Jesús Ruiz on 16/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetallePublicacionTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableDictionary *publicacion;

// weak se usa cuando usamos IBOutlet
// nuestra variable no será dueña de la referencia a diferencia de strong
// cuando la vista desaparezca automaticamente las referencias weak, desapareceran = nil
@property (weak, nonatomic) IBOutlet UILabel *lblAutor;
@property (weak, nonatomic) IBOutlet UITextView *textMensaje;

// regresa una acción a la vista
// recibe el elemento que lo acciona
- (IBAction)cerrar:(UIBarButtonItem *)sender;

@end
