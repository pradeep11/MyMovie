//
//  MovieDetail+CoreDataProperties.h
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//
//

#import "MovieDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MovieDetail (CoreDataProperties)

+ (NSFetchRequest<MovieDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *releaseYear;
@property (nullable, nonatomic, copy) NSString *rating;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSObject *genre;

@end

NS_ASSUME_NONNULL_END
