/// Completion status of an individual step in a `Stepper`.
public enum StepperStepStatus: String, Sendable {
    /// The step has been completed.
    case complete
    /// The step is currently active.
    case current
    /// The step is upcoming and not yet reached.
    case upcoming
}
