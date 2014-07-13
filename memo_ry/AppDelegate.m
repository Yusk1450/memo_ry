//
//  AppDelegate.m
//  memo_ry
//
//  Created by 石郷 祐介 on 2013/12/21.
//  Copyright (c) 2013年 Yusk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self.controller setup];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[self.controller dispose];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
