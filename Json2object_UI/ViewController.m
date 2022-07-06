//
//  ViewController.m
//  Json2object_UI
//
//  Created by WenJie on 16/8/30.
//  Copyright © 2016年 fosung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSMenuDelegate>
@property (weak) IBOutlet NSTextField *jsonFilePathTextField;
@property (weak) IBOutlet NSTextField *baseClassNameTextField;
@property (weak) IBOutlet NSPopUpButton *popUpButton;

@end

@implementation ViewController

NSString * const ThirdPartyLibraryTitle = @"ThirdPartyLibraryTitle";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * title = [[NSUserDefaults standardUserDefaults] objectForKey:ThirdPartyLibraryTitle];
    if (title != nil) {
        [self.popUpButton selectItemWithTitle:title];
    }
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)selectFileButtonAction:(NSButton *)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
    if ([panel runModal] == NSModalResponseOK) {
        NSString *path = [panel.URLs.firstObject path];
        self.jsonFilePathTextField.stringValue = path;
    }
}
- (IBAction)generateFileButtonAction:(NSButton *)sender {
    
    if ([[self.jsonFilePathTextField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        
        NSAlert * alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"关闭"];
        [alert setMessageText:@"信息不全"];
        [alert setInformativeText:@"请输入JSON文件路径"];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];
        return;
    }
    
    if ([[self.baseClassNameTextField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        
        NSAlert * alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"关闭"];
        [alert setMessageText:@"信息不全"];
        [alert setInformativeText:@"请输入Object基类名称"];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];
        return;
    }
    
//    NSString *json2objectPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"json2object_old.py"];//旧代码
    
    
    NSString * selectedTitle = self.popUpButton.titleOfSelectedItem;
    [[NSUserDefaults standardUserDefaults] setObject:selectedTitle forKey:ThirdPartyLibraryTitle];
    
    NSString * pythonFileName;
    if ([selectedTitle isEqualToString:@"MJExtension"]) {
        pythonFileName = @"JSON2MJExtensionObject.py";
    }else if([selectedTitle isEqualToString:@"JSONModel"]){
        pythonFileName = @"JSON2JSONModelObject.py";
    }else{
        pythonFileName = @"JSON2YYModelObject.py";
    }
    NSString *json2objectPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pythonFileName];
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/bin/python3"];//旧代码
//    [task setLaunchPath:@"/Applications/Xcode.app/Contents/Developer/Library/Frameworks/Python3.framework/Versions/3.8/Resources/Python.app/Contents/MacOS/Python"];
    
    NSArray *arguments;
    arguments = @[json2objectPath,self.jsonFilePathTextField.stringValue,self.baseClassNameTextField.stringValue];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    [file closeFile];
    
    NSString *string = [[NSString alloc] initWithData: data
                                             encoding: NSUTF8StringEncoding];
//    NSLog(@"output : %@",string);
    
    if (!string || [string isEqualToString:@""]) {
        NSString * dir = [self.jsonFilePathTextField.stringValue stringByDeletingLastPathComponent];
        [[NSWorkspace sharedWorkspace] selectFile:nil inFileViewerRootedAtPath:dir];
    }else{
        NSAlert * alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"关闭"];
        [alert setMessageText:@"执行失败"];
        [alert setInformativeText:string];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert runModal];
    }

}

@end
