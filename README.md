# React Native app with Rails backend for authentication (via Devise) and sending Push notifications

## Features

- React native app consist of single webview (aka iframe) which opens specific page on Rails server
- Rails uses Devise in order to authenticate user
- App takes care for passing authentication and push notification token between React client and Rails backened (user will stay logged in after reopening the app)
- Simple way to ask for push notification permission via Rails->JS (no need to make changes in React when you want to change UX)
- Send push notifications from backend to subscribed user
- Clickable notifications (click on notification can open specific page)

## Structure

In the root of the repository is Rail code. 
React Native app can be found in `/react_native_app` folder

# Setup

## Backend: 

`rails s` 

`ssh -R expoapp:80:localhost:3000 serveo.net` or `ngrok http 3000` (change paths in App.js if you use another proxy: e.g. ngrok)

## For react native app 

ngrok URL should be changed in react_native_app/App.js in order to point to your local ngrok instance:

`cd react_native_app`
`npx expo start`

Install `Expo go` application in AppStore (for iPhone users) 

More details: https://reactnative.dev/docs/environment-setup
