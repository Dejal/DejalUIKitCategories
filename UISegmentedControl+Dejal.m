//
//  UISegmentedControl+Dejal.m
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

#import "UISegmentedControl+Dejal.h"


@implementation UISegmentedControl (Dejal)

/**
 Returns a new segmented control containing the specified items, target and action, and sets the initial selected segment index.
 
 @author DJS 2009-09.
 @version DJS 2014-01: changed to remove the style argument, since it is obsolete.
*/

+ (instancetype)dejal_segmentedControlWithItems:(NSArray *)items target:(id)target action:(SEL)action selectedIndex:(NSInteger)selectedIndex;
{
    UISegmentedControl *control = [[self alloc] initWithItems:items];
    
    control.selectedSegmentIndex = selectedIndex;
    
    [control addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return control;
}

@end

