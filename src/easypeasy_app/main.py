# SPDX-FileCopyrightText: 2021-2026 EasyPeasy contributors <https://github.com/easyscience>
# SPDX-License-Identifier: BSD-3-Clause

from pathlib import Path
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import qInstallMessageHandler

import EasyApplication
from EasyApplication.Logic.Logging import console

from Backends.real_backend import Backend

# path to qml components of the current project
CURRENT_DIR = Path(__file__).parent

# path to the installed easyapplication module
EA_DIR = Path(EasyApplication.__path__[0]).resolve().parent


if __name__ == '__main__':
    qInstallMessageHandler(console.qmlMessageHandler)
    console.debug('Custom Qt message handler defined')

    # This singleton object will be accessible in QML as follows:
    # import Backends 1.0 as Backends OR import Backends as Backends
    # property var activeBackend: Backends.PyBackend
    qmlRegisterSingletonType(Backend, 'Backends', 1, 0, 'PyBackend')
    console.debug('Backend class is registered as a singleton type for QML')

    app = QGuiApplication(sys.argv)
    console.debug(f'Qt Application created {app}')

    engine = QQmlApplicationEngine()
    console.debug(f'QML application engine created {engine}')

    engine.addImportPath(CURRENT_DIR)
    engine.addImportPath(EA_DIR)
    console.debug('Paths added where QML searches for components')

    engine.load(CURRENT_DIR / 'main.qml')
    console.debug('Main QML component loaded')

    console.debug('Application event loop is about to start')
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
