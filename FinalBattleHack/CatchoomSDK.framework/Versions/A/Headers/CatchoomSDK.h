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
#import "CatchoomCloudRecognition.h"

@protocol CatchoomSDKProtocol;

@interface CatchoomSDK : NSObject

@property (nonatomic, weak) id <CatchoomSDKProtocol> delegate;

// Get the singletonn instance of the SDK
+ (CatchoomSDK *)sharedCatchoomSDK;

// Get the singleton instance of the SDK with a non-default CRS API Class
// to allow proxies. If used, has to be called once and for the first time the
// SDK is used in the application.
+ (CatchoomSDK *)sharedCatchoomSDKWithCRSAPI: (id) crsAPIClass;


// initialize a video capture for a given UIView (it expects an empty view.
- (void) startVideoForView: (UIView*) previewView;

// Start video will be automatically called on initialization
// when the startup of the video capture is finished
// didInitializeVideoCaptureAndPreview will be called using the CatchoomSDKProtocol
- (void) startVideoCaptureAndPreview;

- (void) takeSnapShot;
- (void) takePreviewSnapShot DEPRECATED_ATTRIBUTE;

// This method will pause the video capture and freeze the preview
- (void) pausePreview;
// Continue video preview
- (void) continuePreview;

// This method will stop all processes within the SDK (video preview, searches, tracking..)
// and clear all the structures (tracking)
- (void) stop;

// Returns the CloudRecognition object from the SDK
- (CatchoomCloudRecognition *) getCloudRecognitionInterface;

// Set the collection token to be used by the CloudRecognition
- (void) setDefaultCollectionToken:(NSString *)collectionToken;

@end


@protocol CatchoomSDKProtocol <NSObject>

// Callback from SDK after video capture and preview have started, before this is called it is not safe
// to add/remove references or start any process using the video capture (captureSearch, tracking)
- (void) didStartVideoCaptureAndPreview;

@optional
- (void) didGetSnapshotFromPreview: (UIImage*) snapShot;

@end

