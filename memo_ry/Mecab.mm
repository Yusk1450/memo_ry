//
//  Mecab.m
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/03.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import "Mecab.h"

#import <iostream>
#import <vector>
#import <string>
#import <mecab.h>


std::vector<std::string> spliteLines(std::string &str)
{
	std::vector<std::string> v;
	
	std::string::size_type idx = 0;
	while (idx < (int)str.length() && idx != std::string::npos)
	{
		std::string::size_type oldIdx = idx;
		idx = str.find("\n", idx);
		if (idx != std::string::npos)
		{
			std::string line = str.substr(oldIdx, idx-oldIdx);
			v.push_back(line);
			idx++;
		}
	}
	
	return v;
}

@implementation Word
@end

@implementation Mecab
{
	MeCab::Tagger *_tagger;
}

/*-----------------------------------------------------------------------------------------------------------------
 * 初期化する
 -----------------------------------------------------------------------------------------------------------------*/
- (id)init
{
	self = [super init];
	
	if (self)
	{
		_tagger = MeCab::createTagger("");
	}
	
	return self;
}

/*-----------------------------------------------------------------------------------------------------------------
 * パースする
 -----------------------------------------------------------------------------------------------------------------*/
- (NSArray *)parse:(NSString *)text
{
	if (text.length <= 0)
	{
		return nil;
	}
	
	NSMutableArray *words = [[NSMutableArray alloc] init];
	
	const char *res = _tagger->parse(text.UTF8String);

	std::string resStr(res);
	std::vector<std::string> resLines = spliteLines(resStr);				// パース結果を1行ずつ配列に入れる
	resLines.erase(resLines.end()-1);										// 末尾「EOF」を削除する
	
	std::vector<std::string>::iterator its = resLines.begin();
	while (its != resLines.end())
	{
		std::string::size_type idx = (*its).find("\t");
		if (idx != std::string::npos)
		{
			Word *word = [[Word alloc] init];
			
			std::string surface = (*its).substr(0, idx);						// 単語
			std::string feature = (*its).substr(idx+1, (*its).length());		// 単語属性
			
			word.surface = [[NSString alloc] initWithUTF8String:surface.c_str()];
			word.features = [[[NSString alloc] initWithUTF8String:feature.c_str()] componentsSeparatedByString:@","];
			[words addObject:word];
		}
		its++;
	}
	
	return words;
}

/*-----------------------------------------------------------------------------------------------------------------
 * 終了処理
 -----------------------------------------------------------------------------------------------------------------*/
- (void)dispose
{
	delete _tagger;
	_tagger = NULL;
}

@end
