//
//  MovieViewModal.h
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieViewModal : NSObject

typedef void (^Callback)(NSString *);
- (void)fetchMovieListWithCompletionBlock:(Callback)completionHandler;
- (NSArray *)fetchMoviesFromLocalStore;
@property(nonatomic,strong)Callback movieViewModalBlock;
@end
