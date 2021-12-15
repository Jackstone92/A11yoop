# A11yoop - iOS Accessibility Tools 

![Swift](https://img.shields.io/badge/swift-5.5-red.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-ff59b4)
[![codecov](https://codecov.io/gh/Jackstone92/A11yoop/branch/develop/graph/badge.svg?token=5CUD7R531H)](https://codecov.io/gh/Jackstone92/A11yoop)

## A11oopMonitor
Have you ever wondered which accessibility features users of your app actually have enabled? Do you want to easily be able to prioritise accessibility improvements that should be made to your app based on real data from your user base?

`A11yoopMonitor` allows you to track which accessibility features users have enabled on their iOS devices while they use your app. It is simple to integrate into an existing app and provides an easy way of tracking status changes as users enable/disable features on their devices. It is also highly extendable, providing a simple API that allows you to do whatever you want with the data that is received.

#### **A note about privacy...**
It is worth mentioning that any data tracked by `A11yoopMonitor` is completely anonymous and there is no way of identifying one user from another. All that is provided is a unified API to determine accessibility feature status changes as they are occur.

### **Specify which accessibility features you want to monitor**

When you instantiate `A11yoopMonitor`, you have the option to specify which accessibility features you want to monitor. These can either be chosen by you or can be omitted and all observable accessibility features will be monitored by default.
```swift
import A11yoop

final class MyClass {

    // In order to only monitor specific accessibility features (eg. voice over and larger text):
    let specificMonitor = A11yoopMonitor(featureTypes: [.voiceOver, .largerText])

    // In order to monitor all observable accessibility features:
    let defaultMonitor = A11yoopMonitor()
}
```

### **Query accessibility feature statuses**

Once you have instantiated `A11yoopMonitor`, it is possible to query the current status of an observed accessibility feature at any point. This can be done as follows:
```swift
let monitor = A11yoopMonitor(featureTypes: [.voiceOver, ...])

// In order to query current status of voice over accessibility feature
let isEnabled = monitor.isFeatureEnabled(.voiceOver)
```

Note that it is only possible to query the status of accessibility features that are currently being monitored. Doing the following would therefore always result in `.disabled`:
```swift
let monitor = A11yoopMonitor(featureTypes: [.voiceOver]) // Only monitors voice over

let isEnabled = monitor.isFeatureEnabled(.boldText) // Query an accessibility feature that isn't monitored
/// - false
```

Finally, if an accessibility feature that you are monitoring is not currently supported on a user's device, the status is returned as `.notSupported`.

### **Integrate with Analytics APIs**

In order to provide easy integration with third-party analytics SDK APIs, `A11yoopMonitor` provides a way to convert all currently monitored accessibility features into a params dictionary (of type `[String: Any]`), which is compatible with most analytics SDK APIs. This dictionary would contain key-value pairs mapping the feature type description to the current feature status description (eg. `["Bold Text": "Disabled"`]).

This conversion is possible by using the `asAnalyticsParams(prefixedBy:)` adapter, which transforms a sequence of `A11yFeature` into a `[String: Any]` representation.

A sample use-case would be including accessibility feature statuses in a tracking event:
```swift
func sendEvent() {

    let params = self.monitor.features.asAnalyticsParams()
    let eventName = "A11yoop features"

    // Firebase
    Analytics.logEvent(eventName, parameters: params)
}
```

In order to prevent conflicts, it is also possible to pass a prefix, which will be applied to all parameter keys (eg. resulting in "A11yoop Bold Text" with a prefix applied rather than "Bold Text" without).

### Extend functionality with custom emitters

It is possible to write custom emitters in order to react to accessibility feature status changes in whatever way you want.
For example, if you wanted to send individual analytics events specific to each accessibility feature (rather than using `asAnalyticsParams(prefixedBy:)`), then the best way to achieve this is to write your own custom emitter.

This can be done by extending `A11yStatusEmitter` and creating your own static configuration that can then be included in your `A11yoopMonitor(featureTypes:emitters:)` initialisation:
```swift

extension A11yStatusEmitter {

    static var analyticsEventEmitter: Self {
        Self { feature in
            // The feature argument is the updated feature. Do with it whatever you want...

            Analytics.logEvent(
                "A11yoop Feature Updated",
                parameters: [feature.type.description: feature.status.description])
        }
    }
}

final class MyClass {

    // Include the custom emitter in your `A11yoopMonitor` initialisation
    let monitor = A11yoopMonitor(emitters: [.analyticsEventEmitter, .log())
}
```

## Installation
It is currently possible to install this library using Swift Package Manager. In order to do so, please add the current repository as a package dependency using Xcode or include the following in your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/Jackstone92/A11yoop", .upToNextMajor(from: "1.0.0")),
    ],
    ...
    targets: [
        .target(name: "MyTarget", dependencies: ["A11yoop"]),
    ]
)
```

For further information on how `A11yoopMonitor` might be used in your app, please take a look at the [preview app](https://github.com/Jackstone92/A11yoop/tree/main/Preview). This provides a playground environment where you can toggle accessibility features and track the changes in the app. All changes are monitored using `A11yoopMonitor`.

## Additional Resources
- [Apple Accessibility](https://developer.apple.com/accessibility/)
- [WWDC Accessibility & Inclusion Videos](https://developer.apple.com/videos/accessibility-inclusion)
- [A11y iOS Guidelines](https://a11y-guidelines.orange.com/en/mobile/ios/)

## Contributions
Any contributions to *A11yoop* are more than welcome, whether they be feature requests, bug reports or any general questions and feedback! Please take a quick look at the contribution guidelines if you want to contribute.

## License
Copyright 2021 © Jack Stone

*A11yoop* is made available under the [MIT License](https://github.com/Jackstone92/A11yoop/blob/develop/LICENSE).
