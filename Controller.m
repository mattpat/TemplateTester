//
//  Controller.m
//  Template Tester
//
//  Created by Matt Patenaude on 5/7/09.
//  Copyright (C) 2009 Matt Patenaude.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "Controller.h"


@implementation Controller

#pragma mark Initializers
- (id)init
{
	if (self = [super init])
	{
		imagePath = [[[NSBundle mainBundle] pathForImageResource:@"toolbar_info"] copy];
	}
	return self;
}
- (void)awakeFromNib
{
	[self updateImages];
}

#pragma mark Deallocator
- (void)dealloc
{
	[imagePath release];
	[super dealloc];
}

#pragma mark Methods
- (IBAction)chooseImage:(id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	if ([openPanel runModalForTypes:[NSArray arrayWithObjects:@"pdf", @"eps", @"tif", @"tiff", @"png", @"jpg", @"jpeg", @"gif", @"psd", nil]])
	{
		if (imagePath)
		{
			[imagePath release];
			imagePath = nil;
		}
		imagePath = [[[openPanel filenames] objectAtIndex:0] copy];
		[self updateImages];
	}
}
- (IBAction)refreshImage:(id)sender
{
	[self updateImages];
}
- (void)updateImages
{
	NSImage *theImage = [[NSImage alloc] initWithContentsOfFile:imagePath];
	[theImage setTemplate:YES];
	
	[buttonA setImage:theImage];
	[buttonB setImage:theImage];
	[buttonC setImage:theImage];
	
	[theImage release];
}

#pragma mark App delegate methods
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return YES;
}

@end
