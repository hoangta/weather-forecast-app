# Weather Forecast Application

A coding assessment for Qualgo Technologies

## Requirements
* iOS 16.0+ 
* Xcode 15.x+
* Swift 5.x

## Getting Started
These instructions will get you a copy of the project up and running on your local machine

### Installing

Clone the repository.

```bash
$ git clone https://github.com/hoangta/weather-forecast-app.git
$ cd weather-forecast-app
$ xed .
```

Since the project use SPM to manage 3rd party dependencies, you may need to wait for some seconds before the project can be built and run.

## Dependencies
* ### [Realm](https://github.com/realm/realm-swift) 
    > Realm is a mobile database that runs directly inside phones, tablets or wearables. This repository holds the source code for the iOS, macOS, tvOS & watchOS versions of Realm Swift & Realm Objective-C.

## Architecture
* Every screen is modularized in to 1 subfolder from **Scenes** folder
* Every module contains 1 **main view**, 1 **view model** (optional)
* May contain **subviews/models** folder if any, prefer **folder-by-feature** to **folder-by-type**, i.e  *readability* > *reusable*
