- [Catchoom SDK for iOS](#catchoom-sdk-for-ios)
	- [Description](#description)
	- [Requirements](#requirements)
	- [Quick Start](#quick-start)
	- [Adding the SDK to your app](#adding-the-sdk-to-your-app)
	- [Reporting Issues](#reporting-issues)

Catchoom SDK for iOS
====================


Description
-----------

Catchoom SDK for iOS allows you to integrate into your mobile application the advanced Image Recognition (IR) capabilities of the [Catchoom Recognition Service (CRS)](http://crs.catchoom.com).

The integration is as simple as importing the compiled SDK into your project and adding a few lines of code. The SDK takes care of capturing the best images, sending them to the CRS, and receiving the recognition results with the related content.

You can implement one of the two different modes of Image Recognition:

* **Single shot mode**, where users initiate every recognition request (e.g. by pressing a button).
* **Finder mode**, allowing continuous scan and automatic recognition of all objects appearing in front of the camera.

More specifically, the SDK implements the following features:

* Accessing the CRS image recognition service via [CRS recognition API](http://catchoom.com/documentation/api/recognition/). This includes sending recognition requests to your collections and getting the results and the associated contents/custom data. Moreover, you can even have the SDK communicating with your own backend service and working as a proxy to the CRS.
* Flexible image and video capturing abstraction layer allowing you to specify the video preview. The SDK manages the video capture and presentation of the augmented reality scene. Moreover, you can easily customise the preview and the rendering of the content associated to the recognised objects.


Requirements
------------
To build the project or use the library, you will need XCode 5 or newer, and at least the iOS 5.0 library.


Quick Start
-----------
The **easiest** way to get started with the Catchoom SDK is downloading the example project form [our github](https://github.com/Catchoom/catchoom-example-ios), and trying the example application with your images from the [CRS](http://crs.catchoom.com). The example app includes a compiled version of the **RestKit** framework and all dependencies are already added to the project.

In order to get the example running you just have to follow three simple steps:

1. Clone the repository
2. Unzip the Catchoom SDK for iOS it into the ExternalFrameworks directory.
3. Get a collection token and add it as a string literal in the sdk call:

 
 ```objc
  [_sdk setDefaultCollectionToken: PLACE_YOUR_CRS_TOKEN_HERE];
  ```

This is enough to compile the project and start [recognising things](http://catchoom.com/documentation/what-kind-of-objects-do-we-recognize/).


Adding the SDK to your app
--------------------------

The iOS Catchoom SDK is distributed as a .framework that you can directly drag into your project. It has, though some dependencies on frameworks/libraries that have to be linked:

* QuartzCore
* AVFoundation
* CoreMedia
* CoreGraphics
* CoreVideo
* CoreFoundation
* GLKit
* OpenGLES
* MediaPlayer
* Security
* CFNetwork

It also depends on RestKit v0.20.3 and its [dependencies](https://github.com/RestKit/RestKit):

```md
The following Cocoa frameworks must be linked into the application target for proper compilation:

CFNetwork.framework on iOS
CoreData.framework
Security.framework
MobileCoreServices.framework on iOS or CoreServices.framework on OS X
And the following linker flags must be set:

-ObjC
-all_load
```

Also, you will need to add some flags to your project in order to link the application properly due to [known issues](https://developer.apple.com/library/mac/qa/qa1490/_index.html) with xCode related to the use of categories in static libraries:

```
-Objc -all_load
```

Then you just have to create a view in your starboards and link it to a UIView IBOutlet for the camera preview. Pass the preview to the catchoom's SDK ```startVideoForView:``` message and use one of the methods shown [in the examples](https://github.com/Catchoom/catchoom-example-ios) to send images to the CRS.


Reporting Issues
----------------
If you have suggestions, bugs or other issues specific to this library, file them [here](https://github.com/Catchoom/catchoom-sdk-ios/issues) or contact us at [support@catchoom.com](mailto:support@catchoom.com).
