/**
 * Copyright (c) 2018-present, Daniel Rosa.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import { NativeModules, NativeEventEmitter } from 'react-native';

const NativeModule = NativeModules.BackgroundExecutionIOS;

const Emitter = new NativeEventEmitter(NativeModule);

export default class BackgroundExecutionIOS {
}
