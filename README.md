# Music_Player_App

## Description
This is a music player app that allows you to play music from your phone.
that recommends music randomly using spotify api.

## Services Used
* Spotify API  https://developer.spotify.com/documentation/web-api/
that I implemented using `Dio` package, by made a class named `SpotifyService` that contains all the requests that I need to use in the app.

## State Management
I used `GetX` package for state management, by using `GetxController` and `GetxState` to manage the state of the app.
and I used `GetMaterialApp` to use `getPages` as a routing system to navigate between screens.

## Packages Used
* `Dio` for http requests
* `GetX` for state management
* `audioplayers` for playing music
* `flutter_svg` for svg images
* `google_fonts` for fonts

## Screenshots
1. Home Screen
2. Now Playing Screen
3. animated Bottom Navigation Bar