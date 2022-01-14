# A11yoop - iOS Accessibility Tools 

![Run Tests](https://github.com/Jackstone92/CombineRx/workflows/Run%20Tests/badge.svg)
[![codecov](https://codecov.io/gh/Jackstone92/A11yoop/branch/develop/graph/badge.svg?token=5CUD7R531H)](https://codecov.io/gh/Jackstone92/A11yoop)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FJackstone92%2FA11yoop%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Jackstone92/A11yoop)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FJackstone92%2FA11yoop%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Jackstone92/A11yoop)
![SPM](https://img.shields.io/badge/SPM-compatible-ff59b4)
[![License](https://img.shields.io/badge/license-mit-brightgreen.svg)](https://en.wikipedia.org/wiki/MIT_License)

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
let status = monitor.isFeatureEnabled(.voiceOver)
```

When querying the status of an accessibility feature that is not currently being monitored, the resulting status will be `.notMonitored`.
```swift
let monitor = A11yoopMonitor(featureTypes: [.voiceOver]) // Only monitors voice over

let status = monitor.isFeatureEnabled(.boldText) // Query an accessibility feature that isn't monitored
/// - .notMonitored
```

Finally, if an accessibility feature that you are monitoring is not currently supported on a user's device, the status is returned as `.notSupported`.

### **Integrate with Analytics APIs**

In order to provide easy integration with third-party analytics SDK APIs, `A11yoopMonitor` provides a way to convert all currently monitored accessibility features into a params dictionary (of type `[String: Any]`), which is compatible with most analytics SDK APIs. This dictionary would contain key-value pairs mapping the feature type description to the current feature status description (eg. `["Bold Text": "Disabled"`]).

This conversion is possible by using the `asAnalyticsParams(prefixedBy:)` adapter, which transforms a sequence of `A11yFeature` into a `[String: Any]` representation.

A sample use-case would be including accessibility feature statuses in a tracking event:
```swift
func sendEvent() {

    let params = self.monitor.allFeatures.asAnalyticsParams()
    let eventName = "A11yoop features"

    // Firebase
    Analytics.logEvent(eventName, parameters: params)
}
```

In order to prevent conflicts, it is also possible to pass a prefix, which will be applied to all parameter keys (eg. resulting in "A11yoop Bold Text" with a prefix applied rather than "Bold Text" without).

Alternatively, it you want to represent monitored accessibility features in a completely different way, there are a number of computed properties available that can be used for convenience. These are as follows:
```swift
// `.enabledFeatures` provides only the monitored accessibility features that are currently enabled.
let formattedEnabledFeatures =  self.monitor.enabledFeatures.map(\.type.description).joined(separator: ",")

// `.disabledFeatures` provides only the monitored accessibility features that are currently disabled.
let formattedDisabledFeatures = self.monitor.disabledFeatures.map(\.type.description).joined(separator: ",")

// `.unsupportedFeatures` provides only the monitored accessibility features that are unsupported.
let formattedUnsupportedFeatures = self.monitor.unsupportedFeatures.map(\.type.description).joined(separator: ",")
```

This allows you to format them in whichever way you want (eg. as a comma-separated String).

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
