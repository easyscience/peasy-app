# Development Guide for QML Application

## Setting up Python and IDE

### Python environment and repository structure

Follow the instructions at https://github.com/easyscience/templates to
set up python environment with the required dependencies and to create
initial structure of the repository.

### Integrated development environment (IDE)

#### Qt Creator

Qt Creator is a prefered IDE for developing the GUI in QML. It allows to
run QML code in debug mode with breakpoints, preview changes to QML code
in live mode, has build in documentation for QML modules, has QML code
auto-completion, and more unique feature related to the QML code.

- Download Qt Online Installer from
  [qt.io](https://www.qt.io/download-qt-installer-oss). More info at
  [doc.qt.io](https://doc.qt.io/qt-6/qt-online-installation.html).
- Install Qt for desktop development using a custom installation that
  includes the following components:
  - Qt
  - [ ] Qt 6.y.z
    - [x] Desktop (**_macOS_**) or MSVC 2019 64-bit (**_Windows_**)
      - [ ] Additional Libraries
        - [x] Qt Charts
        - [x] Qt Shader Tools
  - [ ] Developer and Designer Tools
    - [x] Qt Creator x.y.z

## Copy example QML project

To get started quickly with QML application development, copy the
example QML project from the
[easyscience/peasy-app](https://github.com/easyscience/peasy-app)
repository. It can be found in the `src/easypeasy_app/` folder, namely:

- Backend/
- Gui/
- main.py
- main.qml

Place these files in the appropriate folders of your project structure
and make sure to adjust them to fit your project.

## Run using the QML Runtime

### Run via the Qt Creator IDE

- Run Qt Creator
- Open the qml project file from the src folder of your project, e.g.,
  `src/easypeasy_app.qmlproject`
- Click Run (Green play button)

### How to edit GUI elements in live mode

- In Qt Creator, select the `*.qml` file to be edited in live mode
- Click the `Design` button at the top of the left sidebar of
  `Qt Creator`
  - _Note: If this button is disabled, find and click `About plugins...`
    in the `Qt Creator` menu, scroll down to the `Qt Quick` section and
    enable `QmlDesigner`._
- In the `Design` window, click the `Show Live Preview` button in the
  top panel of the application (small play button in a circle).
  - _Note: Showing the entire `main.qml` application window in live mode
    works best when the open `main.qml` is moved to another monitor and
    does not overlap with the `Qt Creator` window_.
- When the desired GUI component appears, you can click the `Edit`
  button at the top of the left sidebar of `Qt Creator` to return to the
  source code of that qml component and still see it live in a separate
  window.

## Modify existing application pages

The example application contains a few pages that can be modified to fit
the needs of the project.

Some of the available GUI components are collected on the page called
`Toolbox` to make it easier to find and reuse them.

## Add new pages to the application

This section provides a detailed, step-by-step guide on how to add a new
page to the QML application. A "page" in this application consists of:

- **A navigation button** in the application bar (the top bar with
  workflow tabs)
- **A main content area** (the large central area displaying charts,
  text, images, etc.)
- **A sidebar** (the right panel with collapsible groups of controls and
  settings)

### Overview: What files need to be created or modified?

To add a new page called `NewPage`, you will need to:

1. **Modify existing files** (to register your new page in the
   application):
   - `src/easypeasy_app/Gui/ApplicationWindow.qml` — Add the navigation
     button and page loader
   - `src/easypeasy_app/Gui/Globals/References.qml` — Add a global
     reference variable for the button

2. **Create new files** (the actual content of your page):
   - `src/easypeasy_app/Gui/Pages/NewPage/Layout.qml` — Main page layout
   - `src/easypeasy_app/Gui/Pages/NewPage/MainArea/*.qml` — Content for
     the main view tabs
   - `src/easypeasy_app/Gui/Pages/NewPage/Sidebar/Basic/Layout.qml` —
     Sidebar layout
   - `src/easypeasy_app/Gui/Pages/NewPage/Sidebar/Basic/Groups/*.qml` —
     Individual sidebar groups

### Folder structure to create

Before starting, create the following folder structure inside
`src/easypeasy_app/Gui/Pages/`:

```
NewPage/
├── Layout.qml                    # Main page layout file
├── MainArea/                     # Folder for main content area components
│   ├── Tab1.qml                  # Content for the first tab
│   └── Tab2.qml                  # Content for the second tab (optional)
└── Sidebar/                      # Folder for sidebar components
    └── Basic/                    # Basic controls sidebar tab
        ├── Layout.qml            # Sidebar layout with group boxes
        └── Groups/               # Folder for individual group contents
            ├── Group1.qml        # Content for the first collapsible group
            └── Group2.qml        # Content for the second collapsible group (optional)
```

---

### Step 1: Add a navigation button to the Application Bar

**File to modify:** `src/easypeasy_app/Gui/ApplicationWindow.qml`

**What this does:** Adds a clickable tab button in the top application
bar that users will click to navigate to your new page.

**Location in file:** Find the `appBarCentralTabs.contentData` array
(around line 46) and add a new button entry.

**Code to add:**

```qml
        // NewPage page
        EaElements.AppBarTabButton {
            id: newPageButton
            enabled: false
            fontIcon: 'star'
            text: qsTr('New Page')
            ToolTip.text: qsTr('Description of what this page does')
            Component.onCompleted: {
                Globals.References.applicationWindow.appBarCentralTabs.newPageButton = newPageButton
            }
        },
        // NewPage page
```

**Explanation of each property:**

| Property                | Description                                                                                                                         | Example Values                              |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| `id`                    | Unique identifier for this button. Use camelCase with "Button" suffix.                                                              | `newPageButton`, `analysisButton`           |
| `enabled`               | Whether the button is enabled right after creation                                                                                  | `true` or `false`                           |
| `fontIcon`              | FontAwesome icon name (without 'fa-' prefix). See [fontawesome.com/icons](https://fontawesome.com/icons) for options.               | `'star'`, `'chart-line'`, `'cog'`, `'file'` |
| `text`                  | The label displayed on the button. Use `qsTr()` for translation support.                                                            | `qsTr('New Page')`                          |
| `ToolTip.text`          | Tooltip shown when user hovers over the button.                                                                                     | `qsTr('Description here')`                  |
| `Component.onCompleted` | Code that runs when the button is created. This registers the button in the global References so other pages can enable/disable it. | See code above                              |

---

### Step 2: Add a page loader to the Content Area

**File to modify:** `src/easypeasy_app/Gui/ApplicationWindow.qml` (same
file as Step 1)

**What this does:** Tells the application where to find the QML file
that defines your page content.

**Location in file:** Find the `contentArea` array (around line 125)
that contains a list of `Loader` elements.

**IMPORTANT:** The order of items in `contentArea` MUST match the order
of buttons in `appBarCentralTabs.contentData`. Button at index 0 loads
page at index 0, button at index 1 loads page at index 1, and so on.

**Code to add:**

```qml
        Loader { source: 'Pages/NewPage/Layout.qml' },
```

**Example of the complete contentArea array:**

```qml
    contentArea: [
        Loader { source: 'Pages/Home/Content.qml' },      // Index 0 - Home button
        Loader { source: 'Pages/Project/Layout.qml' },    // Index 1 - Project button
        Loader { source: 'Pages/NewPage/Layout.qml' },    // Index 2 - NewPage button (your new page!)
        Loader { source: 'Pages/Analysis/Layout.qml' },   // Index 3 - Analysis button
        Loader { source: 'Pages/Report/Layout.qml' },     // Index 4 - Summary button
        Loader { source: 'Pages/Toolbox/Layout.qml' }     // Index 5 - Toolbox button
    ]
```

---

### Step 3: Register the button in the global References

**File to modify:** `src/easypeasy_app/Gui/Globals/References.qml`

**What this does:** Creates a placeholder in the global references
dictionary where your button will be registered. This allows other pages
to programmatically enable/disable or click your page's button.

**Location in file:** Find the `applicationWindow` property and its
`appBarCentralTabs` object.

**Code to add:**

```qml
            'newPageButton': null,
```

**Example of the complete appBarCentralTabs object:**

```qml
    readonly property var applicationWindow: {
        'appBarCentralTabs': {
            'homeButton': null,
            'projectButton': null,
            'newPageButton': null,        // Your new button reference!
            'sampleModelButton': null,
            'analysisButton': null,
            'summaryButton': null,
        }
    }
```

**Why is this needed?** When another page wants to enable your page's
button and navigate to it (e.g., when the user clicks "Continue"), it
uses this reference:

```qml
// Example: Enable the NewPage button and switch to it
Globals.References.applicationWindow.appBarCentralTabs.newPageButton.enabled = true
Globals.References.applicationWindow.appBarCentralTabs.newPageButton.toggle()
```

---

### Step 4: Create the main page Layout file

**File to create:** `src/easypeasy_app/Gui/Pages/NewPage/Layout.qml`

**What this does:** Defines the overall structure of your page,
including:

- The main content area with its tabs
- The sidebar with its tabs
- The "Continue" button behavior

**Complete example code:**

```qml
import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.ContentPage {

    // MAIN VIEW AREA (left/center part of the page)
    // This is where charts, tables, images, or other main content appears
    mainView: EaComponents.MainContent {

        // Tab buttons at the top of the main view
        // Add one EaElements.TabButton for each tab you want
        tabs: [
            EaElements.TabButton { text: qsTr('Tab 1') },
            EaElements.TabButton { text: qsTr('Tab 2') }
        ]

        // Content for each tab (must match the order of tabs above)
        // Each Loader points to a QML file in the MainArea folder
        items: [
            Loader { source: 'MainArea/Tab1.qml' },
            Loader { source: 'MainArea/Tab2.qml' }
        ]
    }

    // SIDEBAR (right part of the page)
    // This is where controls, settings, and options appear
    sideBar: EaComponents.SideBar {

        // Tab buttons at the top of the sidebar
        // Common pattern: "Basic controls" for essential options, "Extra" for advanced
        tabs: [
            EaElements.TabButton { text: qsTr('Basic controls') }
        ]

        // Content for each sidebar tab
        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' }
        ]

        // CONTINUE BUTTON
        // This button appears at the bottom of the sidebar
        // Clicking it should enable the next page and navigate to it
        continueButton.text: qsTr('Continue')

        continueButton.onClicked: {
            // Debug message (optional, but helpful for troubleshooting)
            console.debug(`Clicking '${continueButton.text}' button ::: ${this}`)

            // Enable the next page's button (replace 'analysisButton' with your next page)
            Globals.References.applicationWindow.appBarCentralTabs.analysisButton.enabled = true

            // Switch to the next page (toggle() clicks the button)
            Globals.References.applicationWindow.appBarCentralTabs.analysisButton.toggle()
        }
    }

    // Lifecycle debug messages (optional, but helpful for troubleshooting)
    Component.onCompleted: console.debug(`NewPage loaded ::: ${this}`)
    Component.onDestruction: console.debug(`NewPage destroyed ::: ${this}`)

}
```

**Key concepts explained:**

| Element                    | Purpose                                                                         |
| -------------------------- | ------------------------------------------------------------------------------- |
| `EaComponents.ContentPage` | Base component that provides the standard page layout with mainView and sideBar |
| `mainView`                 | The large area on the left/center of the page                                   |
| `EaComponents.MainContent` | Container for the main view with tab support                                    |
| `tabs`                     | Array of tab buttons shown at the top of the content area                       |
| `items`                    | Array of content loaders, one for each tab (order must match `tabs`)            |
| `sideBar`                  | The control panel on the right side of the page                                 |
| `EaComponents.SideBar`     | Container for the sidebar with tab support                                      |
| `continueButton`           | Built-in button at the bottom of the sidebar for workflow navigation            |

---

### Step 5: Create MainArea content files

**Files to create:**
`src/easypeasy_app/Gui/Pages/NewPage/MainArea/Tab1.qml` (and Tab2.qml,
etc.)

**What this does:** Defines the actual content displayed in each tab of
the main view area.

**Example: A simple placeholder (Tab1.qml):**

```qml
import QtQuick

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements

import Gui.Globals as Globals


Rectangle {
    anchors.fill: parent
    color: EaStyle.Colors.chartBackground

    Text {
        anchors.centerIn: parent
        text: "Tab 1 Content - Replace with your actual content"
        color: EaStyle.Colors.themeForeground
        font.pixelSize: EaStyle.Sizes.fontPixelSize * 2
    }
}
```

**Example: A chart using QtGraphs (GraphsView.qml):**

```qml
// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtGraphs

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements

import Gui.Globals as Globals


GraphsView {
    anchors.fill: parent

    // Margins around the chart
    marginTop: EaStyle.Sizes.fontPixelSize * 2
    marginBottom: EaStyle.Sizes.fontPixelSize * 2
    marginLeft: EaStyle.Sizes.fontPixelSize
    marginRight: EaStyle.Sizes.fontPixelSize * 2

    // Enable zoom with mouse selection
    zoomAreaEnabled: true

    // Chart theme (colors, fonts, grid)
    theme: GraphsTheme {
        backgroundColor: EaStyle.Colors.chartBackground
        plotAreaBackgroundColor: EaStyle.Colors.chartBackground

        axisX.mainColor: EaStyle.Colors.chartGridLine
        axisX.mainWidth: 0

        axisY.mainColor: EaStyle.Colors.chartGridLine
        axisY.mainWidth: 0

        gridVisible: true
        grid.mainWidth: 1
        grid.subWidth: 0
        grid.mainColor: EaStyle.Colors.chartGridLine
        grid.subColor: EaStyle.Colors.chartMinorGridLine

        labelFont.family: EaStyle.Fonts.fontFamily
        labelFont.pixelSize: EaStyle.Sizes.fontPixelSize
        labelTextColor: EaStyle.Colors.chartLabels
    }

    // X-axis configuration
    axisX: ValueAxis {
        titleText: 'X Axis Label'
        min: 0
        max: 100
    }

    // Y-axis configuration
    axisY: ValueAxis {
        titleText: 'Y Axis Label'
        min: -2
        max: 2
    }

    // Data series (line chart)
    LineSeries {
        color: 'red'

        XYPoint { x: 0; y: -1 }
        XYPoint { x: 50; y: 1.5 }
        XYPoint { x: 100; y: -0.5 }
    }
}
```

---

### Step 6: Create the Sidebar Layout file

**File to create:**
`src/easypeasy_app/Gui/Pages/NewPage/Sidebar/Basic/Layout.qml`

**What this does:** Defines the structure of the sidebar, including
which collapsible group boxes appear and in what order.

**Complete example code:**

```qml
// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    // First group box (expanded by default)
    EaElements.GroupBox {
        title: qsTr('Group 1 Title')
        icon: 'rocket'
        collapsed: false  // Set to true to start collapsed

        Loader { source: 'Groups/Group1.qml' }
    }

    // Second group box (collapsed by default)
    EaElements.GroupBox {
        title: qsTr('Group 2 Title')
        icon: 'cog'
        collapsed: true

        Loader { source: 'Groups/Group2.qml' }
    }

    // Add more group boxes as needed...

}
```

**GroupBox properties explained:**

| Property    | Description                                      | Example Values                              |
| ----------- | ------------------------------------------------ | ------------------------------------------- |
| `title`     | The text shown in the group header               | `qsTr('Settings')`                          |
| `icon`      | FontAwesome icon name displayed before the title | `'rocket'`, `'cog'`, `'database'`, `'file'` |
| `collapsed` | Whether the group starts collapsed               | `true` or `false` (default: `true`)         |

---

### Step 7: Create Sidebar Group content files

**Files to create:**
`src/easypeasy_app/Gui/Pages/NewPage/Sidebar/Basic/Groups/Group1.qml`
(and Group2.qml, etc.)

**What this does:** Defines the actual controls and settings inside each
collapsible group box.

**Example: Empty group placeholder (Group1.qml):**

```qml
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
    // Add your controls here
    // See the Toolbox page for examples of available widgets
}
```

**Example: Group with buttons (GetStarted.qml style):**

```qml
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


Grid {
    columns: 2
    spacing: EaStyle.Sizes.fontPixelSize

    // Button 1
    EaElements.SideBarButton {
        fontIcon: 'plus-circle'
        text: qsTr('Action 1')

        onClicked: {
            console.debug(`Clicking '${text}' button ::: ${this}`)
            // Add your action here
        }
    }

    // Button 2
    EaElements.SideBarButton {
        fontIcon: 'upload'
        text: qsTr('Action 2')

        onClicked: {
            console.debug(`Clicking '${text}' button ::: ${this}`)
            // Add your action here
        }
    }
}
```

---

### Step 8: Verify your changes

After creating all the files, verify that your new page works correctly:

1. **Run the application** using Qt Creator (open
   `src/easypeasy_app.qmlproject` and click Run)

2. **Check for errors** in the Qt Creator console. Common issues
   include:
   - Typos in file paths
   - Missing imports
   - Mismatched array indices (buttons vs. content loaders)

3. **Test the workflow:**
   - Can you see your new button in the application bar?
   - Does clicking the button show your page?
   - Does the "Continue" button work and navigate to the next page?

### Tips and common patterns

#### Finding available GUI components

The **Toolbox page** in the application showcases many available GUI
components (buttons, text fields, sliders, charts, etc.). Browse this
page to find reusable components for your own pages.

#### Enabling pages in sequence (workflow)

If your application follows a workflow where users must complete pages
in order:

1. Set `enabled: false` on buttons for pages that should not be
   accessible initially
2. In the `continueButton.onClicked` handler of each page, enable the
   next page's button:

```qml
continueButton.onClicked: {
    Globals.References.applicationWindow.appBarCentralTabs.nextPageButton.enabled = true
    Globals.References.applicationWindow.appBarCentralTabs.nextPageButton.toggle()
}
```

#### Adding more sidebar tabs

To add additional sidebar tabs (e.g., "Basic controls" and "Advanced"):

```qml
sideBar: EaComponents.SideBar {
    tabs: [
        EaElements.TabButton { text: qsTr('Basic controls') },
        EaElements.TabButton { text: qsTr('Advanced') }
    ]

    items: [
        Loader { source: 'Sidebar/Basic/Layout.qml' },
        Loader { source: 'Sidebar/Advanced/Layout.qml' }
    ]

    // ... rest of sidebar configuration
}
```

#### Connecting to Python backend

To connect your QML page to Python backend logic, use the
`Globals.BackendWrapper` which provides access to the Python backend.
See the existing pages for examples of how to call backend methods and
bind to backend properties.
