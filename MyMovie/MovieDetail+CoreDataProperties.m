//
//  MovieDetail+CoreDataProperties.m
//  MyMovie
//
//  Copyright © 2018 Test. All rights reserved.
//
//

#import "MovieDetail+CoreDataProperties.h"

@implementation MovieDetail (CoreDataProperties)

+ (NSFetchRequest<MovieDetail *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MovieDetail"];
}

@dynamic title;
@dynamic releaseYear;
@dynamic rating;
@dynamic imageUrl;
@dynamic genre;

@end
