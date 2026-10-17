import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct StepperView: TemplateRepresentable {

    let variants: [(String, StepperData)] = [
        (
            """
            // Vertical Stepper (Account Registration Flow)
            """,
            StepperData(
                id: "stepper-vertical",
                ariaLabel: "Account registration progress",
                steps: [
                    StepperStepData(
                        id: "step-create-account",
                        title: "Create account",
                        description: "Vitae sed mi luctus laoreet.",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-profile-info",
                        title: "Profile information",
                        description:
                            "Cursus semper viverra facilisis et et some more.",
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-business-info",
                        title: "Business information",
                        description: "Penatibus eu quis ante.",
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-theme",
                        title: "Theme",
                        description: "Faucibus nec enim leo et.",
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-preview",
                        title: "Preview",
                        description:
                            "Iusto et officia maiores porro ad non quas.",
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .vertical
            )
        ),
        (
            """
            // Horizontal Stepper (Compact Circles)
            """,
            StepperData(
                id: "stepper-horizontal",
                ariaLabel: "Onboarding progress",
                steps: [
                    StepperStepData(
                        id: "step-1",
                        title: "Step 1",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-2",
                        title: "Step 2",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-3",
                        title: "Step 3",
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-4",
                        title: "Step 4",
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-5",
                        title: "Step 5",
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal
            )
        ),
        (
            """
            // Horizontal Stepper (Full Width)
            """,
            StepperData(
                id: "stepper-horizontal-full-width",
                ariaLabel: "Checkout flow progress",
                steps: [
                    StepperStepData(
                        id: "step-cart",
                        title: "Cart",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-shipping",
                        title: "Shipping",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-payment",
                        title: "Payment",
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-confirm",
                        title: "Confirmation",
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal,
                hasFullWidth: true
            )
        ),
        (
            """
            // Static Vertical Stepper (Read-only Order Status)
            """,
            StepperData(
                id: "stepper-static-order",
                ariaLabel: "Order delivery tracking",
                steps: [
                    StepperStepData(
                        title: "Order Placed",
                        description: "Your order was successfully submitted.",
                        status: .complete
                    ),
                    StepperStepData(
                        title: "In Preparation",
                        description:
                            "Items are being packed in the fulfillment center.",
                        status: .current
                    ),
                    StepperStepData(
                        title: "Shipped",
                        description: "Package handed over to delivery courier.",
                        status: .upcoming
                    ),
                    StepperStepData(
                        title: "Delivered",
                        description:
                            "Package delivered to your shipping address.",
                        status: .upcoming
                    ),
                ],
                orientation: .vertical
            )
        ),
        (
            """
            // Horizontal Stepper with Custom Tooltips
            """,
            StepperData(
                id: "stepper-tooltips-demo",
                ariaLabel: "Deployment pipeline stages",
                steps: [
                    StepperStepData(
                        id: "step-repository",
                        title: "Repository",
                        tooltip: "Step 1: Connect your Git repository",
                        tooltipPosition: .top,
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-build",
                        title: "Build Configuration",
                        tooltip:
                            "Step 2: Define build settings & environment variables",
                        tooltipPosition: .top,
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-deploy",
                        title: "Deployment",
                        tooltip: "Step 3: Deploy to production cluster",
                        tooltipPosition: .top,
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-verify",
                        title: "Verification",
                        tooltip: "Step 4: Run automated health checks",
                        tooltipPosition: .top,
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal
            )
        ),
        (
            """
            // Configurable Icons & Step Numbers (Step 1 Active - Screenshot 1)
            """,
            StepperData(
                id: "stepper-custom-icons-step1",
                ariaLabel: "Registration steps with custom icons",
                steps: [
                    StepperStepData(
                        id: "step-user-details",
                        title: "Account Details",
                        tooltip: "Step 1: Enter your account information",
                        href: "#",
                        status: .current,
                        stepNumber: 1
                    ),
                    StepperStepData(
                        id: "step-phone-verification",
                        title: "Verification",
                        tooltip: "Step 2: Verify your phone number",
                        href: "#",
                        status: .upcoming,
                        stepNumber: 2
                    ),
                    StepperStepData(
                        id: "step-invitation-email",
                        title: "Invitation",
                        tooltip: "Step 3: Send email invite",
                        href: "#",
                        status: .upcoming,
                        icon: .envelope
                    ),
                ],
                orientation: .horizontal
            )
        ),
        (
            """
            // Configurable Icons & Step Numbers (Step 1 Completed with Tick - Screenshot 2)
            """,
            StepperData(
                id: "stepper-custom-icons-step2",
                ariaLabel: "Registration steps with completed tick",
                steps: [
                    StepperStepData(
                        id: "step-user-details-done",
                        title: "Account Details",
                        tooltip: "Step 1: Completed",
                        href: "#",
                        status: .complete,
                        stepNumber: 1
                    ),
                    StepperStepData(
                        id: "step-phone-verification-active",
                        title: "Verification",
                        tooltip: "Step 2: Verify your phone number",
                        href: "#",
                        status: .current,
                        stepNumber: 2
                    ),
                    StepperStepData(
                        id: "step-invitation-email-pending",
                        title: "Invitation",
                        tooltip: "Step 3: Send email invite",
                        href: "#",
                        status: .upcoming,
                        icon: .envelope
                    ),
                ],
                orientation: .horizontal
            )
        ),
    ]

    func makeHtml(ctx: StepperData) -> String {
        let html = renderFragments(Stepper(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("Stepper")

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Stepper(ctx).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
