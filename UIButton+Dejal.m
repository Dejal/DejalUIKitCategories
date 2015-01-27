//
//  UIButton+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2008-11-26.
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

#import "UIButton+Dejal.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIButton (Dejal)

/**
 Returns the current title of the button; provided primarily for the property of the same name.
 
 @author DJS 2008-11.
*/

- (NSString *)dejal_title;
{
    return [self currentTitle];
}

/**
 Sets the button title for all control states at once.  Also available via the title property.
 
 @author DJS 2008-11.
*/

- (void)dejal_setTitle:(NSString *)newTitle;
{
    [self setTitle:newTitle forState:UIControlStateNormal];
    [self setTitle:newTitle forState:UIControlStateHighlighted];
    [self setTitle:newTitle forState:UIControlStateDisabled];
    [self setTitle:newTitle forState:UIControlStateSelected];
}

/**
 Adds a gloss layer.  Note that the button type needs to be Custom for this to work.
 
 @author DJS 2013-03.
*/

- (void)dejal_addGloss;
{
    CALayer *layer = self.layer;
    
    layer.masksToBounds = YES;
    layer.cornerRadius = 4.0;
    layer.borderWidth = 1.0;
    layer.borderColor = [UIColor colorWithWhite:0.4 alpha:0.7].CGColor;
    
    CAGradientLayer *glossLayer = [CAGradientLayer layer];
    
    glossLayer.frame = self.layer.bounds;
    glossLayer.colors = @[(id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.1f].CGColor,
                          (id)[UIColor colorWithWhite:0.75f alpha:0.1f].CGColor,
                          (id)[UIColor colorWithWhite:0.4f alpha:0.1f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor];
    
    glossLayer.locations = @[@0.0, @0.5, @0.5, @0.8, @1.0];
    
    [self.layer addSublayer:glossLayer];
    
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
}

@end

