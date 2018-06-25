/**
 * Copyright (c) 2018-present, Daniel Rosa.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import { NativeModules } from 'react-native';

const NativeModule = NativeModules.BackgroundExecutionIOS;

export default class BackgroundExecutionIOS {

    // consts

    static BackgroundTaskInvalid = NativeModule.BackgroundTaskInvalid;


    // getters & setters

    static get backgroundTimeRemaining() {
        return NativeModule.backgroundTimeRemaining();
    }


    // methods

    static beginBackgroundTask(expirationHandler, name) {
        if (typeof(expirationHandler) !== 'function') throw new TypeError('expirationHandler');

        return NativeModule.beginBackgroundTask(expirationHandler, name);
    }

    static endBackgroundTask(identifier) {
        if (typeof(identifier) !== 'number') throw new TypeError('Invalid identifier');

        NativeModule.endBackgroundTask(identifier);
    }
}
