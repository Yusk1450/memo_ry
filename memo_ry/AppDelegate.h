//
//  AppDelegate.h
//  memo_ry
//
//  Created by 石郷 祐介 on 2013/12/21.
//  Copyright (c) 2013年 Yusk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, weak) IBOutlet AppController *controller;

@end
