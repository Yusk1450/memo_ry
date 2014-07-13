//
//  NSArray+Custom.m
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/03/12.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import "NSArray+Custom.h"

@implementation NSArray (Custom)

- (NSArray *)randam
{
	NSMutableArray *shuffledArray = [self mutableCopy];
	
	for (uint i = 0; i < shuffledArray.count; i++)
	{
		uint m = (uint)shuffledArray.count - i;
		uint n = arc4random_uniform(m) + i;
		[shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
	return shuffledArray;
}

@end
