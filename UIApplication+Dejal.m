//
//  UIApplication+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2009-07-26.
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
//
//  Portions copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "UIApplication+Dejal.h"


@implementation UIApplication (Dejal)

static __weak id dejal_currentFirstResponder;

/**
 Returns the first responder view for the application's key window.
 
 @author MG 2009-04; tweaked by DJS 2009-07.
 @version DJS 2015-03: changed to avoid using a private method.
*/

+ (UIView *)dejal_firstResponder;
{
    dejal_currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(dejal_findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return dejal_currentFirstResponder;
}

/**
 Helper for the +dejal_firstResponder method.  Call that instead.
 
 @author DJS 2015-03.
 */

-(void)dejal_findCurrentFirstResponder:(id)sender;
{
    dejal_currentFirstResponder = self;
}

/**
 Returns the keyboard view, if it is present.
 
 @author MG 2009-04; tweaked by DJS 2009-07.
 @version DJS 2012-01: changed to use UIPeripheralHostView instead of UIKeyboardView.
*/

+ (UIView *)dejal_keyboardView;
{
	NSArray *windows = [[self sharedApplication] windows];
    
	for (UIWindow *window in [windows reverseObjectEnumerator])
	{
		for (UIView *view in [window subviews])
		{
			if (!strcmp(object_getClassName(view), "UIPeripheralHostView"))
				return view;
		}
	}
	
	return nil;
}

@end

