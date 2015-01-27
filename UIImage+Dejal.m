//
//  UIImage+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2009-09-29.
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

#import "UIImage+Dejal.h"


@implementation UIImage (Dejal)

/**
 Returns the named image, recolored white, either from a cache, or added to the cache.  Useful for highlighted table cell icons.
 
 @author DJS 2012-06.
 @version DJS 2013-01: changed to use +imageNamed:withOverlayColor:.
 @version DJS 2013-11: changed to return an unrecolored image on iOS 7 and later; remove uses of this method once that is the minimum.
*/

+ (UIImage *)dejal_whiteTintedImageNamed:(NSString *)name;
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        return [self dejal_imageNamed:name withOverlayColor:[UIColor whiteColor]];
    else
        return [self imageNamed:name];
}

/**
 Returns the named image, recolored gray, either from a cache, or added to the cache.  Useful for disabled table cell icons.
 
 @author DJS 2013-01.
*/

+ (UIImage *)dejal_grayTintedImageNamed:(NSString *)name;
{
    return [self dejal_imageNamed:name withOverlayColor:[UIColor grayColor]];
}

/**
 Given an array of images, returns them all with a white overlay.
 
 @author DJS 2012-06.
*/

+ (NSArray *)dejal_whiteTintedImages:(NSArray *)imageArray;
{
    NSMutableArray *tintedArray = [NSMutableArray arrayWithCapacity:imageArray.count];
    
    for (UIImage *image in imageArray)
        [tintedArray addObject:[image dejal_imageWithWhiteOverlay]];
    
    return tintedArray;
}

/**
 Returns a new autoreleased copy of the receiever, recolored white.  Useful for highlighted table cell icons.  Better to use +whiteTintedImageNamed:, though, so it is cached.
 
 @author DJS 2011-10.
 @version DJS 2013-11: changed to return the receiver on iOS 7 and later; remove uses of this method once that is the minimum.
*/

- (UIImage *)dejal_imageWithWhiteOverlay;
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        return [self dejal_imageWithOverlayColor:[UIColor whiteColor]];
    else
        return self;
}

/**
 Returns a new autoreleased copy of the receiever, recolored gray.  Useful for disabled table cell icons.  Better to use +grayTintedImageNamed:, though, so it is cached.
 
 @author DJS 2012-10.
*/

- (UIImage *)dejal_imageWithGrayOverlay;
{
    return [self dejal_imageWithOverlayColor:[UIColor grayColor]];
}

/**
 Given the name of an image and an overlay color, returns that image with that overlay, either from a cache, or added to the cache.  If the overlay color is nil, does the same as +imageNamed:.
 
 @author DJS 2013-01.
*/

+ (UIImage *)dejal_imageNamed:(NSString *)name withOverlayColor:(UIColor *)color;
{
    if (!color)
        return [self imageNamed:name];
    
    static NSMutableDictionary *dejalImageCache = nil;
    
    if (!dejalImageCache)
        dejalImageCache = [NSMutableDictionary dictionary];
    
    NSString *key = [NSString stringWithFormat:@"%@ %@", name, [color description]];
    UIImage *image = dejalImageCache[key];
    
    if (!image)
    {
        image = [[self imageNamed:name] dejal_imageWithOverlayColor:color];
        dejalImageCache[key] = image;
    }
    
    return image;
}

/**
 Returns a new autoreleased copy of the receiver, recolored as requested.
 
 @author DJS 2011-10: based on http://stackoverflow.com/questions/1223340/iphone-how-do-you-color-an-image
 @version DJS 2012-06: changed to remove pre-iOS 4 stuff.
*/

