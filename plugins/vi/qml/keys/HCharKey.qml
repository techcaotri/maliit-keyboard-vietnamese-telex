/*
 * Copyright 2016 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4

import MaliitKeyboard 2.0

import keys 1.0
import "avim.js" as AVIM
import "avim_qml.js" as AVIMJS

CharKey {

    allowPreeditHandler: true
    preeditHandler: handler

    Item {
        id: handler

        //Each Hangul represents one syllable. The Hangul are composed of jamo.
        //It need to manipulate preedit until compose one syllable.

        function onKeyReleased(keyString, action) {
            // get previous preedit string
            var preedit = Keyboard.preedit;

            var event = {
              key: keyString.charCodeAt(0),
            };
            var vietTextArea = {
              selectionStart: Keyboard.cursorPosition,
              selectionEnd: Keyboard.cursorPosition,
              text: preedit,
            };
            console.debug("onKeyReleased: " + keyString + " " + action);
            console.debug("onKeyReleased: preedit=" + preedit);
            console.debug("onKeyReleased: event.key=" + event.key);
            console.debug("onKeyReleased: vietTextArea=" + JSON.stringify(vietTextArea));
            console.debug("onKeyReleased: preedit.length > 0");
            var result = AVIMJS.handleKeyPress(event, vietTextArea);
            if (result === false) {
              Keyboard.preedit = vietTextArea.text;
              Keyboard.cursorPosition = vietTextArea.cursorPosition;
              console.debug("onKeyReleased: result=false; Keyboard.preedit=" + Keyboard.preedit);
              console.debug("onKeyReleased: result=false; Keyboard.cursorPosition=" + Keyboard.cursorPosition);
              return;
            }             
            Keyboard.preedit = preedit + keyString;
            console.debug("onKeyReleased: result=true; Keyboard.preedit=" + Keyboard.preedit);
            if (!keyString.match(/^[0-9a-z]+$/)) {
              event_handler.onKeyReleased("", "commit");
            }
        }
    }
}
