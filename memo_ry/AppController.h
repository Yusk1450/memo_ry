//
//  AppController.h
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/06.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Thesaurus;
@class Mecab;

#define CONVERT_TEXT_INTERVAL_SEC 5

@interface AppController : NSObject <NSTextViewDelegate>

@property (nonatomic, assign) IBOutlet NSTextView *textView;
@property (nonatomic, strong) Thesaurus *thesaurus;
@property (nonatomic, strong) Mecab *mecab;

- (void)setup;													// 初期化
- (void)dispose;												// 終了処理

@end