- (UIImage *)dejal_imageWithOverlayColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    [self drawInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 Returns a new autoreleased copy of the receiver, scaled and cropped to the specified size, keeping the aspect ratio, or returns the receiver if it is already the specified size.  If canScaleUp is NO, it is not scaled if smaller than the specified size.  Note: this method is not thread-safe.
 
 @author DJS 2009-10.
*/

- (UIImage *)dejal_imageAspectScaledToSize:(CGSize)newSize canScaleUp:(BOOL)canScaleUp;
{
    return [self dejal_imageAspectScaledToSize:newSize canScaleUp:canScaleUp threadSafe:NO];
}

/**
 Returns a new autoreleased copy of the receiver, scaled and cropped to the specified size, keeping the aspect ratio, or returns the receiver if it is already the specified size.  If canScaleUp is NO, it is not scaled if smaller than the specified size.  Pass YES for threadSafe to do it in a thread-safe way, though it currently doesn't support all downloaded images (gives an error like "<Error>: CGBitmapContextCreate: unsupported parameter combination: 8 integer bits/component; 32 bits/pixel; 3-component colorspace; kCGImageAlphaLast; 512 bytes/row").
 
 @author DJS 2009-10: based on http://stackoverflow.com/questions/1282830/uiimagepickercontroller-uiimage-memory-and-more
*/

- (UIImage *)dejal_imageAspectScaledToSize:(CGSize)newSize canScaleUp:(BOOL)canScaleUp threadSafe:(BOOL)threadSafe;
{  
    CGSize imageSize = self.size;
    
    // Return the receiver if it is already the right size:
    if (CGSizeEqualToSize(imageSize, newSize))
        return self;
    
    if (!canScaleUp && imageSize.width <= newSize.width && imageSize.height <= newSize.height)
        return self;
    
    UIImage *newImage = nil;        
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = 0.0;
    CGFloat scaledHeight = 0.0;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    CGFloat widthFactor = newWidth / width;
    CGFloat heightFactor = newHeight / height;
    
    // Scale to fit height or width:
    if (widthFactor > heightFactor)
        scaleFactor = widthFactor;
    else
        scaleFactor = heightFactor;
    
    scaledWidth  = width * scaleFactor;
    scaledHeight = height * scaleFactor;
    
    // Center the image:
    if (widthFactor > heightFactor)
        thumbnailPoint.y = (newHeight - scaledHeight) * 0.5; 
    else if (widthFactor < heightFactor)
        thumbnailPoint.x = (newWidth - scaledWidth) * 0.5;
    
    if (threadSafe)
    {
        CGImageRef imageRef = [self CGImage];
        CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
        CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
        
        if (bitmapInfo == kCGImageAlphaNone)
            bitmapInfo = kCGImageAlphaNoneSkipLast;
        
        CGContextRef bitmap;
        
        if (self.imageOrientation == UIImageOrientationUp || self.imageOrientation == UIImageOrientationDown)
            bitmap = CGBitmapContextCreate(NULL, newWidth, newHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        else
            bitmap = CGBitmapContextCreate(NULL, newHeight, newWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
        // In the right or left cases, we need to switch scaledWidth and scaledHeight, and also the thumbnail point:
        if (self.imageOrientation == UIImageOrientationLeft)
        {
            thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
            CGFloat oldScaledWidth = scaledWidth;
            scaledWidth = scaledHeight;
            scaledHeight = oldScaledWidth;
            
            CGContextRotateCTM(bitmap, DejalDegreesToRadians(90.0));
            CGContextTranslateCTM(bitmap, 0.0, -newHeight);
            
        }
        else if (self.imageOrientation == UIImageOrientationRight)
        {
            thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
            CGFloat oldScaledWidth = scaledWidth;
            scaledWidth = scaledHeight;
            scaledHeight = oldScaledWidth;
            
            CGContextRotateCTM(bitmap, DejalDegreesToRadians(-90.0));
            CGContextTranslateCTM(bitmap, -newWidth, 0.0);
            
        }
        else if (self.imageOrientation == UIImageOrientationDown)
        {
            CGContextTranslateCTM(bitmap, newWidth, newHeight);
            CGContextRotateCTM(bitmap, DejalDegreesToRadians(-180.0));
        }
        
        CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
        CGImageRef ref = CGBitmapContextCreateImage(bitmap);
        
        newImage = [UIImage imageWithCGImage:ref];
        
        CGContextRelease(bitmap);
        CGImageRelease(ref);
    }
    else
    {
        UIGraphicsBeginImageContext(newSize);
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        [self drawInRect:thumbnailRect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if (!newImage) 
            NSLog(@"could not scale image");
        
        UIGraphicsEndImageContext();
    }

    return newImage; 
}

/**
 Returns the receiver with the corners rounded off to the specified radius.
 
 @author DJS 2010-01, with forum help: https://devforums.apple.com/message/156207
*/

- (UIImage *)dejal_imageMaskedWithCornerRadius:(CGFloat)radius;
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat midX = self.size.width / 2.0;
    CGFloat maxX = self.size.width;
    CGFloat midY = self.size.height / 2.0;
    CGFloat maxY = self.size.height;
    
    CGContextMoveToPoint(context, 0.0, midY);
    CGContextAddArcToPoint(context, 0.0, 0.0, midX, 0.0, radius);
    CGContextAddArcToPoint(context, maxX, 0.0, maxX, midY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    CGContextAddArcToPoint(context, 0.0, maxY, 0.0, midY, radius);
    CGContextClosePath(context);
    
    CGContextClip(context);
    CGContextTranslateCTM(context, 0.0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, self.size.width, self.size.height), self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

