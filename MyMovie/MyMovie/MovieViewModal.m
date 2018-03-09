//
//  MovieViewModal.m
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import "MovieViewModal.h"
#import "DataManager.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "MovieDetail+CoreDataClass.h"
#import "MovieModal.h"
@implementation MovieViewModal

- (void)fetchMovieListWithCompletionBlock:(Callback)completionHandler
{
    _movieViewModalBlock = completionHandler;
    DataManager *dataManagerObj = [DataManager new];
    [dataManagerObj fetchMovieDetailsFromUrl:@"http://api.androidhive.info/json/movies.json" completionBlock:^(NSString *result) {
        NSLog(@"results %@",result);
        _movieViewModalBlock(result);
    }];
}

- (NSArray *)fetchMoviesFromLocalStore{
    
    AppDelegate *appDelegateObj = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegateObj.persistentContainer.viewContext;
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]initWithEntityName:@"MovieDetail"];
    NSError *error = nil;
    NSArray *result = ((NSAsynchronousFetchResult *)[context executeRequest:fetchReq error:&error]).finalResult;
    NSLog(@"result %@",result);
    
    NSMutableArray *arrMovieList = [NSMutableArray new];
    for (MovieDetail *movieDetail in result)
    {
        MovieModal *movieModal = [MovieModal new];
        movieModal.title = movieDetail.title;
        movieModal.rating = movieDetail.rating;
        movieModal.releaseYear = movieDetail.releaseYear;
        movieModal.imageUrl = movieDetail.imageUrl;
        movieModal.genre = (NSArray *)movieDetail.genre;
        [arrMovieList addObject:movieModal];
    }
    
    return arrMovieList;
}

@end
