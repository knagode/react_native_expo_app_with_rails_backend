# React Native app with Rails backend 

## Features

- React native app consist of single webview (similar like iframe) which opens specific page (Rails server)
- You can edit `views/push_notifications/show.html.erb` in order to change text & style of the app. File also contains all example actions (e.g. ask for push permissions - direcly in HTML)
- Send push notifications from backend to subscribed user
- Clickable notifications (click on notification can open specific page)
- setAuthToken helper in App.js which store user auth token in permanent storage in order to auto login user for the next time

## Structure

In the root of the repository is Rails. 
React Native app can be found in `/react_native_app` folder

# Setup

## Backend: 

`rails s` 

`ngrok http 3000`

## For react native app 

ngrok URL should be changed in react_native_app/App.js in order to point to your local ngrok instance:

`npx expo start`

Install `Expo go` application in AppStore (for iPhone users) 

More details: https://reactnative.dev/docs/environment-setup
