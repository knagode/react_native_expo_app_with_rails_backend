import { useState, useEffect, useRef } from 'react';
import { Alert, Text, View, Button, Platform } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

import * as Device from 'expo-device';
import * as Notifications from 'expo-notifications';
import { WebView } from 'react-native-webview';

Notifications.setNotificationHandler({
  handleNotification: async () => ({
    shouldShowAlert: true,
    shouldPlaySound: false,
    shouldSetBadge: false,
  }),
});

async function registerForPushNotificationsAsync() {
  let token;
  if (Device.isDevice) {
    const { status: existingStatus } = await Notifications.getPermissionsAsync();
    let finalStatus = existingStatus;
    if (existingStatus !== 'granted') {
      const { status } = await Notifications.requestPermissionsAsync();
      finalStatus = status;
    }
    if (finalStatus !== 'granted') {
      alert('Failed to get push token for push notification!');
      return;
    }
    token = (await Notifications.getExpoPushTokenAsync()).data;
    console.log(token);
  } else {
    alert('Must use physical device for Push Notifications');
  }

  if (Platform.OS === 'android') {
    Notifications.setNotificationChannelAsync('default', {
      name: 'default',
      importance: Notifications.AndroidImportance.MAX,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: '#FF231F7C',
    });
  }

  return token;
}

export default function App() {
  const [expoPushToken, setExpoPushToken] = useState('');
  const [authToken, setAuthToken] = useState('');
  const [notification, setNotification] = useState(false);
  const notificationListener = useRef();
  const responseListener = useRef();
  const [url, setUrl] = useState('');

  const handleSetExpoPushToken = (token) => {
    setExpoPushToken(token);
  }

  const setAuthTokenAsync = async (token) => {
    setUrl('') 
    
    try {
      await AsyncStorage.setItem('auth_token', token);
      setAuthToken(token)
    } catch (error) {
      console.log(error);
    }
  };

  const getAuthTokenAsync = async () => {
    try {
      const value = await AsyncStorage.getItem('auth_token')
      if(value !== null) {
        // value previously stored
        return value
      }
    } catch(e) {
      // error reading value
    }
  };

  const onMessage = (event, setExpoPushToken) => {
    const {
      nativeEvent: {data},
    } = event;
  
    let parsedData = JSON.parse(data)
    
    let type = parsedData.type

    if (type == 'alert') {
      alert(parsedData.message)
    } else if (type == 'askForPushNotificationPermission') {
      registerForPushNotificationsAsync().then(token => setExpoPushToken(token))
    } else if (type == 'setAuthToken') {
      setAuthTokenAsync(parsedData.token)
    } else {
      alert(JSON.stringify(parsedData));
    }
  };

  useEffect(() => {
    getAuthTokenAsync().then(token => setAuthToken(token))

    //registerForPushNotificationsAsync().then(token => setExpoPushToken(token));

    notificationListener.current = Notifications.addNotificationReceivedListener(notification => {
      setNotification(notification);
    });

    responseListener.current = Notifications.addNotificationResponseReceivedListener(response => {      
      let url = response.notification.request.content.data.url
      setUrl(url)      
    });

    return () => {
      Notifications.removeNotificationSubscription(notificationListener.current);
      Notifications.removeNotificationSubscription(responseListener.current);
    };
  }, []);

  // return (<View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}><Text>Hello, world!</Text></View>)

  return (
    <View style={{ flex: 1 }}>

      <WebView
        onMessage={(event) => onMessage(event, handleSetExpoPushToken)}
        originWhitelist={['*']}
        source={{uri: `http://expoapp.serveo.net/phone_app?expo_push_token=${expoPushToken}&auth_token=${authToken}&url=${encodeURIComponent(url)}`}} // Dimensions.get("window").width
        style={{flex: 1}}
        javaScriptEnabled={true}
      />
    </View>
  );
}