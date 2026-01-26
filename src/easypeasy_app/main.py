# SPDX-FileCopyrightText: 2021-2026 EasyPeasy contributors <https://github.com/easyscience>
# SPDX-License-Identifier: BSD-3-Clause

from pathlib import Path
import sys

import EasyApp

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

CURRENT_DIR = Path(__file__).parent  # path to qml components of the current project
EASYAPP_DIR = Path(EasyApp.__path__[0]).resolve().parent  # path the installed easyapp module


if __name__ == '__main__':
    # Create Qt application
    app = QGuiApplication(sys.argv)

    # Create the QML application engine
    engine = QQmlApplicationEngine()

    # Add the paths where QML searches for components
    engine.addImportPath(CURRENT_DIR)
    engine.addImportPath(EASYAPP_DIR)

    # Load the main QML component
    engine.load(CURRENT_DIR / 'main.qml')

    # Start the application event loop
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
