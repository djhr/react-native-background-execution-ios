/**
 * Copyright (c) 2018-present, Daniel Rosa.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import { NativeModules } from 'react-native';

const NativeModule = NativeModules.BackgroundExecutionIOS;

export default class BackgroundExecutionIOS {

    static noop = () => {};


    // getters & setters

    static get backgroundTimeRemaining() {
        return NativeModule.backgroundTimeRemaining();
    }


    // methods

    static beginBackgroundTask(onExpiration, onError) {
        if (typeof(onExpiration) !== 'function') onExpiration = BackgroundExecutionIOS.noop;
        if (typeof(onError) !== 'function') onError = BackgroundExecutionIOS.noop;

        return NativeModule.beginBackgroundTask(onExpiration, onError);
    }

    static endBackgroundTask() {
        NativeModule.endBackgroundTask();
    }
}
