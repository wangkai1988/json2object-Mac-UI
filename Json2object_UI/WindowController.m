//
//  WindowController.m
//  Json2object_UI
//
//  Created by WenJie on 16/8/31.
//  Copyright © 2016年 fosung. All rights reserved.
//

#import "WindowController.h"

@interface WindowController ()<NSWindowDelegate>


@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
}

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:self];
}


@end
