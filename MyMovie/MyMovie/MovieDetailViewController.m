//
//  MovieDetailViewController.m
//  MyMovie
//
//  .
//  Copyright © 2018 Test. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.movieModalObj.title;
    [self.imageViewMovie sd_setImageWithURL:[NSURL URLWithString:self.movieModalObj.imageUrl]
                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.lblMovieName.text = self.movieModalObj.title;
    self.lblRating.text = self.movieModalObj.rating;
    self.lblReleaseYear.text = self.movieModalObj.releaseYear;
    NSString *strGenre = [self.movieModalObj.genre componentsJoinedByString:@", "];
    self.lblGenre.text = strGenre;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
