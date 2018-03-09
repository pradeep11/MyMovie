//
//  DataManager.h
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface DataManager : NSObject
{
    AFHTTPRequestOperationManager *manager;
}

typedef void (^NetworkCompletionBlock)(NSString *result);

- (void)fetchMovieDetailsFromUrl:(NSString *)webUrl completionBlock:(NetworkCompletionBlock)completionBlock;
@property(nonatomic, strong) NetworkCompletionBlock networkBlock;
@end
