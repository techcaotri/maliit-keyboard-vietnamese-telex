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

KeyPad {
    anchors.fill: parent

    content: c1
    symbols: "languages/Keyboard_symbols.qml"

    Column {
        id: c1
        anchors.fill: parent
        spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            VCharKey { label: "ㅂ"; shifted: "ㅃ"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            VCharKey { label: "ㅈ"; shifted: "ㅉ"; extended: ["2"]; extendedShifted: ["2"] }
            VCharKey { label: "ㄷ"; shifted: "ㄸ"; extended: ["3"]; extendedShifted: ["3"] }
            VCharKey { label: "ㄱ"; shifted: "ㄲ"; extended: ["4"]; extendedShifted: ["4"] }
            VCharKey { label: "ㅅ"; shifted: "ㅆ"; extended: ["5"]; extendedShifted: ["5"] }
            VCharKey { label: "ㅛ"; shifted: "ㅛ"; extended: ["6"]; extendedShifted: ["6"] }
            VCharKey { label: "ㅕ"; shifted: "ㅕ"; extended: ["7"]; extendedShifted: ["7"] }
            VCharKey { label: "ㅑ"; shifted: "ㅑ"; extended: ["8"]; extendedShifted: ["8"] }
            VCharKey { label: "ㅐ"; shifted: "ㅒ"; extended: ["9"]; extendedShifted: ["9"] }
            VCharKey { label: "ㅔ"; shifted: "ㅖ"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            VCharKey { label: "ㅁ"; shifted: "ㅁ"; leftSide: true; }
            VCharKey { label: "ㄴ"; shifted: "ㄴ"; }
            VCharKey { label: "ㅇ"; shifted: "ㅇ"; }
            VCharKey { label: "ㄹ"; shifted: "ㄹ"; }
            VCharKey { label: "ㅎ"; shifted: "ㅎ"; }
            VCharKey { label: "ㅗ"; shifted: "ㅗ"; }
            VCharKey { label: "ㅓ"; shifted: "ㅓ"; }
            VCharKey { label: "ㅏ"; shifted: "ㅏ"; }
            VCharKey { label: "ㅣ"; shifted: "ㅣ"; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            VCharKey { label: "ㅋ"; shifted: "ㅋ"; }
            VCharKey { label: "ㅌ"; shifted: "ㅌ"; }
            VCharKey { label: "ㅊ"; shifted: "ㅊ"; }
            VCharKey { label: "ㅍ"; shifted: "ㅍ"; }
            VCharKey { label: "ㅠ"; shifted: "ㅠ"; }
            VCharKey { label: "ㅜ"; shifted: "ㅜ"; }
            VCharKey { label: "ㅡ"; shifted: "ㅡ"; }
            HBackspaceKey {}
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right

            height: panel.keyHeight + Device.row_margin;

            SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
            LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
            VCharKey        { id: slashKey; label: "/"; shifted: "/";     anchors.left: languageMenuButton.right; height: parent.height; }
            UrlKey         { id: urlKey; label: ".com"; extended: [".co.kr", ".or.kr", ".go.kr", ".ac.kr", ".kr"]; anchors.right: dotKey.left; height: parent.height; }
            VCharKey        { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"]; extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
