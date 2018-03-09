//
//  CollectionViewCell.h
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMovie;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieName;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseYear;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblGenre;

@end
