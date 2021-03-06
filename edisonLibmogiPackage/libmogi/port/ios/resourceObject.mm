/******************************************************************************
 *                                                                            *
 *             Copyright (C) 2016 Mogi, LLC - All Rights Reserved             *
 *                            Author: Matt Bunting                            *
 *                                                                            *
 *            This program is distributed under the LGPL, version 2           *
 *                                                                            *
 *   This program is free software; you can redistribute it and/or modify     *
 *   it under the terms of the GNU Lesser General Public License              *
 *   version 2.1 as published by the Free Software Foundation;                *
 *                                                                            *
 *   See license in root directory for terms.                                 *
 *   https://github.com/mogillc/nico/tree/master/edisonLibmogiPackage/libmogi *
 *                                                                            *
 *****************************************************************************/

#import "resourceObject.h"
#import <GLKit/GLKit.h>

@implementation ResourceInterface

#ifdef __cplusplus

std::string _getMogiResourceDirectory()
{
	return std::string([[[NSBundle mainBundle] resourcePath] UTF8String]);
}

GLuint _loadTexture(const char* name, int glslVersion)
{
	NSString* filePath = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
	//NSLog(@"Loading texture: %@", filePath);

	GLKTextureInfo *spriteTexture;
	NSError *theError;

	if (glslVersion >= 300) {
		spriteTexture = [GLKTextureLoader textureWithContentsOfFile:filePath options:nil error:&theError];
	} else {
		glGetError();	// Yup, need to clear the error otherwise it will fail.  Lame.

		UIImage* image = [UIImage imageWithContentsOfFile:filePath];
		CGSize oldSize = [image size];

		double ratio = oldSize.width/oldSize.height;
		if (ratio != ceil(ratio)) {
			NSLog(@"This image does not have a ratio to support texture wrapping.");
		} else {
			double powerWidth = ceil(log2(oldSize.width));
			double powerHeight = ceil(log2(oldSize.height));

			CGSize newSize = CGSizeMake(pow(2.0, powerWidth), pow(2.0, powerHeight));

			UIGraphicsBeginImageContext(newSize);
			UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
			[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
			image = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
		}
		spriteTexture = [GLKTextureLoader textureWithCGImage:[image CGImage] options:nil error:&theError];
	}

	if (spriteTexture == nil) {
		NSLog(@"Error: loadTexture(): %@ ", [theError userInfo] );
	} else {
		//	NSLog(@"target = %d, name = %d", spriteTexture.target, spriteTexture.name);
		glBindTexture(spriteTexture.target, spriteTexture.name);	// TODO: is this needed?
		return spriteTexture.name;
	}
	return -1;
}
#endif

- (int) getInteger
{
	return 1435;
}
@end