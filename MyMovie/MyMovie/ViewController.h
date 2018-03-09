//
//  ViewController.h
//  MyMovie
//
//  .
//  Copyright © 2018 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMovieList;
@property (weak, nonatomic) IBOutlet UITableView *tableViewFilter;


- (IBAction)btnClicked:(id)sender;
@end

