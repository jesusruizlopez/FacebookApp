//
//  PublicacionTableViewController.h
//  FacebookApp
//
//  Created by Jesús Ruiz on 23/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicacionTableViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEstado;
@property (weak, nonatomic) IBOutlet UILabel *caracteres;

- (IBAction)publicar:(id)sender;

@end
