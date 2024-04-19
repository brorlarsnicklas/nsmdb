App for searching movies or series that you want to give a rating.

### Requirements
- Xcode
- iOS 17.0 (minimum deployment target is iOS 17.0)
- iOS simulator or device, e.g. iphone 15 pro

## Installation
1. Clone the repository
2. Open the project in Xcode
3. Open the NetworkManager in nsmdb, then managers, and update the api key (see email), add the superSecret as a string instead of "ADD YOUR KEY"
```swift
    private let superSecret = "ADD YOUR KEY"
```
3. Build and run the project on a simulator or physical decvice.
	1. Make sure you have a simulator installed.

## Usage
Search for your favorite movie or series by entering a search text of the title.

Tap a result of your choice to see more information about it.

Tap "Rate this” and give it a rating of your choice.

Adding a rating will store the rating in memory of your device so that you can review your previous ratings by tapping the "Ratings" tab in the navigation menu.

In the ratings list, you can remove ratings with a simple left swipe.

## Delimitations
Because the task was limited, I chose to save the API key as a variable in the code. Of course, the API should be called through a backend where we handle requests with some form of authentication, such as JWT tokens. This is to avoid leaking secrets because of reverse engineering of the app.

The app was created using newer and relevant technologies, which means that older devices are not supported in this case.

## Potential improvements
Search everytime we change the input, with some sort of delay.
Add animations, testing and more accessibility focus. 
Extended error handling and nicer response than standard alerts. 
