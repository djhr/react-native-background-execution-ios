# react-native-background-execution-ios
React Native Background Execution Management for iOS

## Installation
`yarn add react-native-background-execution-ios`

### Automatic linking
`react-native link react-native-background-execution-ios`

### Manual linking
1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-background-execution-ios` ➜ `ios` and add `RCTBackgroundExecutionIOS.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRCTBackgroundExecutionIOS.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`

## Usage

```js
import BackgroundExecutionIOS from 'react-native-background-execution-ios';


const onExpiration = (remainingTime) => console.info(`Background execution time will end in ${remainingTime}s`);
const onError = (err) => console.warn(err);

BackgroundExecutionIOS.beginBackgroundTask(onExpiration, onError);
//...
const remainingTime = await BackgroundExecutionIOS.backgroundTimeRemaining;
console.log(`Remaining background time: ${remainingTime}s`);
//...
BackgroundExecutionIOS.endBackgroundTask();
```

## API

### Properties

Property getters return a promise resolved with the property value.

| Property | Type | Notes
|---|---|---|
| [`backgroundTimeRemaining`](https://developer.apple.com/documentation/uikit/uiapplication/1623029-backgroundtimeremaining) | `double` | `readonly`


### Methods

| Method | Arguments | Return | Notes
|---|---|---|---|
| [`beginBackgroundTask`](https://developer.apple.com/documentation/uikit/uiapplication/1623031-beginbackgroundtaskwithexpiratio) | `onExpiration: function`, `onError: function` | `void` |
| [`endBackgroundTask`](https://developer.apple.com/documentation/uikit/uiapplication/1622970-endbackgroundtask) | | `void` | automatically called in case of expiration
