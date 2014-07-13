//
//  Thesaurus.h
//  memo_ry
//
//  Created by 石郷 祐介 on 2014/01/02.
//  Copyright (c) 2014年 Yusk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Thesaurus : NSObject

- (id)initWithDBName:(NSString *)dbName;		// データベース名を指定して初期化する
- (void)dispose;								// 終了処理

- (NSArray *)synonymsOfWord:(NSString *)word;	// 指定した単語の類語を返す

@end
