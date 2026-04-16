# MangaTrack Mobile App
MangaTrack is a Flutter-based mobile application developed as an assessment project for AirdroiTech Company. The app is designed to help users discover, track, and manage their manga reading experience in a simple and intuitive way

### Documentation

* [UI/UX Wireframe](https://www.figma.com/design/swgucKosnoaj9kKQoba5nd/MangaTracker?node-id=0-1&t=p6LLQHzWMJqKNEps-1)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

The things you'll need in order to use the app and how to install them

* Flutter (Channel stable, 3.41.2)
* Android Studio (version 2024.1)
* Android toolchain - develop for Android devices (Android SDK version 34.0.0)
* Xcode - develop for iOS and macOS (Xcode 16.0)
* VS Code (version 1.116.0)

**Optional**

You can use below library to handle flutter version more efficienly.

* [FVM](https://fvm.app/)

### Installation

**Step 1:**

Clone this repo by using the link below:

```
git clone https://github.com/wasddsaw/manga_track_app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```zsh
% cd manga_track_app
% flutter pub get
% flutter run
```

### Auto-generate with Get CLI

To generate the project structure using Get CLI, run the following commands.

```zsh

other command

% dart pub global activate get_cli       

% flutter pub global activate get_cli
% get create page:home
% get create controller:dialogcontroller on home
% get create view:dialogview on home
```

## Dependencies

The project uses the following Flutter dependencies:

* [GetX](https://pub.dev/packages/get) for State Management
* [Dio](https://pub.dev/packages/dio) for HTTP Management

etc. can refer to pubspec.yaml file

## Built with

* Dart SDK version: 3.11.0 (stable) - The programming language used

## Versioning

We use [SemVer](https://semver.org/) for versioning

## Authors

* **Abd Qayyum** - *Initial work*

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.