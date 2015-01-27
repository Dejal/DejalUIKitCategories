//
//  UIView+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2009-02-04.
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

#import "UIView+Dejal.h"
@import QuartzCore;


@implementation UIView (Dejal)

/**
 Returns the receiver’s frame origin.
 
 @author DJS 2009-11.
*/

- (CGPoint)dejal_frameOrigin;
{
    return self.frame.origin;
}

/**
 Sets the receiver's frame origin, without tedious local variables or hassles.
 
 @author DJS 2009-11.
*/

- (void)dejal_setFrameOrigin:(CGPoint)origin;
{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

/**
 Returns the receiver's frame origin X position.
 
 @author DJS 2009-11.
*/

- (CGFloat)dejal_frameX;
{
    return self.frame.origin.x;
}

/**
 Sets the receiver's frame origin X position, without tedious local variables or hassles.
 
 @author DJS 2009-11.
*/

- (void)dejal_setFrameX:(CGFloat)x;
{
    self.dejal_frameOrigin = CGPointMake(x, self.dejal_frameY);
}

/**
 Returns the receiver's frame origin Y position.
 
 @author DJS 2009-11.
*/

- (CGFloat)dejal_frameY;
{
    return self.frame.origin.y;
}

/**
 Sets the receiver's frame origin Y position, without tedious local variables or hassles.
 
 @author DJS 2009-11.
*/

- (void)dejal_setFrameY:(CGFloat)y;
{
    self.dejal_frameOrigin = CGPointMake(self.dejal_frameX, y);
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 Returns the receiver’s bounds size.
 
 @author DJS 2009-10.
*/

- (CGSize)dejal_boundsSize;
{
    return self.bounds.size;
}

/**
 Sets the receiver's bounds size, without tedious local variables or hassles.
 
 @author DJS 2009-10.
*/

- (void)dejal_setBoundsSize:(CGSize)size;
{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, size.width, size.height);
}

/**
 Returns the receiver's bounds size width.
 
 @author DJS 2009-10.
*/

- (CGFloat)dejal_boundsWidth;
{
    return self.bounds.size.width;
}

/**
 Sets the receiver's bounds size width, without tedious local variables or hassles.
 
 @author DJS 2009-10.
*/

- (void)dejal_setBoundsWidth:(CGFloat)width;
{
    self.dejal_boundsSize = CGSizeMake(width, self.dejal_boundsHeight);
}

/**
 Returns the receiver's bounds size height.
 
 @author DJS 2009-10.
*/

- (CGFloat)dejal_boundsHeight;
{
    return self.bounds.size.height;
}

/**
 Sets the receiver's bounds size height, without tedious local variables or hassles.
 
 @author DJS 2009-10.
*/

- (void)dejal_setBoundsHeight:(CGFloat)height;
{
    self.dejal_boundsSize = CGSizeMake(self.dejal_boundsWidth, height);
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 Returns an image representation of the receiver and its subviews.
 
 @author DJS 2009-02.
*/

- (UIImage *)dejal_imageRepresentation;
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 Shows or hides the reciever by fading it in or out if animated is YES, or just shows or hides immediately.  Uses an animation duration of 0.3, which is the same as the keyboard animation.
 
 @author DJS 2009-10.
*/

- (void)dejal_setHidden:(BOOL)hide animated:(BOOL)animated;
{
    [self dejal_setHidden:hide animated:animated withDuration:0.3];
}

/**
 Shows or hides the reciever by fading it in or out if animated is YES, or just shows or hides immediately.  An animation duration can be specified (ignored if not animating).
 
 @author DJS 2009-10.
*/

- (void)dejal_setHidden:(BOOL)hide animated:(BOOL)animated withDuration:(NSTimeInterval)duration;
{
    if (!hide)
    {
        self.alpha = 0.0;
        self.hidden = NO;
    }
    
    if (animated)
    {
        [UIView beginAnimations:@"DejalViewExtrasHiding" context:(__bridge void *)(@(hide))];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(hideAnimationDidStop:finished:hiding:)];
    }
    
    if (!hide)
        self.alpha = 1.0;
    else if (animated)
        self.alpha = 0.0;
    else
        self.hidden = YES;
    
    if (animated)
        [UIView commitAnimations];
}

/**
 Hides the receiver once the hide animation has stopped when hiding; does nothing when showing (but is still called, to avoid it getting called mistakenly if the hiding is interrupted by a show).
 
 @author DJS 2009-10.
*/

- (void)hideAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished hiding:(NSNumber *)hide;
{
    if ([animationID isEqualToString:@"DejalViewExtrasHiding"] && finished && [hide boolValue] && self.alpha == 0.0)
        self.hidden = YES;
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 Adds the reciever as a subview of the specified view, optionally fading it in with animation.  Uses an animation duration of 0.3, which is the same as the keyboard animation.
 
 @author DJS 2009-10.
*/

- (void)dejal_addToSuperview:(UIView *)view animated:(BOOL)animated;
{
    [self dejal_addToSuperview:view animated:animated withDuration:0.3];
}

/**
 Adds the reciever as a subview of the specified view, optionally fading it in with animation.  An animation duration can be specified (ignored if not animating).
 
 @author DJS 2009-10.
*/

- (void)dejal_addToSuperview:(UIView *)view animated:(BOOL)animated withDuration:(NSTimeInterval)duration;
{
    if (animated)
        self.alpha = 0.0;
    
    if (!self.superview)
        [view addSubview:self];
    
    if (animated)
    {
        [UIView beginAnimations:@"DejalViewExtrasAddToSuperview" context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:duration];
        
        self.alpha = 1.0;
        
        [UIView commitAnimations];
    }
}

/**
 Removes the reciever from its superview, optionally fading it out with animation.  Uses an animation duration of 0.3, which is the same as the keyboard animation.
 
 @author DJS 2009-10.
*/

- (void)dejal_removeFromSuperviewAnimated:(BOOL)animated;
{
    [self dejal_removeFromSuperviewAnimated:animated withDuration:0.3];
}

/**
 Removes the reciever from its superview, optionally fading it out with animation.  An animation duration can be specified (ignored if not animating).
 
 @author DJS 2009-10.
*/

- (void)dejal_removeFromSuperviewAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration;
{
    if (!self.superview)
        return;
    
    if (animated)
    {
        [UIView beginAnimations:@"DejalViewExtrasRemoveFromSuperview" context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dejal_removeFromSuperviewAnimationDidStop:finished:context:)];
        
        self.alpha = 0.0;
        
        [UIView commitAnimations];
    }
    else
        [self removeFromSuperview];
}

/**
 Removes the receiver from the superview once the hide animation has stopped.
 
 @author DJS 2009-10.
*/

- (void)dejal_removeFromSuperviewAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
{
    if ([animationID isEqualToString:@"DejalViewExtrasRemoveFromSuperview"] && finished && self.alpha == 0.0)
        [self removeFromSuperview];
}

@end

