pragma Singleton

import QtQuick

QtObject {

    readonly property var about: {
        'name': 'EasyPeasy',
        'namePrefix': 'Easy',
        'nameSuffix': 'Peasy',
        'namePrefixForLogo': 'easy',
        'nameSuffixForLogo': 'peasy',
        'homePageUrl': 'https://github.com/easyscience/peasy',
        'issuesUrl': 'https://github.com/easyscience/peasy/issues',
        'licenseUrl': 'https://github.com/easyscience/peasy/LICENCE',
        'dependenciesUrl': 'https://github.com/easyscience/peasy/DEPENDENCIES.md',
        'version': '0.1.0',
        'icon': Qt.resolvedUrl('../Resources/Logos/App.png'),
        'date': new Date().toISOString().slice(0,10),
        'developerYearsFrom': '2021',
        'developerYearsTo': '2026',
        'description': '**EasyPeasy** is a scientific software for performing imaginary calculations based on a theoretical model and refining its parameters against experimental data',
        'developerIcons': [
            {
                'url': 'https://ess.eu',
                'icon': Qt.resolvedUrl('../Resources/Logos/ESS.png'),
                'heightScale': 3.0
            }
        ]
    }

}

