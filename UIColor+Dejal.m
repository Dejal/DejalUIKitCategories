//
//  UIColor+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2008-12-01.
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

#import "UIColor+Dejal.h"


@implementation UIColor (Dejal)

/**
 Returns the standard light blue color used for non-editable prompts in fields and table cells.
 
 @author DJS 2009-03.
 @version DJS 2011-11: changed to tweak the shade.
*/

+ (instancetype)dejal_promptTextColor;
{
    return [self colorWithRed:0.322 green:0.400 blue:0.569 alpha:1.000];
}

/**
 Returns the standard blue color used for text on rows with a checkmark accessory.
 
 @author DJS 2012-01.
*/

+ (instancetype)dejal_checkmarkTextColor;
{
    return [UIColor colorWithRed:0.220 green:0.329 blue:0.529 alpha:1.000];
}

/**
 Returns the standard blue color used for table cell selections.
 
 @author DJS 2009-04.
*/

+ (instancetype)dejal_tableSelectionColor;
{
    return [self colorWithRed:0.0 green:0.45 blue:0.93 alpha:1.0];
}

/**
 Returns my favorite dark green color.
 
 @author DJS 2012-05.
*/

+ (instancetype)dejal_darkGreenColor;
{
    return [self colorWithRed:0.106 green:0.686 blue:0.204 alpha:1.0];
}

/**
 Returns a color using an image with the specified name, including a platform component.  For example, pass @"Foo" and "png" to use an image named "Foo-iPad.png" on an iPad, or "Foo-iPhone.png" on an iPhone or iPod touch.
 
 @author DJS 2011-11.
*/

+ (instancetype)dejal_colorWithPlatformSpecificImageNamed:(NSString *)name extension:(NSString *)extension;
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        name = [name stringByAppendingFormat:@"-iPad.%@", extension];
    else
        name = [name stringByAppendingFormat:@"-iPhone.%@", extension];
    
    return [UIColor colorWithPatternImage:[UIImage imageNamed:name]];
}

/**
 Given an integer that encapsulates a BGR-format color (as used on Windows), returns the corresponding color.
 
 @author DJS 2012-07.
*/

+ (instancetype)dejal_colorWithBGRColor:(NSInteger)bgrColor;
{
    // BGR format: 0xFFFFFF(16777215) = white, 0 = black, (255,128,0) 0xFF8000 = blue:
    CGFloat red = bgrColor & 0xFF;
    CGFloat green = (bgrColor >> 8) & 0xFF;
    CGFloat blue = (bgrColor >> 16) & 0xFF;
    
    return [self colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1.0];
}

/**
 Given an integer that encapsuates a RGB-format color (as used on the web), returns the corresponding color.
 
 @param hexColor An integer representation of a color, typically from a hex number or string.  See the following methods.
 @param alpha The alpha value to use for the color, e.g. 1.0 for opaque.
 @returns A new color instance.
 
 @author DJS 2014-02.
 */

+ (UIColor *)dejal_colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)alpha;
{
    CGFloat red = (hexColor >> 16) & 0xFF;
    CGFloat green = (hexColor >> 8) & 0xFF;
    CGFloat blue = hexColor & 0xFF;
    
    return [self colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:alpha];
}

/**
 Given a hex string representing a color, optionally with a "0x" or "#" prefix, returns the corresponding color.
 
 @param hexStr A hex string, e.g. "123ABC", "#123ABC", or "0x123ABC".
 @param alpha The alpha value to use for the color, e.g. 1.0 for opaque.
 @returns A new color instance.
 
 @author DJS 2014-02.
 */

+ (UIColor *)dejal_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
{
    return [self dejal_colorWithHex:[self dejal_hexColorWithHexString:hexStr] alpha:alpha];
}

/**
 Given a hex string representing a color, optionally with a "0x" or "#" prefix, returns the corresponding integer value.
 
 @param hexStr A hex string, e.g. "123ABC", "#123ABC", or "0x123ABC".
 @returns The corresponding integer representation.
 
 @author DJS 2014-02.
 */

+ (NSUInteger)dejal_hexColorWithHexString:(NSString *)hexStr;
{
    NSUInteger hexColor = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:(unsigned int *)&hexColor];
    
    return hexColor;
}

/**
 Returns a lighter variation of the receiver, or the same color if the hue etc couldn't be obtained.
 
 @author DJS 2014-02.
 */

- (UIColor *)dejal_lighterColor;
{
    CGFloat hue, saturation, brightness, alpha;
    
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue saturation:saturation brightness:MIN(brightness * 1.25, 1.0) alpha:alpha];
    else
        return self;
}

/**
 Returns a darker variation of the receiver, or the same color if the hue etc couldn't be obtained.
 
 @author DJS 2014-02.
 */

- (UIColor *)dejal_darkerColor;
{
    CGFloat hue, saturation, brightness, alpha;
    
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness * 0.75 alpha:alpha];
    else
        return self;
}

@end

