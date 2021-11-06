# Flickry

Flickry is an app that allows you to search for images in Flickr. The first 25 items will be shown in the list. It support pagination such that it automatically requests for the next page when the scroll has reached the end therefore allows for endless scrolling. The app utilizes the Coordinator pattern.

## 3rd Party Libraries
Most of the 3rd party libraries are installed using Swift Package Manager (SPM) for faster build times and to reduce the project file size since it will be uploaded to a GitHub repository.

- Moya (SPM) - For a cleaner encapsulation of network code
- Reusable (SPM) - For easier, cleaner, and type-safe instantiation of reusable views
- Closures (SPM) - Allows for quicker implementation of delegates, data sourcing, and target actions
- Kingfisher (SPM) - Allows for seamless fetching of images from the web
- SwiftGen (CocoaPods) - For type-safe code when using storyboard scenes, assets, and etc. CocoaPods was used for this since scripts in build phases aren't supported yet for SPM.

## Architecture
The app was built using MVC since this is a simple application with a very limited timeframe and using other design patterns like MVVM will consume more time.
