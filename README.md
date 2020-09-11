## Description
The `Restaurants` app loads the restaurant data from local source and shows it in the list. The user can change how the list is sorted by selecting one of the sorting options available in the app. Some options sort the list in descending order e.g. `Best Match` while others sort in ascending order e.g. `Distance`. User can also filter the list with the restaurant name.

## Architecture
- The app uses `MVVM-C` architecture. The Coordinators help setting up the UI cycle and navigation of the app.
- We also use Factories to easily create view controllers and view models, which helps with providing encapsulation
- Then there is `AppDIContainer` which is helpful in registering and resolving dependancies for different classes/modules
- The Data Loading module has 2 parts: 1) `Data Provider` and 2) `Api Provider`
    - `Api Provider` provides specific api request handling e.g. Restaurant List
    - The above `Api Provider` uses `Data Provider`, which is generic and will work with any kind of Api
- We leverage protocol oriented programming. It is also helpful in unit testing as well when we test using mocks

## Future Improvements
- Load RestaurantList data from both local and remote sources. We will need to create two api providers and use both of them. One way to do this is by borrowing `Use Case` approach from `Clean Architecture`
- Improve UI/UX of filtering and searching
- I didn't use `Combine` because it requires app target to be `iOS 13` and above. Current app supports `iOS 11` and above.
Generally `Combine` comes especially handy with user interaction scenarios e.g. text input for search or picking sort option etc.
- We are using default table cell with one multiline label to show restaurant information (status and sort info) in two lines.
  We should create custom table cell for showing each piece of information in one label
- When sorting option picker is displayed, we should limit use interaction with search bar
- Move the sorting option picker outside of list view controller and create/destroy on-demand and don't keep in memory always
- Show loading indicator when loading list of restaurants
- Provide a way where user can request to reload data if data loading is failed for some reason
- Add animation to the sorting option picker display and dismiss
- Add UI tests
- Add linting tool e.g. SwiftLint

## Build Environment
- IDE: Xcode 11.6 (11E708)
- OS: macOS 10.15.6
- Language: Swift 5

## App info/Requirements
- iOS Deployment target: iOS 13.0+
- Supported OS versions: iOS 11.0+

## Source Control
Git: version 2.24.2 (Apple Git-127)

## Resources
1. App Icons
- Source: https://corporate.takeaway.com/media/media-kit/
- License: Takeaway.com

## Third party libraries
We use Swift Package manager as package/dependancy manager

1. Swinject
Swinject helps with dependancy injection.
- Link: https://github.com/Swinject/Swinject
- Version: 2.7.1
- License: MIT

2. SnapKit
We use SnapKit to help us build the UI in code with easy constraints.
- Link: https://github.com/SnapKit/SnapKit
- Version: 5.0.1
- License: MIT

# Contact developer
## Name: Abbas Awan
## Email: abbas.awan89@gmail.com
