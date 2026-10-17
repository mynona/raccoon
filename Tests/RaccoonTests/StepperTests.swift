import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Stepper Component")
struct StepperTests {

    @Test("Renders nav and ordered list elements with accessible semantics")
    func rendersNavAndListSemantics() async throws {

        let data = StepperData(
            id: "onboarding-stepper",
            ariaLabel: "Onboarding Progress",
            steps: [
                StepperStepData(title: "Step 1", status: .complete),
                StepperStepData(title: "Step 2", status: .current),
                StepperStepData(title: "Step 3", status: .upcoming),
            ]
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("<nav"))
        #expect(html.contains("id=\"onboarding-stepper\""))
        #expect(html.contains("aria-label=\"Onboarding Progress\""))
        #expect(html.contains("<ol"))
        #expect(html.contains("role=\"list\""))
        #expect(html.contains("<li"))
    }

    @Test("Renders vertical orientation with titles and descriptions")
    func rendersVerticalOrientation() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Account Setup",
                    description: "Enter your email and choose password.",
                    status: .complete
                ),
                StepperStepData(
                    title: "Profile Details",
                    description: "Add your personal information.",
                    status: .current
                ),
                StepperStepData(
                    title: "Confirmation",
                    description: "Review and accept terms.",
                    status: .upcoming
                ),
            ],
            orientation: .vertical
        )
        let html = renderHTML(Stepper(data).render())

        // Check list classes
        #expect(html.contains("overflow-hidden"))

        // Check titles and descriptions
        #expect(html.contains("Account Setup"))
        #expect(html.contains("Enter your email and choose password."))
        #expect(html.contains("Profile Details"))
        #expect(html.contains("Add your personal information."))
        #expect(html.contains("Confirmation"))
        #expect(html.contains("Review and accept terms."))

        // Current step has aria-current="step"
        #expect(html.contains("aria-current=\"step\""))

        // Completed step has checkmark icon (SVG)
        #expect(html.contains("<svg"))

        // Non-last steps have pb-10 and vertical connecting line
        #expect(html.contains("pb-10"))
        #expect(
            html.contains("absolute top-4 left-4 mt-0.5 -ml-px h-full w-0.5")
        )

        // Active line uses progressactive
        #expect(html.contains("bg-progressactive"))
        // Inactive line uses progressinactive
        #expect(html.contains("bg-progressinactive"))
    }

    @Test(
        "Renders horizontal orientation with sr-only labels and horizontal connecting lines"
    )
    func rendersHorizontalOrientation() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Step 1: Account", status: .complete),
                StepperStepData(title: "Step 2: Profile", status: .current),
                StepperStepData(title: "Step 3: Finish", status: .upcoming),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Check horizontal list class
        #expect(html.contains("flex items-center"))

        // Screen-reader labels are rendered with sr-only
        #expect(html.contains("<span class=\"sr-only\">Step 1: Account</span>"))
        #expect(html.contains("<span class=\"sr-only\">Step 2: Profile</span>"))
        #expect(html.contains("<span class=\"sr-only\">Step 3: Finish</span>"))

        // Current step semantics
        #expect(html.contains("aria-current=\"step\""))

        // Horizontal connecting lines
        #expect(html.contains("absolute inset-0 flex items-center"))
        #expect(html.contains("h-0.5 w-full"))

        // Padding between steps
        #expect(html.contains("pr-8 sm:pr-20"))
    }

    @Test("Renders horizontal stepper with full width styling")
    func rendersHorizontalFullWidth() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Cart", status: .complete),
                StepperStepData(title: "Shipping", status: .current),
                StepperStepData(title: "Payment", status: .upcoming),
            ],
            orientation: .horizontal,
            hasFullWidth: true
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("flex-1 pr-8 sm:pr-20"))
    }

    @Test("Renders interactive links when href is provided")
    func rendersInteractiveLinks() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Step 1",
                    href: "/steps/1",
                    hreflang: "en-US",
                    target: "_blank",
                    status: .complete
                ),
                StepperStepData(
                    title: "Step 2",
                    href: "/steps/2",
                    status: .current
                ),
                StepperStepData(
                    title: "Step 3",
                    status: .upcoming
                ),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Links rendered for steps with href
        #expect(html.contains("<a href=\"/steps/1\""))
        #expect(html.contains("hreflang=\"en-US\""))
        #expect(html.contains("target=\"_blank\""))
        #expect(html.contains("<a href=\"/steps/2\""))

        // Step without href is rendered as div
        #expect(html.contains("<div"))
    }

    @Test("Renders disabled step state properly")
    func rendersDisabledState() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Active", status: .complete),
                StepperStepData(
                    title: "Locked",
                    status: .upcoming,
                    state: .disabled
                ),
            ],
            orientation: .vertical
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("aria-disabled=\"true\""))
        #expect(html.contains("pointer-events-none"))
    }

    @Test("Renders custom icon override when provided")
    func rendersCustomIcon() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Approved",
                    status: .complete,
                    icon: .check_circle_fill
                )
            ],
            orientation: .vertical
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("<svg"))
    }

    @Test("Renders Matomo tracking attributes when enabled")
    func rendersMatomoTracking() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    id: "custom-step-id",
                    title: "Checkout Step",
                    href: "/checkout",
                    status: .current,
                    matomoStatus: .ACCEPTED
                )
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"stepper\""))
        #expect(html.contains("data-content-piece=\"custom-step-id\""))
        #expect(html.contains("data-content-target=\"/checkout\""))
    }

    @Test("Renders empty when steps collection is empty")
    func rendersEmptyWhenNoSteps() async throws {

        let data = StepperData(steps: [])
        let html = renderHTML(Stepper(data).render())

        #expect(html.isEmpty)
    }

    @Test("Last step in vertical stepper omits connecting line and padding")
    func verticalLastStepOmitsLine() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "First", status: .complete),
                StepperStepData(title: "Second", status: .current),
            ],
            orientation: .vertical
        )
        let html = renderHTML(Stepper(data).render())

        // First item has pb-10; last item has class="relative" without pb-10
        #expect(html.contains("class=\"relative pb-10\""))
        #expect(html.contains("class=\"relative\""))

        // Only 1 connecting line rendered for 2 items
        let matches =
            html.components(
                separatedBy: "absolute top-4 left-4 mt-0.5 -ml-px h-full w-0.5"
            )
            .count - 1
        #expect(matches == 1)
    }

    @Test(
        "Last step in horizontal stepper omits connecting line and trailing padding"
    )
    func horizontalLastStepOmitsLine() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "First", status: .complete),
                StepperStepData(title: "Second", status: .current),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // First item has pr-8 sm:pr-20; last item has class="relative" without pr-8 sm:pr-20
        #expect(html.contains("class=\"relative pr-8 sm:pr-20\""))
        #expect(html.contains("class=\"relative\""))

        // Only 1 connecting line rendered for 2 items
        let lineMatches =
            html.components(separatedBy: "absolute inset-0 flex items-center")
            .count - 1
        #expect(lineMatches == 1)
    }

    @Test("Renders tooltips with step titles on icons for horizontal stepper")
    func horizontalStepperRendersTooltips() async throws {

        let data = StepperData(
            id: "checkout-stepper",
            steps: [
                StepperStepData(title: "Cart", status: .complete),
                StepperStepData(title: "Payment", status: .current),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Trigger element has x-ref, aria-describedby, and event dispatchers
        #expect(html.contains("x-ref=\"tooltip-checkout-stepper-1\""))
        #expect(
            html.contains("aria-describedby=\"tooltip-checkout-stepper-1\"")
        )
        #expect(html.contains("show-tooltip"))
        #expect(html.contains("hide-tooltip"))

        // Tooltip element is rendered with role="tooltip" and title text
        #expect(html.contains("role=\"tooltip\""))
        #expect(html.contains("Cart"))
        #expect(html.contains("Payment"))
        #expect(html.contains("tooltipVisible"))
    }

    @Test("Renders tooltips with step titles on icons for vertical stepper")
    func verticalStepperRendersTooltips() async throws {

        let data = StepperData(
            id: "registration-stepper",
            steps: [
                StepperStepData(
                    title: "Account Setup",
                    description: "Email & Password",
                    status: .complete
                ),
                StepperStepData(
                    title: "Profile",
                    description: "Personal details",
                    status: .current
                ),
            ],
            orientation: .vertical
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("x-ref=\"tooltip-registration-stepper-1\""))
        #expect(
            html.contains("aria-describedby=\"tooltip-registration-stepper-1\"")
        )
        #expect(html.contains("role=\"tooltip\""))
        #expect(html.contains("Account Setup"))
    }

    @Test("Allows custom tooltip text override on a step")
    func customTooltipText() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Step 1",
                    tooltip: "Custom explanation of step 1",
                    status: .complete
                )
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("Custom explanation of step 1"))
    }

    @Test("Can disable tooltips globally via hasTooltip: false")
    func canDisableTooltipsGlobally() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Cart", status: .complete)
            ],
            orientation: .horizontal,
            hasTooltip: false
        )
        let html = renderHTML(Stepper(data).render())

        #expect(!html.contains("show-tooltip"))
        #expect(!html.contains("role=\"tooltip\""))
    }

    @Test("Can disable tooltip on an individual step via hasTooltip: false")
    func canDisableTooltipPerStep() async throws {

        let data = StepperData(
            id: "mixed-stepper",
            steps: [
                StepperStepData(
                    title: "Step 1",
                    hasTooltip: false,
                    status: .complete
                ),
                StepperStepData(
                    title: "Step 2",
                    hasTooltip: true,
                    status: .current
                ),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Step 1 does not have tooltip listeners or tooltip element
        #expect(!html.contains("x-ref=\"tooltip-mixed-stepper-1\""))
        // Step 2 has tooltip listeners and element
        #expect(html.contains("x-ref=\"tooltip-mixed-stepper-2\""))
        #expect(html.contains("Step 2"))
    }

    @Test("Static step with tooltip is keyboard focusable via tabindex")
    func staticStepWithTooltipHasTabIndex() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Static Step", status: .current)
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains("tabindex=\"0\""))
    }

    @Test(
        "Completed step always renders the tick checkmark even when a custom icon is configured"
    )
    func completedStepAlwaysRendersTick() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Email Step",
                    status: .complete,
                    icon: .envelope
                )
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Check icon path is present (checkmark)
        #expect(html.contains("<svg"))
        let checkIconHtml = renderHTML([
            Svg.icon(.check, width: 20, height: 20, role: .presentation)
        ])
        #expect(html.contains(checkIconHtml))

        // Must NOT contain the envelope icon path when completed
        let envelopePath =
            "M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2z"
        #expect(!html.contains(envelopePath))
    }

    @Test("Current and upcoming steps render the configured custom icon")
    func currentAndUpcomingStepsRenderCustomIcon() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Current Email",
                    status: .current,
                    icon: .envelope
                ),
                StepperStepData(
                    title: "Upcoming Heart",
                    status: .upcoming,
                    icon: .heart
                ),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        let envelopeIconHtml = renderHTML([
            Svg.icon(.envelope, width: 18, height: 18, role: .presentation)
                .class(StepperStyles.iconCurrent)
        ])
        let heartIconHtml = renderHTML([
            Svg.icon(.heart, width: 18, height: 18, role: .presentation)
                .class(StepperStyles.iconUpcoming)
        ])

        #expect(html.contains(envelopeIconHtml))
        #expect(html.contains(heartIconHtml))
    }

    @Test("Current and upcoming steps render configured step numbers")
    func currentAndUpcomingStepsRenderStepNumbers() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(
                    title: "Step 1 Done",
                    status: .complete,
                    stepNumber: 1
                ),
                StepperStepData(
                    title: "Step 2 Active",
                    status: .current,
                    stepNumber: 2
                ),
                StepperStepData(
                    title: "Step 3 Pending",
                    status: .upcoming,
                    icon: .envelope
                ),
            ],
            orientation: .horizontal
        )
        let html = renderHTML(Stepper(data).render())

        // Step 1 is completed -> shows checkmark tick
        let checkIconHtml = renderHTML([
            Svg.icon(.check, width: 20, height: 20, role: .presentation)
        ])
        #expect(html.contains(checkIconHtml))

        // Step 2 is current -> shows step number "2"
        #expect(html.contains(">2</span>"))

        // Step 3 is upcoming with icon -> shows envelope icon with upcoming styling
        let envelopeIconHtml = renderHTML([
            Svg.icon(.envelope, width: 18, height: 18, role: .presentation)
                .class(StepperStyles.iconUpcoming)
        ])
        #expect(html.contains(envelopeIconHtml))
    }

    @Test(
        "hasStepNumbers: true automatically numbers steps without custom icons"
    )
    func hasStepNumbersAutomaticallyNumbersSteps() async throws {

        let data = StepperData(
            steps: [
                StepperStepData(title: "Step One", status: .current),
                StepperStepData(title: "Step Two", status: .upcoming),
            ],
            orientation: .horizontal,
            hasStepNumbers: true
        )
        let html = renderHTML(Stepper(data).render())

        #expect(html.contains(">1</span>"))
        #expect(html.contains(">2</span>"))
    }
}
