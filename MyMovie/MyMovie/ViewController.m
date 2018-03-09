//
//  ViewController.m
//  MyMovie
//
//  .
//  Copyright © 2018 Test. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MovieDetail+CoreDataClass.h"
#import "CollectionViewCell.h"
#import "MovieViewModal.h"
#import "MovieModal.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieDetailViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrMovieList;
    MovieViewModal *movieViewModalObj;
    NSArray *arrFilter;
    BOOL isFilter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Movies List";
    movieViewModalObj = [MovieViewModal new];
    arrFilter = [[NSArray alloc]initWithObjects:@"None",@"Action",@"Drama",@"Sci-Fi",@"Thriller",@"Adventure",@"History",@"Fantasy",@"Animation",@"Comedy",@"Family",@"Horror",@"Crime", nil];
    
    [self.tableViewFilter registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self loadMovieDataFromServer];
}

- (void)loadMovieDataFromServer
{
    [movieViewModalObj fetchMovieListWithCompletionBlock:^(NSString *result) {
        NSLog(@"reslts %@",result);
        arrMovieList = [movieViewModalObj fetchMoviesFromLocalStore];
        [_collectionViewMovieList reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrMovieList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    if (indexPath.row == arrMovieList.count - 7 && !isFilter) {
        [self loadMovieDataFromServer];
    }
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    MovieModal *movieModal = arrMovieList[indexPath.row];
    [cell.imageViewMovie sd_setImageWithURL:[NSURL URLWithString:movieModal.imageUrl]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.lblMovieName.text = movieModal.title;
    cell.lblRating.text = movieModal.rating;
    cell.lblReleaseYear.text = movieModal.releaseYear;
    NSString *strGenre = [movieModal.genre componentsJoinedByString:@", "];
    cell.lblGenre.text = strGenre;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailViewController *movieDetailViewControllerObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailViewControllerID"];
    movieDetailViewControllerObj.movieModalObj = arrMovieList[indexPath.row];
    [self.navigationController pushViewController:movieDetailViewControllerObj animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrFilter count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:    (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"     forIndexPath:indexPath];
    cell.textLabel.text = [arrFilter objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableViewFilter setHidden:TRUE];
    if (indexPath.row == 0) {
        isFilter = NO;
        arrMovieList = [movieViewModalObj fetchMoviesFromLocalStore];
        [_collectionViewMovieList reloadData];
        return;
    }
    NSString *strGenre = arrFilter[indexPath.row];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.genre CONTAINS %@",strGenre];
    arrMovieList = [arrMovieList filteredArrayUsingPredicate:predicate];
    
    [_collectionViewMovieList reloadData];
}

- (IBAction)filterClicked:(id)sender {
    isFilter = YES;
    [self.tableViewFilter setHidden:FALSE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
