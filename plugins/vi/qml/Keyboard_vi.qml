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

import "keys/"
import keys 1.0
import "keys/avim.js" as AVIM
import "keys/avim_qml.js" as AVIMJS

KeyPad {
    anchors.fill: parent

    content: c1
    symbols: "languages/Keyboard_symbols.qml"

    property int inputMethod: 1 // 1: TELEX, 2: VNI, 3: VIQR

    Component.onCompleted:
    {
        AVIMJS.initAVIM();
        AVIMJS.setInputMethod(inputMethod);
        console.log("AVIM initialized with method:", inputMethod);
    }

    Column {
        id: c1
        anchors.fill: parent
        spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            HCharKey { label: "q"; shifted: "Q"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            HCharKey { label: "w"; shifted: "W"; extended: ["2"]; extendedShifted: ["2"] }
            HCharKey { label: "e"; shifted: "E"; extended: ["3", "è","é","ẻ","ẽ","ẹ","ê","ế","ề","ể","ễ","ệ", "€"]; extendedShifted: ["3", "È","É","Ẻ","Ẽ","Ẹ","Ê","Ế","Ề","Ể","Ễ","Ệ", "€"] }
            HCharKey { label: "r"; shifted: "R"; extended: ["4"]; extendedShifted: ["4"] }
            HCharKey { label: "t"; shifted: "T"; extended: ["5", "þ"]; extendedShifted: ["5", "Þ"] }
            HCharKey { label: "y"; shifted: "Y"; extended: ["6", "ý","ỳ","ỵ","ỷ","ỹ", "¥"]; extendedShifted: ["6", "Ý","Ỳ","Ỵ","Ỷ","Ỹ", "¥"] }
            HCharKey { label: "u"; shifted: "U"; extended: ["7", "ú","ù","ủ","ũ","ụ","ư","ứ","ừ","ử","ữ","ự"]; extendedShifted: ["7", "Ú","Ù","Ủ","Ũ","Ụ","Ư","Ứ","Ừ","Ử","Ữ","Ự"] }
            HCharKey { label: "i"; shifted: "I"; extended: ["8", "í","ì","ỉ","ĩ","ị"]; extendedShifted: ["8", "Í","Ì","Ỉ","Ĩ","Ị"] }
            HCharKey { label: "o"; shifted: "O"; extended: ["9", "ó","ò","ỏ","õ","ọ","ô","ồ","ố","ổ","ỗ","ộ","ơ","ớ","ờ","ở","ỡ","ợ"]; extendedShifted: ["9", "Ó","Ò","Ỏ","Õ","Ọ","Ô","Ồ","Ố","Ổ","Ỗ","Ộ","Ơ","Ớ","Ờ","Ở","Ỡ","Ợ"] }
            HCharKey { label: "p"; shifted: "P"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            HCharKey { label: "a"; shifted: "A"; extended: ["á","à","ả","ã","ạ","â","ấ","ầ","ẩ","ẫ","ậ","ă","ắ","ằ","ẳ","ẵ","ặ"]; extendedShifted: ["Á","À","Ả","Ã","Ạ","Â","Ấ","Ầ","Ẩ","Ẫ","Ậ","Ă","Ắ","Ằ","Ẳ","Ẵ","Ặ"]; leftSide: true; }
            HCharKey { label: "s"; shifted: "S"; }
            HCharKey { label: "d"; shifted: "D"; extended: ["đ"]; extendedShifted: ["Ð"] }
            HCharKey { label: "f"; shifted: "F"; }
            HCharKey { label: "g"; shifted: "G"; }
            HCharKey { label: "h"; shifted: "H"; }
            HCharKey { label: "j"; shifted: "J"; }
            HCharKey { label: "k"; shifted: "K"; }
            HCharKey { label: "l"; shifted: "L"; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            HCharKey { label: "z"; shifted: "Z"; }
            HCharKey { label: "x"; shifted: "X"; }
            HCharKey { label: "c"; shifted: "C"; }
            HCharKey { label: "v"; shifted: "V"; }
            HCharKey { label: "b"; shifted: "B"; }
            HCharKey { label: "n"; shifted: "N"; }
            HCharKey { label: "m"; shifted: "M"; }
            HBackspaceKey {}
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right

            height: panel.keyHeight + Device.row_margin;

            SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
            LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
            HCharKey       { id: commaKey;    label: ","; shifted: ","; extended: ["'", "\"", ";", ":", "@", "&", "(", ")"]; extendedShifted: ["'", "\"", ";", ":", "@", "&", "(", ")"]; anchors.left: languageMenuButton.right; height: parent.height; }
            SpaceKey       { id: spaceKey;                               anchors.left: commaKey.right; anchors.right: dotKey.left; noMagnifier: true; height: parent.height; }
            HCharKey       { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"];  extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
