import Raccoon
import Testing

@testable import Raccoon

@Suite("DialogStyles")
struct DialogStylesTests {

    @Test("contains valid dialog style constants")
    func testDialogStylesConstants() {
        #expect(!DialogStyles.title.isEmpty)
        #expect(!DialogStyles.textFont.isEmpty)
        #expect(!DialogStyles.textColor.isEmpty)
        #expect(!DialogStyles.backgroundMargin.isEmpty)
        #expect(!DialogStyles.backgroundPadding.isEmpty)
        #expect(!DialogStyles.backgroundRadius.isEmpty)
        #expect(!DialogStyles.backgroundColorDefault.isEmpty)
        #expect(!DialogStyles.backgroundBorderDefault.isEmpty)
        #expect(!DialogStyles.backgroundColorDisabled.isEmpty)
        #expect(!DialogStyles.backgroundBorderDisabled.isEmpty)
        #expect(!DialogStyles.backgroundColorWarning.isEmpty)
        #expect(!DialogStyles.closeButtonAbsolutePosition.isEmpty)
    }

    @Test("warning styles have border-0")
    func testWarningStyles() {
        #expect(DialogStyles.backgroundBorderWarning == "border-0")
    }
}
