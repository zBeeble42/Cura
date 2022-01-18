// Copyright (c) 2021 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import UM 1.1 as UM

QtObject
{
    property Component print_setup_header_button: Component
    {
        ButtonStyle
        {
            background: Rectangle
            {
                color:
                {
                    if(control.enabled)
                    {
                        if(control.valueError)
                        {
                            return UM.Theme.getColor("setting_validation_error_background");
                        }
                        else if(control.valueWarning)
                        {
                            return UM.Theme.getColor("setting_validation_warning_background");
                        }
                        else
                        {
                            return UM.Theme.getColor("setting_control");
                        }
                    }
                    else
                    {
                        return UM.Theme.getColor("setting_control_disabled");
                    }
                }

                radius: UM.Theme.getSize("setting_control_radius").width
                border.width: UM.Theme.getSize("default_lining").width
                border.color:
                {
                    if (control.enabled)
                    {
                        if (control.valueError)
                        {
                            return UM.Theme.getColor("setting_validation_error");
                        }
                        else if (control.valueWarning)
                        {
                            return UM.Theme.getColor("setting_validation_warning");
                        }
                        else if (control.hovered)
                        {
                            return UM.Theme.getColor("setting_control_border_highlight");
                        }
                        else
                        {
                            return UM.Theme.getColor("setting_control_border");
                        }
                    }
                    else
                    {
                        return UM.Theme.getColor("setting_control_disabled_border");
                    }
                }
                UM.RecolorImage
                {
                    id: downArrow
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: UM.Theme.getSize("default_margin").width
                    width: UM.Theme.getSize("standard_arrow").width
                    height: UM.Theme.getSize("standard_arrow").height
                    sourceSize.height: width
                    color: control.enabled ? UM.Theme.getColor("setting_control_button") : UM.Theme.getColor("setting_category_disabled_text")
                    source: UM.Theme.getIcon("ChevronSingleDown")
                }
                Label
                {
                    id: printSetupComboBoxLabel
                    color: control.enabled ? UM.Theme.getColor("setting_control_text") : UM.Theme.getColor("setting_control_disabled_text")
                    text: control.text;
                    elide: Text.ElideRight;
                    anchors.left: parent.left;
                    anchors.leftMargin: UM.Theme.getSize("setting_unit_margin").width
                    anchors.right: downArrow.left;
                    anchors.rightMargin: control.rightMargin;
                    anchors.verticalCenter: parent.verticalCenter;
                    font: UM.Theme.getFont("default")
                }
            }
            label: Label{}
        }
    }

    property Component tool_button: Component
    {
        ButtonStyle
        {
            background: Item
            {
                implicitWidth: UM.Theme.getSize("button").width
                implicitHeight: UM.Theme.getSize("button").height

                UM.PointingRectangle
                {
                    id: button_tooltip

                    anchors.left: parent.right
                    anchors.leftMargin: UM.Theme.getSize("button_tooltip_arrow").width * 2
                    anchors.verticalCenter: parent.verticalCenter

                    target: Qt.point(parent.x, y + Math.round(height/2))
                    arrowSize: UM.Theme.getSize("button_tooltip_arrow").width
                    color: UM.Theme.getColor("button_tooltip")
                    opacity: control.hovered ? 1.0 : 0.0;
                    visible: control.text != ""

                    width: control.hovered ? button_tip.width + UM.Theme.getSize("button_tooltip").width : 0
                    height: UM.Theme.getSize("button_tooltip").height

                    Behavior on width { NumberAnimation { duration: 100; } }
                    Behavior on opacity { NumberAnimation { duration: 100; } }

                    Label
                    {
                        id: button_tip

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        text: control.text
                        font: UM.Theme.getFont("default")
                        color: UM.Theme.getColor("tooltip_text")
                    }
                }

                Rectangle
                {
                    id: buttonFace

                    anchors.fill: parent
                    property bool down: control.pressed || (control.checkable && control.checked)

                    color:
                    {
                        if(control.customColor !== undefined && control.customColor !== null)
                        {
                            return control.customColor
                        }
                        else if(control.checkable && control.checked && control.hovered)
                        {
                            return UM.Theme.getColor("toolbar_button_active_hover")
                        }
                        else if(control.pressed || (control.checkable && control.checked))
                        {
                            return UM.Theme.getColor("toolbar_button_active")
                        }
                        else if(control.hovered)
                        {
                            return UM.Theme.getColor("toolbar_button_hover")
                        }
                        return UM.Theme.getColor("toolbar_background")
                    }
                    Behavior on color { ColorAnimation { duration: 50; } }

                    border.width: (control.hasOwnProperty("needBorder") && control.needBorder) ? UM.Theme.getSize("default_lining").width : 0
                    border.color: control.checked ? UM.Theme.getColor("icon") : UM.Theme.getColor("lining")
                }
            }

            label: Item
            {
                UM.RecolorImage
                {
                    anchors.centerIn: parent
                    opacity: control.enabled ? 1.0 : 0.2
                    source: control.iconSource
                    width: UM.Theme.getSize("medium_button_icon").width
                    height: UM.Theme.getSize("medium_button_icon").height
                    color: UM.Theme.getColor("icon")

                    sourceSize: UM.Theme.getSize("medium_button_icon")
                }
            }
        }
    }

    property Component progressbar: Component
    {
        ProgressBarStyle
        {
            background: Rectangle
            {
                implicitWidth: UM.Theme.getSize("message").width - (UM.Theme.getSize("default_margin").width * 2)
                implicitHeight: UM.Theme.getSize("progressbar").height
                color: control.hasOwnProperty("backgroundColor") ? control.backgroundColor : UM.Theme.getColor("progressbar_background")
                radius: UM.Theme.getSize("progressbar_radius").width
            }
            progress: Rectangle
            {
                color:
                {
                    if(control.indeterminate)
                    {
                        return "transparent";
                    }
                    else if(control.hasOwnProperty("controlColor"))
                    {
                        return  control.controlColor;
                    }
                    else
                    {
                        return UM.Theme.getColor("progressbar_control");
                    }
                }
                radius: UM.Theme.getSize("progressbar_radius").width
                Rectangle
                {
                    radius: UM.Theme.getSize("progressbar_radius").width
                    color: control.hasOwnProperty("controlColor") ? control.controlColor : UM.Theme.getColor("progressbar_control")
                    width: UM.Theme.getSize("progressbar_control").width
                    height: UM.Theme.getSize("progressbar_control").height
                    visible: control.indeterminate

                    SequentialAnimation on x
                    {
                        id: xAnim
                        property int animEndPoint: UM.Theme.getSize("message").width - Math.round((UM.Theme.getSize("default_margin").width * 2.5)) - UM.Theme.getSize("progressbar_control").width
                        running: control.indeterminate && control.visible
                        loops: Animation.Infinite
                        NumberAnimation { from: 0; to: xAnim.animEndPoint; duration: 2000;}
                        NumberAnimation { from: xAnim.animEndPoint; to: 0; duration: 2000;}
                    }
                }
            }
        }
    }

    property Component scrollview: Component
    {
        ScrollViewStyle
        {
            decrementControl: Item { }
            incrementControl: Item { }

            transientScrollBars: false

            scrollBarBackground: Rectangle
            {
                implicitWidth: UM.Theme.getSize("scrollbar").width
                radius: Math.round(implicitWidth / 2)
                color: UM.Theme.getColor("scrollbar_background")
            }

            handle: Rectangle
            {
                id: scrollViewHandle
                implicitWidth: UM.Theme.getSize("scrollbar").width
                radius: Math.round(implicitWidth / 2)

                color: styleData.pressed ? UM.Theme.getColor("scrollbar_handle_down") : styleData.hovered ? UM.Theme.getColor("scrollbar_handle_hover") : UM.Theme.getColor("scrollbar_handle")
                Behavior on color { ColorAnimation { duration: 50; } }
            }
        }
    }

    property Component combobox: Component
    {
        ComboBoxStyle
        {

            background: Rectangle
            {
                implicitHeight: UM.Theme.getSize("setting_control").height;
                implicitWidth: UM.Theme.getSize("setting_control").width;

                color: control.hovered ? UM.Theme.getColor("setting_control_highlight") : UM.Theme.getColor("setting_control")
                Behavior on color { ColorAnimation { duration: 50; } }

                border.width: UM.Theme.getSize("default_lining").width;
                border.color: control.hovered ? UM.Theme.getColor("setting_control_border_highlight") : UM.Theme.getColor("setting_control_border");
                radius: UM.Theme.getSize("setting_control_radius").width
            }

            label: Item
            {
                Label
                {
                    anchors.left: parent.left
                    anchors.leftMargin: UM.Theme.getSize("default_lining").width
                    anchors.right: downArrow.left
                    anchors.rightMargin: UM.Theme.getSize("default_lining").width
                    anchors.verticalCenter: parent.verticalCenter

                    text: control.currentText
                    font: UM.Theme.getFont("default");
                    color: !enabled ? UM.Theme.getColor("setting_control_disabled_text") : UM.Theme.getColor("setting_control_text")

                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }

                UM.RecolorImage
                {
                    id: downArrow
                    anchors.right: parent.right
                    anchors.rightMargin: UM.Theme.getSize("default_lining").width * 2
                    anchors.verticalCenter: parent.verticalCenter

                    source: UM.Theme.getIcon("ChevronSingleDown")
                    width: UM.Theme.getSize("standard_arrow").width
                    height: UM.Theme.getSize("standard_arrow").height
                    sourceSize.width: width + 5 * screenScaleFactor
                    sourceSize.height: width + 5 * screenScaleFactor

                    color: UM.Theme.getColor("setting_control_button");
                }
            }
        }
    }

    property Component partially_checkbox: Component
    {
        CheckBoxStyle
        {
            background: Item { }
            indicator: Rectangle
            {
                implicitWidth:  UM.Theme.getSize("checkbox").width
                implicitHeight: UM.Theme.getSize("checkbox").height

                color: (control.hovered || control._hovered) ? UM.Theme.getColor("checkbox_hover") : UM.Theme.getColor("checkbox");
                Behavior on color { ColorAnimation { duration: 50; } }

                radius: control.exclusiveGroup ? Math.round(UM.Theme.getSize("checkbox").width / 2) : UM.Theme.getSize("checkbox_radius").width

                border.width: UM.Theme.getSize("default_lining").width;
                border.color: (control.hovered || control._hovered) ? UM.Theme.getColor("checkbox_border_hover") : UM.Theme.getColor("checkbox_border");

                UM.RecolorImage
                {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: Math.round(parent.width / 2.5)
                    height: Math.round(parent.height / 2.5)
                    sourceSize.height: width
                    color: UM.Theme.getColor("checkbox_mark")
                    source:
                    {
                        if (control.checkbox_state == 2)
                        {
                            return UM.Theme.getIcon("Solid");
                        }
                        else
                        {
                            return control.exclusiveGroup ? UM.Theme.getIcon("Dot", "low") : UM.Theme.getIcon("Check");
                        }
                    }
                    opacity: control.checked
                    Behavior on opacity { NumberAnimation { duration: 100; } }
                }
            }
            label: Label
            {
                text: control.text
                color: UM.Theme.getColor("checkbox_text")
                font: UM.Theme.getFont("default")
            }
        }
    }
}
