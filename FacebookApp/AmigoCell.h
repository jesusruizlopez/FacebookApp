//
//  AmigoCell.h
//  FacebookApp
//
//  Created by Jesús Ruiz on 30/08/14.
//  Copyright (c) 2014 Jesus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmigoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *check;

@end
