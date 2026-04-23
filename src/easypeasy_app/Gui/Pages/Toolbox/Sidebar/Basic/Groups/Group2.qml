// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals

EaElements.GroupColumn {

    EaElements.Label {
        text: "EaElements.Label"
    }

    EaElements.TextInput {
        text: 'EaElements.TextInput'
    }

    EaElements.TextField {
        text: 'EaElements.TextField'
    }

    EaElements.TextInput {
        warned: true
        text: 'EaElements.TextInput (warned)'
    }

    EaElements.TextField {
        warned: true
        text: 'EaElements.TextField (warned)'
    }

}
