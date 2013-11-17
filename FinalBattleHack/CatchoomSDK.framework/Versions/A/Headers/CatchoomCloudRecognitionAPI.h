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

@protocol CatchoomSearchProtocol;

/*
 * The CatchoomCloudRecognitionAPI class is used by the SDK to connect to
 * the CRS. It just manages the network connection and requests and forwards the
 * responses to the SDK to be processed. This class behaviour may be overriden in 
 * order to place a proxy between the CRS API and the SDK.
 */
@interface CatchoomCloudRecognitionAPI : NSObject

@property (nonatomic, weak) id <CatchoomSearchProtocol> delegate;

// Returns the singleton instance of this class.
+ (CatchoomCloudRecognitionAPI *)sharedCatchoom;

// Used internally to obtain the CRS API url to connect to
+ (NSString*) getCloudRecognitionUrl;

// Creates a connection with the server using the set token. With this call, you are authenticating the
// application against catchoom service and connecting the app to a specific collection.
// will answer with the delegate didReceiveConnectResponse: or didFailLoadWithError:
- (void)connectForCollection: (NSString*) collectionToken;

// Performs a search call for an image data.
// Parameters:
//   * bbox: NSString (true/false) (return bounding boxes, "false" by df)
//   * embed_tracking_data: NSString (true/false) (embed tracking data file in response, "false" by df)
//   * embed_custom_data: NSString (true/false) (embed custom data in resposnse, "false" by df)
// Answers with a delegate didReceiveSearchResponse: or didFailLoadWithError:
- (void)searchWithData:(NSData *)imageNSData andParams: (NSDictionary*) params forCollection: (NSString*) collectionToken;

@end


@protocol CatchoomSearchProtocol <NSObject>

@optional

// delegate answer for connect callback. the return object is a JSON with the information of the
// connection status
- (void)didReceiveConnectResponse:(id)response withCode: (int) statusCode;

// delegate answer for the Search callback. The response object is a JSON object with the CRS service response.
- (void)didReceiveServerSearchResponse:(id)response withCode: (int) statusCode;

// delegate answer if server call fails
- (void)didFailLoadWithError:(NSError *)error;

@end
