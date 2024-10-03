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

            VCharKey { label: "q"; shifted: "Q"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            VCharKey { label: "w"; shifted: "W"; extended: ["2"]; extendedShifted: ["2"] }
            VCharKey { label: "e"; shifted: "E"; extended: ["3", "è","é","ẻ","ẽ","ẹ","ê","ế","ề","ể","ễ","ệ", "€"]; extendedShifted: ["3", "È","É","Ẻ","Ẽ","Ẹ","Ê","Ế","Ề","Ể","Ễ","Ệ", "€"] }
            VCharKey { label: "r"; shifted: "R"; extended: ["4"]; extendedShifted: ["4"] }
            VCharKey { label: "t"; shifted: "T"; extended: ["5", "þ"]; extendedShifted: ["5", "Þ"] }
            VCharKey { label: "y"; shifted: "Y"; extended: ["6", "ý","ỳ","ỵ","ỷ","ỹ", "¥"]; extendedShifted: ["6", "Ý","Ỳ","Ỵ","Ỷ","Ỹ", "¥"] }
            VCharKey { label: "u"; shifted: "U"; extended: ["7", "ú","ù","ủ","ũ","ụ","ư","ứ","ừ","ử","ữ","ự"]; extendedShifted: ["7", "Ú","Ù","Ủ","Ũ","Ụ","Ư","Ứ","Ừ","Ử","Ữ","Ự"] }
            VCharKey { label: "i"; shifted: "I"; extended: ["8", "í","ì","ỉ","ĩ","ị"]; extendedShifted: ["8", "Í","Ì","Ỉ","Ĩ","Ị"] }
            VCharKey { label: "o"; shifted: "O"; extended: ["9", "ó","ò","ỏ","õ","ọ","ô","ồ","ố","ổ","ỗ","ộ","ơ","ớ","ờ","ở","ỡ","ợ"]; extendedShifted: ["9", "Ó","Ò","Ỏ","Õ","Ọ","Ô","Ồ","Ố","Ổ","Ỗ","Ộ","Ơ","Ớ","Ờ","Ở","Ỡ","Ợ"] }
            VCharKey { label: "p"; shifted: "P"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            VCharKey { label: "a"; shifted: "A"; extended: ["á","à","ả","ã","ạ","â","ấ","ầ","ẩ","ẫ","ậ","ă","ắ","ằ","ẳ","ẵ","ặ"]; extendedShifted: ["Á","À","Ả","Ã","Ạ","Â","Ấ","Ầ","Ẩ","Ẫ","Ậ","Ă","Ắ","Ằ","Ẳ","Ẵ","Ặ"]; leftSide: true; }
            VCharKey { label: "s"; shifted: "S"; }
            VCharKey { label: "d"; shifted: "D"; extended: ["đ"]; extendedShifted: ["Ð"] }
            VCharKey { label: "f"; shifted: "F"; }
            VCharKey { label: "g"; shifted: "G"; }
            VCharKey { label: "h"; shifted: "H"; }
            VCharKey { label: "j"; shifted: "J"; }
            VCharKey { label: "k"; shifted: "K"; }
            VCharKey { label: "l"; shifted: "L"; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            VCharKey { label: "z"; shifted: "Z"; }
            VCharKey { label: "x"; shifted: "X"; }
            VCharKey { label: "c"; shifted: "C"; }
            VCharKey { label: "v"; shifted: "V"; }
            VCharKey { label: "b"; shifted: "B"; }
            VCharKey { label: "n"; shifted: "N"; }
            VCharKey { label: "m"; shifted: "M"; }
            BackspaceKey {}
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right

            height: panel.keyHeight + Device.row_margin;

            SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
            LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
            VCharKey       { id: commaKey;    label: ","; shifted: ","; extended: ["'", "\"", ";", ":", "@", "&", "(", ")"]; extendedShifted: ["'", "\"", ";", ":", "@", "&", "(", ")"]; anchors.left: languageMenuButton.right; height: parent.height; }
            SpaceKey       { id: spaceKey;                               anchors.left: commaKey.right; anchors.right: dotKey.left; noMagnifier: true; height: parent.height; }
            VCharKey       { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"];  extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
