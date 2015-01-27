//
//  UITextField+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2013-03-28.
//  Copyright (c) 2013-2015 Dejal Systems, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  Credit: portions based on Useful Utilities by Jonathan Hays (JH) <https://github.com/cheesemaker/toolbox>
//

#import "UITextField+Dejal.h"


@implementation UITextField (Dejal)

/**
 Adds gesture recognizers to the receiver's superview to handle moving the selection via left or right swipes; one finger to move by letter, two fingers to move by word.  Note that the receiver must be added to a superview before invoking this.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_setupSelectionGestures;
{
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dejal_moveLeftByLetter)];
	recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.superview addGestureRecognizer:recognizer];
    
	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dejal_moveRightByLetter)];
	recognizer.direction = UISwipeGestureRecognizerDirectionRight;
	[self.superview addGestureRecognizer:recognizer];
    
	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dejal_moveLeftByWord)];
	recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	recognizer.numberOfTouchesRequired = 2;
	[self.superview addGestureRecognizer:recognizer];
    
	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dejal_moveRightByWord)];
	recognizer.direction = UISwipeGestureRecognizerDirectionRight;
	recognizer.numberOfTouchesRequired = 2;
	[self.superview addGestureRecognizer:recognizer];
}

/**
 Gesture handler to move the current selection right by one letter.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_moveLeftByLetter;
{
	NSRange selection = self.dejal_selectedRange;
	NSUInteger end = selection.location + selection.length;
    
	if (!selection.length && end > 0)
    {
		end--;
        selection.location = end;
    }
    
    selection.length = 0;
    self.dejal_selectedRange = selection;
}

/**
 Gesture handler to move the current selection right by one letter.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_moveRightByLetter;
{
	NSRange selection = self.dejal_selectedRange;
	NSUInteger end = selection.location + selection.length;
    
	if (!selection.length && end < self.text.length)
		end++;
    
    selection.location = end;
    selection.length = 0;
    self.dejal_selectedRange = selection;
}

/**
 Gesture handler to move the current selection left by one word.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_moveLeftByWord;
{
	NSRange selection = self.dejal_selectedRange;
	NSUInteger end = selection.location + selection.length;
	
	if (selection.length)
	{
		selection.length = 0;
		self.dejal_selectedRange = selection;
		return;
	}
    
    NSArray *words = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSScanner *scanner = [NSScanner scannerWithString:self.text];
	NSUInteger begin = 0;
    
	[scanner setScanLocation:0];
    
	for (NSString *word in words)
	{
		if ([scanner scanUpToString:word intoString:nil])
		{
			NSUInteger scanLocation = [scanner scanLocation];
            
			if (scanLocation < end)
				begin = scanLocation;
		}
	}
    
	selection.location = begin;
	selection.length = 0;
	self.dejal_selectedRange = selection;
}

/**
 Gesture handler to move the current selection right by one word.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_moveRightByWord;
{
	NSRange selection = self.dejal_selectedRange;
	NSUInteger end = selection.location + selection.length;
	
	if (selection.length)
	{
        selection.location = end;
		selection.length = 0;
		self.dejal_selectedRange = selection;
		return;
	}
    
    NSArray *words = [self.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSScanner *scanner = [NSScanner scannerWithString:self.text];
	NSUInteger location = self.text.length;
    
	[scanner setScanLocation:0];
    
	for (NSString *word in words)
	{
		if ([scanner scanUpToString:word intoString:nil])
		{
			NSUInteger scanLocation = [scanner scanLocation];
            
			if (scanLocation > end)
			{
				location = scanLocation;
				break;
			}
		}
	}
    
	selection.location = location;
	selection.length = 0;
	self.dejal_selectedRange = selection;
}

/**
 Returns the current selection range of the receiver.
 
 @author DJS 2013-03, based on code by JH.
*/

- (NSRange)dejal_selectedRange;
{
    UITextRange *selectedRange = self.selectedTextRange;
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start];
    NSInteger length = [self offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    
    return NSMakeRange(location, length);
}

/**
 Sets the selection range of the receiver.
 
 @author DJS 2013-03, based on code by JH.
*/

- (void)dejal_setSelectedRange:(NSRange)range;
{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:start toPosition:end];
    
    [self setSelectedTextRange:selectionRange];
}

@end

