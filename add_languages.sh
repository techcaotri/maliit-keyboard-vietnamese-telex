#!/bin/env bash

echo "Adding the following languages to the keyboard; en, vi, ko, zh-hant, zh-hans"
gsettings set org.maliit.keyboard.maliit enabled-languages "['en', 'vi', 'ko', 'zh-hant', 'zh-hans']"
