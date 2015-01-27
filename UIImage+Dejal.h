//
//  UIImage+Dejal.h
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

@import Foundation;


#define DejalDegreesToRadians(degrees) ((degrees * M_PI) / 180.0)


@interface UIImage (Dejal)

+ (UIImage *)dejal_whiteTintedImageNamed:(NSString *)name;
+ (UIImage *)dejal_grayTintedImageNamed:(NSString *)name;

+ (NSArray *)dejal_whiteTintedImages:(NSArray *)imageArray;

- (UIImage *)dejal_imageWithWhiteOverlay;
- (UIImage *)dejal_imageWithGrayOverlay;
- (UIImage *)dejal_imageWithOverlayColor:(UIColor *)color;

+ (UIImage *)dejal_imageNamed:(NSString *)name withOverlayColor:(UIColor *)color;

- (UIImage *)dejal_imageAspectScaledToSize:(CGSize)newSize canScaleUp:(BOOL)canScaleUp;
- (UIImage *)dejal_imageAspectScaledToSize:(CGSize)newSize canScaleUp:(BOOL)canScaleUp threadSafe:(BOOL)threadSafe;

- (UIImage *)dejal_imageMaskedWithCornerRadius:(CGFloat)radius;

@end

