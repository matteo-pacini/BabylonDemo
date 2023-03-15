# BabylonDemo 🚀

![demo](./demo.gif)

## Specification 📄

For detailed specifications, please refer to the following link:
https://github.com/Babylonpartners/iOS-Interview-Demo/blob/master/demo.md

## Note on Demo Recording 🎥

To record the demo, the **NetworkLinkConditioner** has been employed to simulate slower network conditions using the profile displayed below:

![networklinkconditioner](./networklinkconditioner.png)

## Dependencies 📦

Dependencies in this project are managed through **Swift Package Manager (SwiftPM)**.

## Third-Party Frameworks 🛠️

The following third-party frameworks have been incorporated into the project:

- `RxSwift`
- `MBProgressHUD`

## Architecture 🏗️

### MVVM-C (Model-View-ViewModel-Coordinator)

The **BabylonDemo** app relies on the **Core.framework**, which encompasses 99% of the application's functionality.

The `AppCoordinator` initializes the `PostsCoordinator` on the key window. The `PostsCoordinator` embeds a `PostsViewController` within a `UINavigationController` and sets it as the root view controller of the key window.

The `PostsViewModel` retrieves the posts displayed in the table view. When a post is selected, the `PostsTableViewCellViewModel` informs the `PostsViewModel` through delegation. In turn, the `PostsViewModel` notifies the `PostsCoordinator` via delegation.

Subsequently, the `PostsCoordinator` initiates the `PostDetailCoordinator` on the navigation controller, pushing the `PostDetailViewController` onto the navigation stack. The `PostDetailViewModel` is responsible for fetching user and comment data.

### Caching 💾

The `CachedWebService` serves as a decorator for any class implementing the `WebserviceType` protocol, offering basic storage capabilities.

For the purpose of this demo, `NSUserDefaults` is utilized as the storage solution.

## Tests ⚙️

The original tests, **CoreTests**, were designed for the **Core.framework** and included tests for view models and view controllers. However, they have been removed due to compatibility issues between Quick+Nimble and the @MainActor and async/await functionalities.
