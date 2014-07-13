//
//  AppController.m
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/06.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import "AppController.h"

#import "NSArray+Custom.h"

#import "Thesaurus.h"
#import "Mecab.h"

@interface AppController ()
- (void)countUp:(id)sender;								// カウントアップ
- (void)convertText:(NSString *)targetText;				// 文章を変換する
@end

@implementation AppController
{
	NSTimer *_timer;
	NSInteger _timerCountSec;
}

/*-----------------------------------------------------------------------------------------------------------------
 * 初期化する
 -----------------------------------------------------------------------------------------------------------------*/
- (void)setup
{
	srand((unsigned)time(NULL));
	
	self.mecab = [[Mecab alloc] init];
	self.thesaurus = [[Thesaurus alloc] initWithDBName:@"wnjpn"];
	
	// エディタ設定
	self.textView.font = [NSFont fontWithName:@"HiraMinProN-W3" size:32];
	self.textView.delegate = self;
	[self.textView setRichText:NO];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
											  target:self
											selector:@selector(countUp:)
											userInfo:nil
											 repeats:YES];
}

/*-----------------------------------------------------------------------------------------------------------------
 * 終了処理
 -----------------------------------------------------------------------------------------------------------------*/
- (void)dispose
{
	[self.mecab dispose];
	[self.thesaurus dispose];
}

/*-----------------------------------------------------------------------------------------------------------------
 * 文章を変換する
 -----------------------------------------------------------------------------------------------------------------*/
- (void)convertText:(NSString *)targetText
{
	NSArray *parsedData = [self.mecab parse:targetText];

	for (Word *word in [parsedData randam])
	{
		if (word.surface.length <= 1)
		{
			continue;
		}
		
		NSString *partType = word.features[0];
		NSString *partDetailedType = word.features[1];

		if (([partType compare:@"名詞"] == NSOrderedSame) && ([partDetailedType compare:@"一般"] == NSOrderedSame))
		{
			NSArray *synonyms = [self.thesaurus synonymsOfWord:word.surface];

			if (synonyms.count > 0)
			{
				NSString *replaceWord = synonyms[rand() % synonyms.count];
				NSRange range = [targetText rangeOfString:word.surface];
				[self.textView.textStorage replaceCharactersInRange:range withString:replaceWord];
				
				NSRange replaceRange = [targetText rangeOfString:replaceWord
														 options:NSLiteralSearch
														   range:NSMakeRange(range.location, targetText.length - range.location)];
				[self.textView setTextColor:[NSColor redColor] range:replaceRange];
				
				NSLog(@"%@ -> %@", word.surface, replaceWord);
				
				break;
			}
		}
	}
}

/*-----------------------------------------------------------------------------------------------------------------
 * カウントアップ
 -----------------------------------------------------------------------------------------------------------------*/
- (void)countUp:(id)sender
{
	_timerCountSec++;
	
	if (_timerCountSec >= CONVERT_TEXT_INTERVAL_SEC)
	{
		[self convertText:self.textView.attributedString.string];
		_timerCountSec = 0;
	}

	//NSLog(@"%ld", _timerCountSec);
}

#pragma mark -
#pragma mark NSTextView Delegate

- (void)textDidChange:(NSNotification *)notification
{
	_timerCountSec = 0;
}


@end
