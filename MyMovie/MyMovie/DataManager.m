//
//  DataManager.m
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "MovieDetail+CoreDataClass.h"
#import "MovieModal.h"



@implementation DataManager

- (void)fetchMovieDetailsFromUrl:(NSString *)webUrl completionBlock:(NetworkCompletionBlock)completionBlock
{
    _networkBlock = completionBlock;
    if (!manager) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    [manager.operationQueue cancelAllOperations];
    [manager GET:webUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             NSArray *arrMovieList = [self parseReceivedMovieInformation:responseObject];
             [self saveLocallyReceivedMovieInformation:arrMovieList];
             _networkBlock(@"Success");
    
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             _networkBlock(@"Error");
         }];
}

- (NSMutableArray *)parseReceivedMovieInformation:(NSArray *)movieList
{
    NSMutableArray *parseMovieList = [NSMutableArray new];
    for (NSDictionary *dictMovieDetails in movieList)
    {
        
        MovieModal *movieModalObj = [MovieModal new];
        movieModalObj.title =  dictMovieDetails[@"title"];
        movieModalObj.releaseYear =  [dictMovieDetails[@"releaseYear"] stringValue];
        NSString *strRating = [NSString stringWithFormat:@"%.1f",[dictMovieDetails[@"rating"]floatValue]];
        movieModalObj.rating =   strRating;
        movieModalObj.imageUrl =  dictMovieDetails[@"image"];
        movieModalObj.genre =  dictMovieDetails[@"genre"];
        
        [parseMovieList addObject:movieModalObj];
    }
    return parseMovieList;
}
- (void)saveLocallyReceivedMovieInformation:(NSArray *)movieList
{
    AppDelegate *appDelegateObj = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegateObj.persistentContainer.viewContext;
    for (MovieModal *movieModalObj  in movieList)
    {
        MovieDetail *movieInfo = [NSEntityDescription insertNewObjectForEntityForName:@"MovieDetail" inManagedObjectContext:context];
        [movieInfo setValue:movieModalObj.title forKey:@"title"];
        [movieInfo setValue:movieModalObj.releaseYear  forKey:@"releaseYear"];
        [movieInfo setValue:movieModalObj.rating forKey:@"rating"];
        [movieInfo setValue:movieModalObj.imageUrl forKey:@"imageUrl"];
        [movieInfo setValue: movieModalObj.genre forKey:@"genre"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
    }
}

@end
