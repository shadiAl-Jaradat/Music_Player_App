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
1. Home Screen - All Songs 

![HomeScreenShot](https://github.com/shadiAl-Jaradat/Music_Player_App/assets/94618324/5f97052b-8ca7-45a5-bea6-3a64d66fc5e4)


2. Now Playing Song Screen

![iPhone 14 Pro Mockup Light](https://github.com/shadiAl-Jaradat/Music_Player_App/assets/94618324/2fc9cb32-da0a-4370-88fa-e730ba2b6d2e)

3. Animated Bottom Navigation Bar

![AnimatedNavigationBar2](https://github.com/shadiAl-Jaradat/Music_Player_App/assets/94618324/ea074522-b93f-4963-a2a6-63d87a456f37)

## Coming Soon Screens
* Search 
* Podcast
* Settings
