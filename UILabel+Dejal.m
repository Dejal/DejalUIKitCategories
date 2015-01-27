//
//  UILabel+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2008-11-15.
//  Copyright (c) 2008-2015 Dejal Systems, LLC. All rights reserved.
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

#import "UILabel+Dejal.h"
#import "UIColor+Dejal.h"


@implementation UILabel (Dejal)

/**
 Returns an autoreleased label with the specified text and default formatting, sized to fit the text.
 
 @author DJS 2008-11.
*/

+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font;
{
    return [self dejal_labelWithText:text font:font width:0.0 height:0.0];
}

/**
 Returns an autoreleased label with the specified text and default formatting.  Pass zero for width to use the width of the text (i.e. sized to fit), or another width.  Pass zero for the height to use the height of the text, or another height (e.g. to match baselines with other text).
 
 @author DJS 2008-11.
*/

+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height;
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    
    if (width <= 5.0)
        width = ceil(size.width);
    
    if (height <= 5.0)
        height = ceil(size.height);
    
    CGRect frame = CGRectMake(0.0, 0.0, width, height);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    label.font = font;
    
    return label;
}

/**
 Returns an autoreleased label with the specified text and attributes, sized vertically to fit.  The text is centered by default.  Pass zero for width to default to 320.0, or another width.  Pass NSLineBreakModeWordWrap to use multi-line text, or another line break mode as desired.
 
 @author DJS 2009-11.
 @version DJS 2011-12: changed to ensure a minimum of one line, and split the method into two parts.
 @version DJS 2012-01: changed to call the following method instead of the previous one.
*/

+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
{
    CGSize size = CGSizeMake(width, 1000.0);
    BOOL isEmpty = !text;
    
    if (isEmpty)
        text = @"\n";
    
    size = [self dejal_sizeForText:text font:font lineBreakMode:lineBreakMode frameSize:size];
    
    if (isEmpty)
        text = nil;
    
    return [self dejal_labelWithText:text font:font width:width height:size.height lineBreakMode:lineBreakMode];
}

/**
 Returns an autoreleased label with the specified text and attributes.  The text is centered by default.  Pass zero for width to default to 320.0, or another width.  Pass NSLineBreakModeWordWrap to use multi-line text, or another line break mode as desired.
 
 @author DJS 2009-11.
 @version DJS 2011-12: changed to ensure a minimum of one line, and split the method into two parts.
*/

+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height lineBreakMode:(NSLineBreakMode)lineBreakMode;
{
    if (width <= 5.0)
        width = 320.0;
    
    if (height <= 5.0)
        height = 20.0;
    
    CGRect frame = CGRectMake(0.0, 0.0, width, height);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    label.text = text;
    label.font = font;
    label.lineBreakMode = lineBreakMode;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

/**
 Returns an autoreleased label with the specified text and formatted for use to the left of a text field or table row.
 
 @author DJS 2008-11.
*/

+ (UILabel *)dejal_labelForPrompt:(NSString *)text withWidth:(CGFloat)width;
{
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UILabel *label = [self dejal_labelWithText:text font:font width:width height:0.0];
    
    label.textColor = [UIColor dejal_promptTextColor];
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

/**
 Returns an autoreleased label optimized for table cells, with the specified font, no frame, and a white opaque background.
 
 @author DJS 2008-11.
*/

+ (UILabel *)dejal_labelForTableCellWithFont:(UIFont *)font textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor;
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.font = font;
    label.textColor = textColor;
    label.highlightedTextColor = highlightedTextColor;
    label.backgroundColor = [UIColor whiteColor];
    
    return label;
}

/**
 Returns an autoreleased label formatted for use in an add table cell.
 
 @author DJS 2008-11.
 @version DJS 2009-02: changed to use -labelForTableCellWithFont:.
*/

+ (UILabel *)dejal_labelForTableAddRow;
{
    return [self dejal_labelForTableCellWithFont:[UIFont boldSystemFontOfSize:16] textColor:[UIColor darkGrayColor] highlightedTextColor:[UIColor lightGrayColor]];
}

/**
 Returns an autoreleased label formatted for use as the primary value of a table cell.
 
 @author DJS 2008-11.
 @version DJS 2009-02: changed to use -labelForTableCellWithFont:.
*/

+ (UILabel *)dejal_labelForTablePrimaryText;
{
    return [self dejal_labelForTableCellWithFont:[UIFont boldSystemFontOfSize:18] textColor:[UIColor blackColor] highlightedTextColor:[UIColor whiteColor]];
}

/**
 Returns an autoreleased label formatted for use as a secondary value of a table cell.
 
 @author DJS 2009-02.
*/

+ (UILabel *)dejal_labelForTableSecondaryText;
{
    return [self dejal_labelForTableCellWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor] highlightedTextColor:[UIColor lightGrayColor]];
}

/**
 Adjusts the receiver when it is highlighted or dehighlighted, so it is opaque with a white background and normal text color when not highlighted (for optimal drawing in tables), and clear background and highlighted text color when highlighted.
 
 @author DJS 2009-02.
*/

- (void)dejal_adjustForHighlight:(BOOL)highlighted;
{
    NSLog(@"adjustForHighlight: I don't think this is needed anymore; set textColor and highlightedTextColor instead");         // log
    
    return;
    
    
    UIColor *backgroundColor = highlighted ? [UIColor clearColor] : [UIColor whiteColor];
    
    self.backgroundColor = backgroundColor;
    self.highlighted = highlighted;
    
    [self setNeedsDisplay];
}

/**
 Returns the size of the text within the frame size.
 
 @param text The text for the label.
 @param font The font to use for the text.
 @param lineBreakMode The line break mode.
 @param frameSize The size of the frame that contains the receiver.
 @returns The size that the text takes up.
 
 @author DJS 2014-01.
 */

+ (CGSize)dejal_sizeForText:(NSString *)text font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode frameSize:(CGSize)frameSize;
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = lineBreakMode;
    
    CGSize textSize = [text boundingRectWithSize:frameSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraph} context:nil].size;
    
    return textSize;
}

/**
 Returns the size of the attributed text within the frame size.
 
 @param text The attributed text for the label.
 @param frameSize The size of the frame that contains the receiver.
 @returns The size that the text takes up.
 
 @author DJS 2014-11.
 */

+ (CGSize)dejal_sizeForAttributedText:(NSAttributedString *)text frameSize:(CGSize)frameSize;
{
    CGSize textSize = [text boundingRectWithSize:frameSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return textSize;
}

/**
 Returns the size of the text within the frame size.
 
 @param frameSize The size of the frame that contains the receiver.
 @returns The size that the text takes up.
 
 @author DJS 2014-01.
 */

- (CGSize)dejal_sizeForTextWithinFrameSize:(CGSize)frameSize;
{
    return [[self class] dejal_sizeForText:self.text font:self.font lineBreakMode:self.lineBreakMode frameSize:frameSize];
}

/**
 Returns the size of the attributed text within the frame size.
 
 @param frameSize The size of the frame that contains the receiver.
 @returns The size that the text takes up.
 
 @author DJS 2014-11.
 */

- (CGSize)dejal_sizeForAttributedTextWithinFrameSize:(CGSize)frameSize;
{
    return [[self class] dejal_sizeForAttributedText:self.attributedText frameSize:frameSize];
}

@end

