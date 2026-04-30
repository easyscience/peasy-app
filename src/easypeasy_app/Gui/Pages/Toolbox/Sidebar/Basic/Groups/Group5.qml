// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApplication.Gui.Globals as EaGlobals
import EasyApplication.Gui.Style as EaStyle
import EasyApplication.Gui.Elements as EaElements
import EasyApplication.Gui.Components as EaComponents
import EasyApplication.Gui.Logic as EaLogic

import Gui.Globals as Globals

EaElements.GroupColumn {

    // table
    EaComponents.TableView {
        id: tableWithHeader

        maxRowCountShow: 4

        // model
        model: ListModel {
            ListElement { name: "Alice"; age: 30; address: "123 Main St" }
            ListElement { name: "Bob"; age: 5; address: "456 Elm St" }
            ListElement { name: "Charlie"; age: 35; address: "789 Oak St" }
            ListElement { name: "Diana"; age: 28; address: "321 Pine St" }
            ListElement { name: "Eve"; age: 22; address: "654 Maple St" }
            ListElement { name: "Frank"; age: 40; address: "987 Cedar St" }
            ListElement { name: "Grace"; age: 27; address: "246 Birch St" }
            ListElement { name: "Heidi"; age: 32; address: "135 Spruce St" }
        }
        // model

        // header delegate
        header: EaComponents.TableViewHeader {

            // No.
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 2.5
            }

            // Name
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 4.5
                horizontalAlignment: Text.AlignLeft
                text: qsTr("name")
            }

            // Age
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
                color: EaStyle.Colors.themeForegroundMinor
                text: qsTr("age")
            }

            // Address
             EaComponents.TableViewLabel {
                flexibleWidth: true
                horizontalAlignment: Text.AlignLeft
                color: EaStyle.Colors.themeForegroundMinor
                text: qsTr("address")
            }

            // Remove button
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.tableRowHeight
            }
        }
        // header delegate

        // row delegate
        delegate: EaComponents.TableViewDelegate {

            // No.
            EaComponents.TableViewLabel {
                text: index + 1
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Name
            EaComponents.TableViewTextInput {
                text: model.name

                onAccepted: {
                    model.name = text
                    console.log("Name updated to: " + text)
                }
            }

            // Age
            EaComponents.TableViewLabel {
                text: model.age
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Address
             EaComponents.TableViewLabel {
                text: model.address
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Remove button
            EaComponents.TableViewButton {
                fontIcon: "minus-circle"
                ToolTip.text: qsTr("Remove this item")

                onClicked: {
                    console.log("This will remove item with index: " + index)
                }
            }

        }
        // row delegate

    }
    // table


    // table
    EaComponents.TableView {
        id: tableWithoutHeader

        maxRowCountShow: 3
        showHeader: false

        // model
        model: tableWithHeader.model
        // model

        // header delegate
        header: EaComponents.TableViewHeader {

            // No.
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 2.5
            }

            // Name
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 4.5
                horizontalAlignment: Text.AlignLeft
                text: qsTr("name")
            }

            // Age
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 4.5
                horizontalAlignment: Text.AlignHCenter
                color: EaStyle.Colors.themeForegroundMinor
                text: qsTr("age")
            }

            // Address
             EaComponents.TableViewLabel {
                flexibleWidth: true
                horizontalAlignment: Text.AlignLeft
                color: EaStyle.Colors.themeForegroundMinor
                text: qsTr("address")
            }

            // Remove button
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.tableRowHeight
            }
        }
        // header delegate

        // row delegate
        delegate: EaComponents.TableViewDelegate {

            // No.
            EaComponents.TableViewLabel {
                text: index + 1
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Name
            EaComponents.TableViewTextInput {
                text: model.name

                onAccepted: {
                    model.name = text
                    console.log("Name updated to: " + text)
                }
            }

            // Age
            EaComponents.TableViewLabel {
                text: model.age
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Address
             EaComponents.TableViewLabel {
                text: model.address
                color: EaStyle.Colors.themeForegroundMinor
            }

            // Remove button
            EaComponents.TableViewButton {
                fontIcon: "minus-circle"
                ToolTip.text: qsTr("Remove this item")

                onClicked: {
                    console.log("This will remove item with index: " + index)
                }
            }

        }
        // row delegate

    }
    // table
}
