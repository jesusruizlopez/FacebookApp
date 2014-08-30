//
//  AmigosViewController.m
//  FacebookApp
//
//  Created by Jesús Ruiz on 30/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import "AmigosViewController.h"
#import "AmigoCell.h"

@interface AmigosViewController ()

@end

@implementation AmigosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.items = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 15; i++) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:@"off" forKey:@"check"];
        [item setValue:@"Jesús Ruiz" forKey:@"name"];
        [self.items addObject:item];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Sources

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AmigoCell *amigo = [collectionView dequeueReusableCellWithReuseIdentifier:@"amigoCell" forIndexPath:indexPath];
    
    NSMutableDictionary *obj = [self.items objectAtIndex:indexPath.row];
    
    amigo.name.text = [obj objectForKey:@"name"];
    amigo.check.image = ([[obj objectForKey:@"check"] isEqualToString:@"off"]) ? [UIImage imageNamed:@"checkoff.png"] : [UIImage imageNamed:@"checkon.png"];
    return amigo;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableDictionary *amigo = [self.items objectAtIndex:indexPath.row];
    
    if ([[amigo objectForKey:@"check"] isEqualToString:@"off"]) {
        [amigo setValue:@"on" forKey:@"check"];
    }
    else {
        [amigo setValue:@"off" forKey:@"check"];
    }
    
    [collectionView reloadData];
}

@end
