//
//  Thesaurus.m
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/02.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import "Thesaurus.h"
#import <FMDatabase.h>


@interface Thesaurus ()
- (NSArray *)wordIDS:(NSString *)word;		// wordidを検索する
- (NSArray *)synsets:(int)wordID;			// synsetを検索する
@end

@implementation Thesaurus
{
	FMDatabase *_db;
}

/*-----------------------------------------------------------------------------------------------------------------
 * データベース名を指定して初期化する
 -----------------------------------------------------------------------------------------------------------------*/
- (id)initWithDBName:(NSString *)dbName
{
	self = [super init];
	
	if (self)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:dbName ofType:@"db"];
		_db = [FMDatabase databaseWithPath:path];
		[_db open];
	}
	
	return self;
}

/*-----------------------------------------------------------------------------------------------------------------
 * 指定した単語の類語を返す
 -----------------------------------------------------------------------------------------------------------------*/
- (NSArray *)synonymsOfWord:(NSString *)word
{
	NSMutableArray *synonyms = [[NSMutableArray alloc] init];
	
	for (NSNumber *wordID in [self wordIDS:word])
	{
		for (NSString *synset in [self synsets:[wordID intValue]])
		{
			NSMutableString *query = [[NSMutableString alloc] init];
			[query appendFormat:@"SELECT lemma FROM sense, word WHERE synset = '%@'", synset];
			[query appendString:@" AND word.lang = 'jpn' AND sense.wordid = word.wordid"];
			
			FMResultSet *rs = [_db executeQuery:query];
			while ([rs next])
			{
				[synonyms addObject:[rs stringForColumn:@"lemma"]];
			}
			[rs close];
		}
	}
	
	return synonyms;
}

/*-----------------------------------------------------------------------------------------------------------------
 * wordidを検索する
 -----------------------------------------------------------------------------------------------------------------*/
- (NSArray *)wordIDS:(NSString *)word
{
	NSString *query = [[NSString alloc] initWithFormat:@"SELECT * FROM word WHERE lemma = '%@'", word];
	FMResultSet *rs = [_db executeQuery:query];
	NSMutableArray *results = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		[results addObject:@([rs intForColumn:@"wordid"])];
	}
	[rs close];

	return results;
}

/*-----------------------------------------------------------------------------------------------------------------
 * synsetを検索する
 -----------------------------------------------------------------------------------------------------------------*/
- (NSArray *)synsets:(int)wordID
{
	NSString *query = [[NSString alloc] initWithFormat:@"SELECT * FROM sense WHERE wordid = '%d'", wordID];
	FMResultSet *rs = [_db executeQuery:query];
	NSMutableArray *results = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		[results addObject:[rs stringForColumn:@"synset"]];
	}
	[rs close];
	
	return results;
}

/*-----------------------------------------------------------------------------------------------------------------
 * 終了処理
 -----------------------------------------------------------------------------------------------------------------*/
- (void)dispose
{
	[_db close];
}

@end
