//
//  AppDelegate.m
//  TestBed
//
//  Created by Me on 2016-10-16.
//  Copyright © 2016 ACME. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <NSWindowDelegate, NSTextViewDelegate>

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property (weak) IBOutlet NSButton *leftButton;
@property (weak) IBOutlet NSButton *leftCheckbox;

@property (weak) IBOutlet NSButton *rightButton;
@property (weak) IBOutlet NSButton *rightCheckbox;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSAssert(self.textView.delegate == self, @"expected us to be textview delegate");
    NSAssert(self.window.delegate == self, @"expected us to be window delegate");
    
    self.textView.font = [NSFont fontWithName:@"Menlo" size:13];
    // if you *start* with the mutableString-appendString dance in `-logMessage:` it won't pick up the specified font ... but it will after this
    [self.textView replaceCharactersInRange:NSMakeRange(0, 0)
                                 withString:[self startMessage]];
    
    self.leftButton.title = @"Do Stuff!";
    self.leftCheckbox.title = @"Use Whatever";
    self.rightButton.title = @"Do Other Stuff.";
    self.rightCheckbox.title = @"I have no function";
}

- (IBAction)leftButtonClicked:(id)sender {
    [self logMessage:@"Left Button Clicked."];
}

- (IBAction)rightButtonClicked:(id)sender {
    [self logMessage:@"Right Button Clicked."];
}

- (IBAction)leftCheckboxClicked:(id)sender {
    [self logMessage:@"Left Checkbox Clicked."];
}

- (IBAction)rightCheckboxClicked:(id)sender {
    [self logMessage:@"Right Checkbox Clicked."];
}

- (NSString *) startMessage
{
    return [NSString stringWithFormat:@"TestBed started ... %@\n\n", [NSDate date]];
}

- (void) logMessage:(NSString *)msg
{
    NSAssert([NSThread currentThread].isMainThread, @"UI changes should only happen on main thread");
    
    if (![msg hasSuffix:@"\n"]) {
        msg = [msg stringByAppendingString:@"\n"];
    }
    
    NSString *timestamp = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    msg = [NSString stringWithFormat:@"%@ - %@", timestamp, msg];
    
    [self.textView.textStorage.mutableString appendString:msg];
    [self.textView scrollToEndOfDocument:nil];
    
}

@end
