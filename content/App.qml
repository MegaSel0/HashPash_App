// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Controls.Universal
import QtQuick.Controls.Material


ApplicationWindow {
    id: root

    width: 900
    height: 600
    minimumHeight: 400
    maximumHeight: 600
    minimumWidth: 400
    maximumWidth: 900
    visible: true
    property var builtInStyles

    HashPage{
        id:hoemPage
    }
}

