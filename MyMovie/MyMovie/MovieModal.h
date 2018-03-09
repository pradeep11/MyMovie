//
//  MovieModal.h
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModal : NSObject
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *imageUrl;
@property (strong, nonatomic)NSString *rating;
@property (strong, nonatomic)NSString *releaseYear;
@property (strong, nonatomic)NSArray *genre;
@end
