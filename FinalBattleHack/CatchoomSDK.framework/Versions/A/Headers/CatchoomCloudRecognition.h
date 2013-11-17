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
#import "CatchoomCloudRecognitionError.h"

@protocol CatchoomCloudRecognitionProtocol;

/*
 * The CatchooomCloudRecognition class offers an interface
 * for performing searches to the CRS from the attached video capture 
 */
@interface CatchoomCloudRecognition :  NSObject

@property (nonatomic, weak) id <CatchoomCloudRecognitionProtocol> delegate;

/*
 * Class for the items obtained from the CRS response, by default is CatchoomCloudRecognitionItem.
 */
@property (nonatomic, readwrite) id cloudRecognitionItemClass;

@property (nonatomic, readwrite) bool retrieveBoundingBox;
@property (nonatomic, readwrite) bool retrieveCustomField DEPRECATED_ATTRIBUTE;
@property (nonatomic, readwrite) bool embedCustomField;

// Set the token for the searches in the CRS
- (void) setToken: (NSString*) collectionToken;

// Start searching in continuous mode (as video frames arrive from the video capture)
- (void) startSearch;

// Stop searching
- (void) stopSearch;

// Perform one CRS search with the provided image
- (void) searchWithUIImage: (UIImage*) image;

@end

@protocol CatchoomCloudRecognitionProtocol <NSObject>

// Callback for successful CRS request. resultItems contains a
// list of CloudRecognitionItems
- (void)didGetSearchResults: (NSArray *) resultItems;

// Callback for unsuccessful CRS request. error is a CatchoomCloudRecognitionError (NSError)
- (void)didFailWithError: (CatchoomCloudRecognitionError *)error;

@end
