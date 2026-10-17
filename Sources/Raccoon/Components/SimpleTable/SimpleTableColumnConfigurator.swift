import HTML
import SGML
import SVG
import WebBuilders

@Builder<Element>
public func simpleTableColumnConfigurator(
    caption: String?
) -> [Element] {

    DebugComment("Column configurator")
    Div {
        Div {
            H3("Configure columns")
                .class(SimpleTableStyles.columnSelectorTitle)

            Button {
                Svg.icon(.x_lg)
                    .class("w-5 h-5")
            }
            .ariaLabel("Close column configurator")
            .setAttribute(
                name: "data-popover-initial",
                value: ""
            )
            .setAttribute(
                name: "@click",
                value: "cancelColumnChanges()"
            )
            .addClass(ActionButtonStyles.iconButton)
            // Matomo
            .flagAttribute("data-track-content")
            .setAttribute(
                name: "data-content-name",
                value: "simple-table"
            )
            .setAttribute(
                name: "data-content-piece",
                value: "column-configurator.close"
            )
            .setAttribute(
                name: "data-content-target",
                value: ""
            )
        }
        .class("flex flex-row justify-between items-center mb-4")

        Div {

            Div {

                Template {
                    Div {

                        // Slot 0 (before first row) rendered INSIDE the loop
                        // Only visible when:
                        //  - we are on the first row (index === 0)
                        //  - slot is 0 (tempDropIndex === 0)
                        Div {}
                            .class("h-0.5 my-1")
                            .addClass(SimpleTableStyles.dropIndicatorColor)
                            .setAttribute(
                                name: "x-show",
                                value: """
                                    draggingTempKey && tempDropIndex === 0 && index === 0
                                    """
                            )

                        Div {

                            Button {
                                Svg.icon(.grip_vertical)
                                    .class("w-5 h-5")
                            }
                            .class(
                                "outline-none touch-action-none"
                            )
                            .addClass(SimpleTableStyles.cursorGrab)
                            .addClass(ActionButtonStyles.font)
                            .addClass(ActionButtonStyles.textSizeBase)
                            .addClass(ActionButtonStyles.paddingIcon)
                            .addClass(ActionButtonStyles.textColorIcon)
                            .addClass(ActionButtonStyles.backgroundColorIcon)
                            .addClass(ActionButtonStyles.borderIcon)
                            .addClass(ActionButtonStyles.focusDefault)
                            .addClass(ActionButtonStyles.hoverDefault)
                            .setAttribute(
                                name: "role",
                                value: "button"
                            )
                            .setAttribute(
                                name: "tabindex",
                                value: "0"
                            )
                            .setAttribute(
                                name: "aria-label",
                                value: "Reorder column"
                            )
                            .setAttribute(
                                name: ":aria-pressed",
                                value: "keyboardDraggingKey === col.key"
                            )
                            .setAttribute(
                                name: ":data-grip",
                                value: "col.key"
                            )

                            // Keyboard drag handlers
                            .setAttribute(
                                name: "@keydown.escape.prevent",
                                value: "cancelKeyboardDrag()"
                            )
                            .setAttribute(
                                name: "@keydown.arrow-up.prevent",
                                value: "moveKeyboard(col.key, -1)"
                            )
                            .setAttribute(
                                name: "@keydown.arrow-down.prevent",
                                value: "moveKeyboard(col.key, 1)"
                            )
                            .setAttribute(
                                name: "@keydown.home.prevent",
                                value: "moveKeyboardToStart(col.key)"
                            )
                            .setAttribute(
                                name: "@keydown.end.prevent",
                                value: "moveKeyboardToEnd(col.key)"
                            )
                            .setAttribute(
                                name: "@keydown.space.prevent",
                                value:
                                    "keyboardDraggingKey ? finishKeyboardDrag(col.key, $event) : toggleKeyboardDrag(col.key)"
                            )
                            .setAttribute(
                                name: "@keydown.enter.prevent",
                                value:
                                    "keyboardDraggingKey ? finishKeyboardDrag(col.key, $event) : toggleKeyboardDrag(col.key)"
                            )
                            .setAttribute(
                                name: "@keydown.tab",
                                value: "finishKeyboardDrag(col.key, $event)"
                            )

                            // Checkbox + label
                            HTML.Label {

                                Input()
                                    .type(.checkbox)
                                    .setAttribute(
                                        name: ":checked",
                                        value: """
                                            !isHideable(col)
                                              ? true
                                              : tempVisibleColumns.has(col.key)
                                            """
                                    )
                                    .setAttribute(
                                        name: ":disabled",
                                        value: """
                                            !isHideable(col)
                                            ||
                                            (allColumnsAreHideable
                                              && isHideable(col)
                                              && tempVisibleColumns.has(col.key)
                                              && [...tempVisibleColumns].filter(k => {
                                                    const c = meta.columns.find(x => x.key === k);
                                                    return c && isHideable(c);
                                                 }).length === 1)
                                            """
                                    )
                                    .setAttribute(
                                        name: "@change",
                                        value: "toggleTempColumn(col.key)"
                                    )
                                    .class(CheckStyles.textFontDefault)
                                    .addClass(CheckStyles.textColorCheckbox)
                                    .addClass(CheckStyles.focusDefault)
                                    .addClass(CheckStyles.hoverDefault)

                                Span {}
                                    .class(
                                        SimpleTableStyles.columnSelectorOption
                                    )
                                    .setAttribute(
                                        name: "x-text",
                                        value: "col.label"
                                    )
                                    .setAttribute(
                                        name: ":class",
                                        value: """
                                            !isHideable(col)
                                              ? 'opacity-40 cursor-not-allowed'
                                              : (allColumnsAreHideable
                                                 && tempVisibleColumns.has(col.key)
                                                 && [...tempVisibleColumns].filter(k => {
                                                        const c = meta.columns.find(x => x.key === k);
                                                        return c && isHideable(c);
                                                    }).length === 1)
                                                  ? 'opacity-40 cursor-not-allowed'
                                                  : ''
                                            """
                                    )
                            }
                            .class(
                                "flex items-center space-x-2 py-1"
                            )
                            .addClass(SimpleTableStyles.cursorGrab)

                        }
                        .class(
                            """
                                flex flex-row items-center space-x-3 py-1
                                select-none touch-none !cursor-grab touch-action-none
                            """
                        )
                        .flagAttribute("data-draggable-row")
                        .setAttribute(
                            name: ":class",
                            value: """
                                draggingTempKey === col.key
                                  ? 'cursor-grabbing'
                                  : 'cursor-grab'
                                """
                        )
                        .setAttribute(
                            name: "@pointerdown",
                            value: "startTempPointerDown($event, col.key)"
                        )
                        .setAttribute(
                            name: "@pointermove",
                            value: "tempPointerMove($event, index)"
                        )
                        .setAttribute(
                            name: "@pointerup",
                            value: "endTempPointer()"
                        )

                        // Slot (index + 1) — exactly one indicator per slot between rows
                        Div {}
                            .class("h-0.5 my-1")
                            .addClass(SimpleTableStyles.dropIndicatorColor)
                            .setAttribute(
                                name: "x-show",
                                value: """
                                    draggingTempKey && tempDropIndex === index + 1
                                    """
                            )
                    }
                }
                .setAttribute(
                    name: "x-for",
                    value: "(col, index) in tempColumns"
                )
                .setAttribute(
                    name: ":key",
                    value: "col.key"
                )

            }
            .flagAttribute("data-draggable-container")

            // Slot N (after last row)
            Div {
                Div {}
                    .class("h-0.5 my-1")
                    .addClass(SimpleTableStyles.backgroundTransparent)
                    .setAttribute(
                        name: ":class",
                        value: """
                            draggingTempKey && tempDropIndex === tempColumns.length
                              ? 'bg-primary'
                              : 'bg-transparent'
                            """
                    )
            }
            .class("block h-4 select-none touch-none touch-action-none")
            .setAttribute(
                name: "@pointermove",
                value: "tempDropIndex = tempColumns.length"
            )
            .setAttribute(
                name: "@pointerup",
                value: "endTempPointer()"
            )

        }

        Button("Reset all settings")
            .setAttribute(
                name: "@click",
                value: "resetTableState()"
            )
            .ariaLabel("Reset column settings")
            .class("mb-2")
            .addClass("cursor-pointer")
            .addClass(ActionButtonStyles.font)
            .addClass(ActionButtonStyles.textSizeBase)
            .addClass(ActionButtonStyles.paddingTertiary)
            .addClass(ActionButtonStyles.textColorTertiary)
            .addClass(ActionButtonStyles.backgroundColorTertiary)
            .addClass(ActionButtonStyles.borderTertiary)
            .addClass(ActionButtonStyles.focusDefault)
            .addClass(ActionButtonStyles.hoverDefault)
            .setAttribute(
                name: "data-content-piece",
                value: "ResetButton"
            )
            .setAttribute(
                name: "data-content-target",
                value: "reset customization"
            )
            .flagAttribute("data-track-content")
            .setAttribute(
                name: "data-content-name",
                value: "simple-table"
            )
            .setAttribute(
                name: "data-content-piece",
                value: "column-configurator.reset"
            )
            .setAttribute(
                name: "data-content-target",
                value: ""
            )

        // Action bar
        Div {

            ActionButton(
                ActionButtonData(
                    id: "table-cancel",
                    clickAction: "cancelColumnChanges()",
                    label: "Cancel",
                    ariaLabel: "Cancel column changes",
                    htmlType: .button,
                    buttonType: .secondary,
                    contentTracker: MatomoContentTracker(
                        name: "simple-table",
                        piece: "column-configurator.cancel",
                        target: ""
                    )
                )
            )
            .render()

            ActionButton(
                ActionButtonData(
                    id: "table-save",
                    clickAction: "applyColumnChanges()",
                    label: "Save",
                    ariaLabel: "Apply column changes",
                    htmlType: .button,
                    buttonType: .primary,
                    contentTracker: MatomoContentTracker(
                        name: "simple-table",
                        piece: "column-configurator.save",
                        target: ""
                    )
                )
            )
            .render()

        }
        .class("flex justify-start space-x-4 pt-2")

        // ARIA live region
        Div {}
            .class("sr-only")
            .setAttribute(
                name: "aria-live",
                value: "polite"
            )
            .setAttribute(
                name: "x-text",
                value: "keyboardAnnouncement"
            )

    }
    .class(
        "absolute min-w-[240px] right-0 mt-2 p-4 z-50 \(SimpleTableStyles.columnSelectorBackground)"
    )
    .setAttribute(
        name: "x-show",
        value: "hasColumnConfigurator && showColumnModal"
    )
    .setAttribute(
        name: ":key",
        value: "popoverRenderKey"
    )
    .setAttribute(
        name: "@click.outside",
        value: "cancelColumnChanges()"
    )
    .setAttribute(
        name: "@keydown",
        value: "trapTab($event)"
    )
    .setAttribute(
        name: "@keydown.escape.prevent",
        value: "cancelColumnChanges()"
    )
    .setAttribute(
        name: "tabindex",
        value: "-1"
    )
    .setAttribute(
        name: "data-column-popover",
        value: ""
    )
    .setAttribute(
        name: "role",
        value: "dialog"
    )
    .setAttribute(
        name: "aria-modal",
        value: "true"
    )
    .flagAttribute("x-transition")
}
