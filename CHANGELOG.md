# Changelog

## Version 0.10.0
- TBD

## Version 0.9.1
- Add url parameters for DELETE requests
- Bump deployment target to iOS 9

## Version 0.9.0
- Remove feature to queue duplicated requests and send them to server only once
- Fix lint warnings and minor refactoring

## Version 0.8.6
- Fix bug with `Equatable` behavior of `URLRequest` (it doesn't take `httpBody` into account)
- Potential crash fix

## Version 0.8.5
- Add CURRENT_PROJECT_VERSION

## Version 0.8.4
- Rename `URL.mocked` -> `URL.mock` in URL+Helpers
- Rename `toDictionary` -> `jsonDictionary` in Data+Helpers
- Rename `toArray` -> `jsonArray` in Data+Helpers

## Version 0.8.3
- Add possibility to use mocked `APIResponse` for any `APIRequest`
- Add `httpBody` to `URLRequest` helper for `fullDescription`

## Version 0.8.2
- Add `PATCH` request method

## Version 0.8.1
- Add body to `APIRequest`
- Minor cleanup and refactoring

## Version 0.8.0
- Migrated to Swift 5 with Xcode 10.2 (10E125)

## Version 0.7.5
- Bumped Swift language version to 4.2 with Xcode 10

## Version 0.7.4
- Bug fix

## Version 0.7.3
- Minor improvements

## Version 0.7.2
- Migrated to Swift 4.1 with Xcode 9.3 (9E145)

## Version 0.7.1
- Minor improvements and refactoring

## Version 0.7.0
- Renamed Backend -> APIClient and BackendRequest -> APIRequest
- Added Result<T> type
- Major improvements and refactoring

## Version 0.6.3
- Minor improvements and refactoring

## Version 0.6.2
- Integrated Fetcher logic directly into Network (removed Fetcher class)
- Removed Downloader instance from Network class
- Added Equatable conformance to FetchResult
- Added more unit tests
- Other improvements and refactoring

## Version 0.6.1
- Added detailed error description
- Added short description for URLRequest and HTTPURLResponse
- Other improvements and refactoring

## Version 0.6.0
- Fixed logic for preventing of sending duplicated requests
- Implemented logic for performing all work in background queue
- Refactored BackendAPI logic into Backend
- Other improvements and refactoring

## Version 0.5.0
- Removed failable completion alternatives
- Removed custom caching logic
- Added URLRequest.CachePolicy to BackendRequest
- Prevented sending duplicated requests
- Other improvements and refactoring

## Version 0.4.0
- Added failable completion alternatives to Network.Completion
- Added optional alternatives of serialized data in Fetcher.Result
- Added HTTPURLResponse+Helper
- Added more unit tests
- Other improvements and refactoring

## Version 0.3.5
- Possibility to provide custom completion queue when sending network request
- Minor other fixes

## Version 0.3.4
- Added Reachability

## Version 0.3.3
- Added logic to intercept any request / response with NetworkDelegate
- Improved Backend logic (added BackendAPI protocol)
- Other improvements and refactoring

## Version 0.3.2
- Created initial version of Backend and BackendRequest protocols
- Improvements and refactoring

## Version 0.3.1
- Improvements of delegates logic
- Minor fixes and refactoring
- Added sample Playground

## Version 0.3.0
- Major refactoring of Caching logic
- Major refactoring or request / response logic
- Other improvements and refactoring

## Version 0.2.9
- Refactored Parser into Data+Serialization extension
- Improvements and bug fixes

## Version 0.2.8
- Added more helpers to URLRequest extension
- Added Failable alternatives to Completion
- Improvements and refactoring
- Added more unit tests

## Version 0.2.7
- Added initial NetworkDelegate
- Added URL+ExpressibleByStringLiteral helper
- Improvements and refactoring

## Version 0.2.6
- Added initial facade API to Network
- Added convenience API to URLRequest
- Improvements and refactoring

## Version 0.2.5
- Downloader improvements

## Version 0.2.4
- Improvements and refactoring
- Added more unit tests

## Version 0.2.3
- Improvements and refactoring
- Added more unit tests

## Version 0.2.2
- Improvements and refactoring
- Added more unit tests

## Version 0.2.1
- Renamed module (Network -> AENetwork)
- Major refactoring

## Version 0.2.0
- Migrated to Swift 4 with Xcode 9.1

## Version 0.1.9
- Added support for Carthage

## Version 0.1.8
- Moved all code into single source file
- Minor refactoring

## Version 0.1.7
- Added badRequest case in AENetworkError

## Version 0.1.6
- Minor refactoring

## Version 0.1.5
- Minor improvements and refactoring

## Version 0.1.4
- Added URL extension with convenience methods for using query parameters

## Version 0.1.3
- Minor improvements and refactoring

## Version 0.1.2
- Added public initializer
- Renamed typealiases and minor refactoring

## Version 0.1.1
- Minor improvements and refactoring
- Added initial unit test

## Version 0.1.0
- Initial version
