![banner image](assets/.README_images/banner.png)

## Table of Contents

* [About](#about)
* [Demo](#demo)
* [Built-With](#built-with)
* [Documentation](#documentation)
* [Project Status](#project-status)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Setup](#setup)
* [Usage](#usage)

## About

This is the MyClinic Flutter Apps repo.
> **For general info regarding MyClinic, please refer to the project [specification page](https://github.com/DMouayad/DMouayad/blob/main/MyClinic_README.md).**


## Demo

#### Screenshots

*(will be added soon)*

#### Download

To preview the app, you can download it for your device OS:

*(will be added soon)*

## Built-With

* **[Flutter Framework](https://flutter.dev/)**
    >For help to get started with Flutter development, view the [online documentation](https://docs.flutter.dev/).

* **State Management**: [BloC](https://bloclibrary.dev/).
* **Real-time functionalities(Notifications-Events)**: WebSockets using [Socket.IO Client package](https://pub.dev/packages/socket_io_client).

## Documentation

#### System Design & Architecture

* The design of MyClinic app is a custom combination of *Clean Architecture* and *DDD*.

#### Features

* Multi-Language Support

  |   Status   |  Language |
  |:---------:|:---------:|
  | ✅        | Arabic    |
  | ✅        | English   |
  
* Multi-Platform support:

  | Platform | Supported | Adaptive UI/UX Implemented |
  |:--------:|:---------:|:--------------------------:|
  | Android  |     ✔     |             ✔             |
  |   IOS    |     ✔     |             ❌            |
  | Windows  |     ✔     |             ✔             |
  |  MacOS   |     ✔     |             ❌            |

****

#### Diagrams

*(will be added soon)*

## Project Status

* This project is a **work-in-progress**.
* Refer to the [Trello's board]() for active development work.

## Getting Started

#### Prerequisites

* If you are new to Flutter, start with [installation instruction](https://flutter.io/docs/get-started/install).

* **Flutter v3.7** & **Dart v2.19**.

* For running on *Windows*, please read the following [requirements](https://docs.flutter.dev/development/platform-integration/desktop#requirements).

* Run the command `flutter doctor -v` in a terminal and make sure no issues are present.

#### Setup

**Step 1:** download or clone this repo.

**Step 2:** open a terminal window and run these commands:

*  `cd path_of_project_folder`
*  `flutter pub get`

#### Usage

You can run the app using:

**Option 1**

* Open the project in an IDE.
* Select the device you wish to run the app on.
* Run `lib\main.dart`.

**Option 2:**

* Open a terminal window in the project directory.
* Execute one of the commands:

    ```dart
    flutter run -d windows
    flutter run -d macos
    flutter run -d android
    flutter run -d ios
    ```

**Additional Info**

You can also specify the build mode of the app:

* Using an IDE: most IDEs support multiple build\run modes. check your IDE's *Run Settings & Configuration*.

* Using the terminal:

  * `-d` or `--debug`: to run the debug-version.
  * `-r` or `--release`: to run the deployment(release) version.

## License

MyClinic is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
