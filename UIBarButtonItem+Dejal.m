//
//  UIBarButtonItem+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2009-09-15.
//  Copyright (c) 2009-2015 Dejal Systems, LLC. All rights reserved.
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

#import "UIBarButtonItem+Dejal.h"
#import "UISegmentedControl+Dejal.h"


@implementation UIBarButtonItem (Dejal)

/**
 Returns a new autoreleased bar button item containing an image.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
{
    return [[UIBarButtonItem alloc] initWithImage:image style:style target:target action:action];
}

/**
 Returns a new autoreleased bar button item containing a string title.  Note: DejalTableViewController also has retained properties for common buttons.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;
{
    return [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
}

/**
 Returns a new autoreleased bar button item containing a standard system button.  Note: DejalTableViewController also has retained properties for common buttons.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action;
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:target action:action];
}

/**
 Returns a new autoreleased bar button item containing a custom view.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonWithCustomView:(UIView *)customView;
{
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 Returns a new autoreleased bar button item for flexible space.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonFlexibleSpace;
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

/**
 Returns a new autoreleased bar button item for fixed space.
 
 @author DJS 2009-09.
 @version DJS 2012-05: changed to use a width of 15 (was defaulting to zero).
*/

+ (instancetype)dejal_barButtonFixedSpace;
{
    return [self dejal_barButtonFixedSpaceWithWidth:15.0];
}

/**
 Returns a new autoreleased bar button item for fixed space, with the specified width.
 
 @author DJS 2010-04.
*/

+ (instancetype)dejal_barButtonFixedSpaceWithWidth:(CGFloat)width;
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    item.width = width;
    
    return item;
}

/**
 Returns a new autoreleased bar button item for fixed space, with a narrower width than normal.
 
 @author DJS 2010-04.
 @version DJS 2012-05: changed to reduce the width from 15 to 5.
*/

+ (instancetype)dejal_barButtonNarrowSpace;
{
    return [self dejal_barButtonFixedSpaceWithWidth:5.0];
}

/**
 Returns a new autoreleased bar button item containing a segmented control with the specified items, target and action, and sets the initial selected segment index.  A more convenient variation of the similarly-named method in the UISegmentedControl+Dejal category.
 
 @author DJS 2009-09.
*/

+ (instancetype)dejal_barButtonSegmentedControlWithItems:(NSArray *)items target:(id)target action:(SEL)action selectedIndex:(NSInteger)selectedIndex;
{
    return [self dejal_barButtonWithCustomView:[UISegmentedControl dejal_segmentedControlWithItems:items target:target action:action selectedIndex:selectedIndex]];
}

@end

