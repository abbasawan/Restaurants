## Description
The `Restaurants` app loads the restaurant data from local source and shows it in the list. The user can change how the list is sorted. User can also filter the list with the restaurant name.

## Architecture
- The app uses MVVM-C architecture. The Coordinators help setting up the UI cycle and navigation of the app.
- We also use Factories to easily create view controllers and view models, which helps with providing encapsulation
- Then there is `AppDIContainer` which is helpful in registering and resolving dependancies for different classes/modules
- The Data Loading module has 2 parts: 1) DataProvider and 2) Api Provider
    - Api Providers provide specific api request handling e.g. Restaurant List
    - The above Api Provider uses DataProvider, which is generic and will work with any kind of Api
- We leverage protocol oriented programming. It is also helpful in unit testing as well when we test using mocks

## Future Improvements
- Load RestaurantList data from both local and remote sources. One way to do this is by borrowing `Use Case` approach from `Clean Architecture`
- Improve UI/UX of filtering and searching
- Show loading indicator when loading list of restaurants
- Add UI tests
- Add linting tool e.g. SwiftLint

## Build Environment
- IDE: Xcode 11.6 (11E708)
- OS: macOS 10.15.6
- Language: Swift 5

## App info/Requirements
- iOS Deployment target: iOS 13.0+

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

# Contact developer
## Name: Abbas Awan
## Email: abbas.awan89@gmail.com
