// This file is free software. You may use it under the MIT license, which is copied
// below and available at http://opensource.org/licenses/MIT
//
// Copyright (c) 2013 Catchoom Technologies S.L.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.


#import <Foundation/Foundation.h>


typedef struct bbox {
    CGSize _tr;
    CGSize _tl;
    CGSize _bl;
    CGSize _br;
} bbox_t;

/*
 * This structure encloses the properties of a CRS item
 */
@interface CatchoomCloudRecognitionItem : NSObject

@property (nonatomic) NSString *itemId;
@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *imageId;
@property (nonatomic) NSString *score;
@property (nonatomic) NSString *thumbnail120;
@property (nonatomic) NSString *url;

// String containing custom field from CRS
@property (nonatomic) NSString *custom;

// JSON object with Contents/Secene description
@property (nonatomic) NSArray  *contents;

// Base64 string with tracking data file
@property (nonatomic) NSString *trackingData;

// Bounding box of the found item inside the request image sent to CRS
@property (nonatomic) bbox_t bbox;

- (id) initWithJSONResult: (id) obj;

@end
