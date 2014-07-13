//
//  Mecab.h
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/03.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Word : NSObject
@property (nonatomic, strong) NSString *surface;	// 単語
@property (nonatomic, strong) NSArray *features;	// 品詞分類
@end


@interface Mecab : NSObject
- (NSArray *)parse:(NSString *)text;				// パースする
- (void)dispose;									// 終了処理
@end
