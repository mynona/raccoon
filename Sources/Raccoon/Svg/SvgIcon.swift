/// A type‑safe enumeration of all Bootstrap Icons.
///
/// Each case corresponds to a single Bootstrap icon and maps directly
/// to its official identifier (the raw value). This allows you to
/// reference icons in Swift code without relying on string literals.
///
/// Use `SvgIcon` together with `Svg.icon(_:)` to render icons as
/// `<svg>` elements in your component library.
///
/// Example:
/// ```swift
/// let bell = Svg.icon(.bell, title: "Notifications")
/// ```
///
/// - Note: Case names are adapted to be valid Swift identifiers:
///   - Leading digits are spelled out (e.g. `0-circle` → `.zero_circle`)
///   - Reserved Swift keywords are escaped with backticks (e.g. `repeat` → ``.repeat``)
public enum SvgIcon: String, CaseIterable, Sendable {
    /// 0-circle
    /// bi bi-0-circle
    case zero_circle = "0-circle"
    /// 0-circle-fill
    /// bi bi-0-circle-fill
    case zero_circle_fill = "0-circle-fill"
    /// 0-square
    /// bi bi-0-square
    case zero_square = "0-square"
    /// 0-square-fill
    /// bi bi-0-square-fill
    case zero_square_fill = "0-square-fill"
    /// 1-circle
    /// bi bi-1-circle
    case one_circle = "1-circle"
    /// 1-circle-fill
    /// bi bi-1-circle-fill
    case one_circle_fill = "1-circle-fill"
    /// 1-square
    /// bi bi-1-square
    case one_square = "1-square"
    /// 1-square-fill
    /// bi bi-1-square-fill
    case one_square_fill = "1-square-fill"
    /// 123
    /// bi bi-123
    case one_two_three = "123"
    /// 2-circle
    /// bi bi-2-circle
    case two_circle = "2-circle"
    /// 2-circle-fill
    /// bi bi-2-circle-fill
    case two_circle_fill = "2-circle-fill"
    /// 2-square
    /// bi bi-2-square
    case two_square = "2-square"
    /// 2-square-fill
    /// bi bi-2-square-fill
    case two_square_fill = "2-square-fill"
    /// 3-circle
    /// bi bi-3-circle
    case three_circle = "3-circle"
    /// 3-circle-fill
    /// bi bi-3-circle-fill
    case three_circle_fill = "3-circle-fill"
    /// 3-square
    /// bi bi-3-square
    case three_square = "3-square"
    /// 3-square-fill
    /// bi bi-3-square-fill
    case three_square_fill = "3-square-fill"
    /// 4-circle
    /// bi bi-4-circle
    case four_circle = "4-circle"
    /// 4-circle-fill
    /// bi bi-4-circle-fill
    case four_circle_fill = "4-circle-fill"
    /// 4-square
    /// bi bi-4-square
    case four_square = "4-square"
    /// 4-square-fill
    /// bi bi-4-square-fill
    case four_square_fill = "4-square-fill"
    /// 5-circle
    /// bi bi-5-circle
    case five_circle = "5-circle"
    /// 5-circle-fill
    /// bi bi-5-circle-fill
    case five_circle_fill = "5-circle-fill"
    /// 5-square
    /// bi bi-5-square
    case five_square = "5-square"
    /// 5-square-fill
    /// bi bi-5-square-fill
    case five_square_fill = "5-square-fill"
    /// 6-circle
    /// bi bi-6-circle
    case six_circle = "6-circle"
    /// 6-circle-fill
    /// bi bi-6-circle-fill
    case six_circle_fill = "6-circle-fill"
    /// 6-square
    /// bi bi-6-square
    case six_square = "6-square"
    /// 6-square-fill
    /// bi bi-6-square-fill
    case six_square_fill = "6-square-fill"
    /// 7-circle
    /// bi bi-7-circle
    case seven_circle = "7-circle"
    /// 7-circle-fill
    /// bi bi-7-circle-fill
    case seven_circle_fill = "7-circle-fill"
    /// 7-square
    /// bi bi-7-square
    case seven_square = "7-square"
    /// 7-square-fill
    /// bi bi-7-square-fill
    case seven_square_fill = "7-square-fill"
    /// 8-circle
    /// bi bi-8-circle
    case eight_circle = "8-circle"
    /// 8-circle-fill
    /// bi bi-8-circle-fill
    case eight_circle_fill = "8-circle-fill"
    /// 8-square
    /// bi bi-8-square
    case eight_square = "8-square"
    /// 8-square-fill
    /// bi bi-8-square-fill
    case eight_square_fill = "8-square-fill"
    /// 9-circle
    /// bi bi-9-circle
    case nine_circle = "9-circle"
    /// 9-circle-fill
    /// bi bi-9-circle-fill
    case nine_circle_fill = "9-circle-fill"
    /// 9-square
    /// bi bi-9-square
    case nine_square = "9-square"
    /// 9-square-fill
    /// bi bi-9-square-fill
    case nine_square_fill = "9-square-fill"
    /// activity
    /// bi bi-activity
    case activity = "activity"
    /// airplane
    /// bi bi-airplane
    case airplane = "airplane"
    /// airplane-engines
    /// bi bi-airplane-engines
    case airplane_engines = "airplane-engines"
    /// airplane-engines-fill
    /// bi bi-airplane-engines-fill
    case airplane_engines_fill = "airplane-engines-fill"
    /// airplane-fill
    /// bi bi-airplane-fill
    case airplane_fill = "airplane-fill"
    /// alarm
    /// bi bi-alarm
    case alarm = "alarm"
    /// alarm-fill
    /// bi bi-alarm-fill
    case alarm_fill = "alarm-fill"
    /// alexa
    /// bi bi-alexa
    case alexa = "alexa"
    /// align-bottom
    /// bi bi-align-bottom
    case align_bottom = "align-bottom"
    /// align-center
    /// bi bi-align-center
    case align_center = "align-center"
    /// align-end
    /// bi bi-align-end
    case align_end = "align-end"
    /// align-middle
    /// bi bi-align-middle
    case align_middle = "align-middle"
    /// align-start
    /// bi bi-align-start
    case align_start = "align-start"
    /// align-top
    /// bi bi-align-top
    case align_top = "align-top"
    /// alipay
    /// bi bi-alipay
    case alipay = "alipay"
    /// alphabet
    /// bi bi-alphabet
    case alphabet = "alphabet"
    /// alphabet-uppercase
    /// bi bi-alphabet-uppercase
    case alphabet_uppercase = "alphabet-uppercase"
    /// alt
    /// bi bi-alt
    case alt = "alt"
    /// amazon
    /// bi bi-amazon
    case amazon = "amazon"
    /// amd
    /// bi bi-amd
    case amd = "amd"
    /// android
    /// bi bi-android
    case android = "android"
    /// android2
    /// bi bi-android2
    case android2 = "android2"
    /// anthropic
    /// bi bi-anthropic
    case anthropic = "anthropic"
    /// app
    /// bi bi-app
    case app = "app"
    /// app-indicator
    /// bi bi-app-indicator
    case app_indicator = "app-indicator"
    /// apple
    /// bi bi-apple
    case apple = "apple"
    /// apple-music
    /// bi bi-apple-music
    case apple_music = "apple-music"
    /// archive
    /// bi bi-archive
    case archive = "archive"
    /// archive-fill
    /// bi bi-archive-fill
    case archive_fill = "archive-fill"
    /// arrow-90deg-down
    /// bi bi-arrow-90deg-down
    case arrow_90deg_down = "arrow-90deg-down"
    /// arrow-90deg-left
    /// bi bi-arrow-90deg-left
    case arrow_90deg_left = "arrow-90deg-left"
    /// arrow-90deg-right
    /// bi bi-arrow-90deg-right
    case arrow_90deg_right = "arrow-90deg-right"
    /// arrow-90deg-up
    /// bi bi-arrow-90deg-up
    case arrow_90deg_up = "arrow-90deg-up"
    /// arrow-bar-down
    /// bi bi-arrow-bar-down
    case arrow_bar_down = "arrow-bar-down"
    /// arrow-bar-left
    /// bi bi-arrow-bar-left
    case arrow_bar_left = "arrow-bar-left"
    /// arrow-bar-right
    /// bi bi-arrow-bar-right
    case arrow_bar_right = "arrow-bar-right"
    /// arrow-bar-up
    /// bi bi-arrow-bar-up
    case arrow_bar_up = "arrow-bar-up"
    /// arrow-clockwise
    /// bi bi-arrow-clockwise
    case arrow_clockwise = "arrow-clockwise"
    /// arrow-counterclockwise
    /// bi bi-arrow-counterclockwise
    case arrow_counterclockwise = "arrow-counterclockwise"
    /// arrow-down
    /// bi bi-arrow-down
    case arrow_down = "arrow-down"
    /// arrow-down-circle
    /// bi bi-arrow-down-circle
    case arrow_down_circle = "arrow-down-circle"
    /// arrow-down-circle-fill
    /// bi bi-arrow-down-circle-fill
    case arrow_down_circle_fill = "arrow-down-circle-fill"
    /// arrow-down-left
    /// bi bi-arrow-down-left
    case arrow_down_left = "arrow-down-left"
    /// arrow-down-left-circle
    /// bi bi-arrow-down-left-circle
    case arrow_down_left_circle = "arrow-down-left-circle"
    /// arrow-down-left-circle-fill
    /// bi bi-arrow-down-left-circle-fill
    case arrow_down_left_circle_fill = "arrow-down-left-circle-fill"
    /// arrow-down-left-square
    /// bi bi-arrow-down-left-square
    case arrow_down_left_square = "arrow-down-left-square"
    /// arrow-down-left-square-fill
    /// bi bi-arrow-down-left-square-fill
    case arrow_down_left_square_fill = "arrow-down-left-square-fill"
    /// arrow-down-right
    /// bi bi-arrow-down-right
    case arrow_down_right = "arrow-down-right"
    /// arrow-down-right-circle
    /// bi bi-arrow-down-right-circle
    case arrow_down_right_circle = "arrow-down-right-circle"
    /// arrow-down-right-circle-fill
    /// bi bi-arrow-down-right-circle-fill
    case arrow_down_right_circle_fill = "arrow-down-right-circle-fill"
    /// arrow-down-right-square
    /// bi bi-arrow-down-right-square
    case arrow_down_right_square = "arrow-down-right-square"
    /// arrow-down-right-square-fill
    /// bi bi-arrow-down-right-square-fill
    case arrow_down_right_square_fill = "arrow-down-right-square-fill"
    /// arrow-down-short
    /// bi bi-arrow-down-short
    case arrow_down_short = "arrow-down-short"
    /// arrow-down-square
    /// bi bi-arrow-down-square
    case arrow_down_square = "arrow-down-square"
    /// arrow-down-square-fill
    /// bi bi-arrow-down-square-fill
    case arrow_down_square_fill = "arrow-down-square-fill"
    /// arrow-down-up
    /// bi bi-arrow-down-up
    case arrow_down_up = "arrow-down-up"
    /// arrow-left
    /// bi bi-arrow-left
    case arrow_left = "arrow-left"
    /// arrow-left-circle
    /// bi bi-arrow-left-circle
    case arrow_left_circle = "arrow-left-circle"
    /// arrow-left-circle-fill
    /// bi bi-arrow-left-circle-fill
    case arrow_left_circle_fill = "arrow-left-circle-fill"
    /// arrow-left-right
    /// bi bi-arrow-left-right
    case arrow_left_right = "arrow-left-right"
    /// arrow-left-short
    /// bi bi-arrow-left-short
    case arrow_left_short = "arrow-left-short"
    /// arrow-left-square
    /// bi bi-arrow-left-square
    case arrow_left_square = "arrow-left-square"
    /// arrow-left-square-fill
    /// bi bi-arrow-left-square-fill
    case arrow_left_square_fill = "arrow-left-square-fill"
    /// arrow-repeat
    /// bi bi-arrow-repeat
    case arrow_repeat = "arrow-repeat"
    /// arrow-return-left
    /// bi bi-arrow-return-left
    case arrow_return_left = "arrow-return-left"
    /// arrow-return-right
    /// bi bi-arrow-return-right
    case arrow_return_right = "arrow-return-right"
    /// arrow-right
    /// bi bi-arrow-right
    case arrow_right = "arrow-right"
    /// arrow-right-circle
    /// bi bi-arrow-right-circle
    case arrow_right_circle = "arrow-right-circle"
    /// arrow-right-circle-fill
    /// bi bi-arrow-right-circle-fill
    case arrow_right_circle_fill = "arrow-right-circle-fill"
    /// arrow-right-short
    /// bi bi-arrow-right-short
    case arrow_right_short = "arrow-right-short"
    /// arrow-right-square
    /// bi bi-arrow-right-square
    case arrow_right_square = "arrow-right-square"
    /// arrow-right-square-fill
    /// bi bi-arrow-right-square-fill
    case arrow_right_square_fill = "arrow-right-square-fill"
    /// arrow-through-heart
    /// bi bi-arrow-through-heart
    case arrow_through_heart = "arrow-through-heart"
    /// arrow-through-heart-fill
    /// bi bi-arrow-through-heart-fill
    case arrow_through_heart_fill = "arrow-through-heart-fill"
    /// arrow-up
    /// bi bi-arrow-up
    case arrow_up = "arrow-up"
    /// arrow-up-circle
    /// bi bi-arrow-up-circle
    case arrow_up_circle = "arrow-up-circle"
    /// arrow-up-circle-fill
    /// bi bi-arrow-up-circle-fill
    case arrow_up_circle_fill = "arrow-up-circle-fill"
    /// arrow-up-left
    /// bi bi-arrow-up-left
    case arrow_up_left = "arrow-up-left"
    /// arrow-up-left-circle
    /// bi bi-arrow-up-left-circle
    case arrow_up_left_circle = "arrow-up-left-circle"
    /// arrow-up-left-circle-fill
    /// bi bi-arrow-up-left-circle-fill
    case arrow_up_left_circle_fill = "arrow-up-left-circle-fill"
    /// arrow-up-left-square
    /// bi bi-arrow-up-left-square
    case arrow_up_left_square = "arrow-up-left-square"
    /// arrow-up-left-square-fill
    /// bi bi-arrow-up-left-square-fill
    case arrow_up_left_square_fill = "arrow-up-left-square-fill"
    /// arrow-up-right
    /// bi bi-arrow-up-right
    case arrow_up_right = "arrow-up-right"
    /// arrow-up-right-circle
    /// bi bi-arrow-up-right-circle
    case arrow_up_right_circle = "arrow-up-right-circle"
    /// arrow-up-right-circle-fill
    /// bi bi-arrow-up-right-circle-fill
    case arrow_up_right_circle_fill = "arrow-up-right-circle-fill"
    /// arrow-up-right-square
    /// bi bi-arrow-up-right-square
    case arrow_up_right_square = "arrow-up-right-square"
    /// arrow-up-right-square-fill
    /// bi bi-arrow-up-right-square-fill
    case arrow_up_right_square_fill = "arrow-up-right-square-fill"
    /// arrow-up-short
    /// bi bi-arrow-up-short
    case arrow_up_short = "arrow-up-short"
    /// arrow-up-square
    /// bi bi-arrow-up-square
    case arrow_up_square = "arrow-up-square"
    /// arrow-up-square-fill
    /// bi bi-arrow-up-square-fill
    case arrow_up_square_fill = "arrow-up-square-fill"
    /// arrows
    /// bi bi-arrows
    case arrows = "arrows"
    /// arrows-angle-contract
    /// bi bi-arrows-angle-contract
    case arrows_angle_contract = "arrows-angle-contract"
    /// arrows-angle-expand
    /// bi bi-arrows-angle-expand
    case arrows_angle_expand = "arrows-angle-expand"
    /// arrows-collapse
    /// bi bi-arrows-collapse
    case arrows_collapse = "arrows-collapse"
    /// arrows-collapse-vertical
    /// bi bi-arrows-collapse-vertical
    case arrows_collapse_vertical = "arrows-collapse-vertical"
    /// arrows-expand
    /// bi bi-arrows-expand
    case arrows_expand = "arrows-expand"
    /// arrows-expand-vertical
    /// bi bi-arrows-expand-vertical
    case arrows_expand_vertical = "arrows-expand-vertical"
    /// arrows-fullscreen
    /// bi bi-arrows-fullscreen
    case arrows_fullscreen = "arrows-fullscreen"
    /// arrows-move
    /// bi bi-arrows-move
    case arrows_move = "arrows-move"
    /// arrows-vertical
    /// bi bi-arrows-vertical
    case arrows_vertical = "arrows-vertical"
    /// aspect-ratio
    /// bi bi-aspect-ratio
    case aspect_ratio = "aspect-ratio"
    /// aspect-ratio-fill
    /// bi bi-aspect-ratio-fill
    case aspect_ratio_fill = "aspect-ratio-fill"
    /// asterisk
    /// bi bi-asterisk
    case asterisk = "asterisk"
    /// at
    /// bi bi-at
    case at = "at"
    /// award
    /// bi bi-award
    case award = "award"
    /// award-fill
    /// bi bi-award-fill
    case award_fill = "award-fill"
    /// back
    /// bi bi-back
    case back = "back"
    /// backpack
    /// bi bi-backpack
    case backpack = "backpack"
    /// backpack-fill
    /// bi bi-backpack-fill
    case backpack_fill = "backpack-fill"
    /// backpack2
    /// bi bi-backpack2
    case backpack2 = "backpack2"
    /// backpack2-fill
    /// bi bi-backpack2-fill
    case backpack2_fill = "backpack2-fill"
    /// backpack3
    /// bi bi-backpack3
    case backpack3 = "backpack3"
    /// backpack3-fill
    /// bi bi-backpack3-fill
    case backpack3_fill = "backpack3-fill"
    /// backpack4
    /// bi bi-backpack4
    case backpack4 = "backpack4"
    /// backpack4-fill
    /// bi bi-backpack4-fill
    case backpack4_fill = "backpack4-fill"
    /// backspace
    /// bi bi-backspace
    case backspace = "backspace"
    /// backspace-fill
    /// bi bi-backspace-fill
    case backspace_fill = "backspace-fill"
    /// backspace-reverse
    /// bi bi-backspace-reverse
    case backspace_reverse = "backspace-reverse"
    /// backspace-reverse-fill
    /// bi bi-backspace-reverse-fill
    case backspace_reverse_fill = "backspace-reverse-fill"
    /// badge-3d
    /// bi bi-badge-3d
    case badge_3d = "badge-3d"
    /// badge-3d-fill
    /// bi bi-badge-3d-fill
    case badge_3d_fill = "badge-3d-fill"
    /// badge-4k
    /// bi bi-badge-4k
    case badge_4k = "badge-4k"
    /// badge-4k-fill
    /// bi bi-badge-4k-fill
    case badge_4k_fill = "badge-4k-fill"
    /// badge-8k
    /// bi bi-badge-8k
    case badge_8k = "badge-8k"
    /// badge-8k-fill
    /// bi bi-badge-8k-fill
    case badge_8k_fill = "badge-8k-fill"
    /// badge-ad
    /// bi bi-badge-ad
    case badge_ad = "badge-ad"
    /// badge-ad-fill
    /// bi bi-badge-ad-fill
    case badge_ad_fill = "badge-ad-fill"
    /// badge-ar
    /// bi bi-badge-ar
    case badge_ar = "badge-ar"
    /// badge-ar-fill
    /// bi bi-badge-ar-fill
    case badge_ar_fill = "badge-ar-fill"
    /// badge-cc
    /// bi bi-badge-cc
    case badge_cc = "badge-cc"
    /// badge-cc-fill
    /// bi bi-badge-cc-fill
    case badge_cc_fill = "badge-cc-fill"
    /// badge-hd
    /// bi bi-badge-hd
    case badge_hd = "badge-hd"
    /// badge-hd-fill
    /// bi bi-badge-hd-fill
    case badge_hd_fill = "badge-hd-fill"
    /// badge-sd
    /// bi bi-badge-sd
    case badge_sd = "badge-sd"
    /// badge-sd-fill
    /// bi bi-badge-sd-fill
    case badge_sd_fill = "badge-sd-fill"
    /// badge-tm
    /// bi bi-badge-tm
    case badge_tm = "badge-tm"
    /// badge-tm-fill
    /// bi bi-badge-tm-fill
    case badge_tm_fill = "badge-tm-fill"
    /// badge-vo
    /// bi bi-badge-vo
    case badge_vo = "badge-vo"
    /// badge-vo-fill
    /// bi bi-badge-vo-fill
    case badge_vo_fill = "badge-vo-fill"
    /// badge-vr
    /// bi bi-badge-vr
    case badge_vr = "badge-vr"
    /// badge-vr-fill
    /// bi bi-badge-vr-fill
    case badge_vr_fill = "badge-vr-fill"
    /// badge-wc
    /// bi bi-badge-wc
    case badge_wc = "badge-wc"
    /// badge-wc-fill
    /// bi bi-badge-wc-fill
    case badge_wc_fill = "badge-wc-fill"
    /// bag
    /// bi bi-bag
    case bag = "bag"
    /// bag-check
    /// bi bi-bag-check
    case bag_check = "bag-check"
    /// bag-check-fill
    /// bi bi-bag-check-fill
    case bag_check_fill = "bag-check-fill"
    /// bag-dash
    /// bi bi-bag-dash
    case bag_dash = "bag-dash"
    /// bag-dash-fill
    /// bi bi-bag-dash-fill
    case bag_dash_fill = "bag-dash-fill"
    /// bag-fill
    /// bi bi-bag-fill
    case bag_fill = "bag-fill"
    /// bag-heart
    /// bi bi-bag-heart
    case bag_heart = "bag-heart"
    /// bag-heart-fill
    /// bi bi-bag-heart-fill
    case bag_heart_fill = "bag-heart-fill"
    /// bag-plus
    /// bi bi-bag-plus
    case bag_plus = "bag-plus"
    /// bag-plus-fill
    /// bi bi-bag-plus-fill
    case bag_plus_fill = "bag-plus-fill"
    /// bag-x
    /// bi bi-bag-x
    case bag_x = "bag-x"
    /// bag-x-fill
    /// bi bi-bag-x-fill
    case bag_x_fill = "bag-x-fill"
    /// balloon
    /// bi bi-balloon
    case balloon = "balloon"
    /// balloon-fill
    /// bi bi-balloon-fill
    case balloon_fill = "balloon-fill"
    /// balloon-heart
    /// bi bi-balloon-heart
    case balloon_heart = "balloon-heart"
    /// balloon-heart-fill
    /// bi bi-balloon-heart-fill
    case balloon_heart_fill = "balloon-heart-fill"
    /// ban
    /// bi bi-ban
    case ban = "ban"
    /// ban-fill
    /// bi bi-ban-fill
    case ban_fill = "ban-fill"
    /// bandaid
    /// bi bi-bandaid
    case bandaid = "bandaid"
    /// bandaid-fill
    /// bi bi-bandaid-fill
    case bandaid_fill = "bandaid-fill"
    /// bank
    /// bi bi-bank
    case bank = "bank"
    /// bank2
    /// bi bi-bank2
    case bank2 = "bank2"
    /// bar-chart
    /// bi bi-bar-chart
    case bar_chart = "bar-chart"
    /// bar-chart-fill
    /// bi bi-bar-chart-fill
    case bar_chart_fill = "bar-chart-fill"
    /// bar-chart-line
    /// bi bi-bar-chart-line
    case bar_chart_line = "bar-chart-line"
    /// bar-chart-line-fill
    /// bi bi-bar-chart-line-fill
    case bar_chart_line_fill = "bar-chart-line-fill"
    /// bar-chart-steps
    /// bi bi-bar-chart-steps
    case bar_chart_steps = "bar-chart-steps"
    /// basket
    /// bi bi-basket
    case basket = "basket"
    /// basket-fill
    /// bi bi-basket-fill
    case basket_fill = "basket-fill"
    /// basket2
    /// bi bi-basket2
    case basket2 = "basket2"
    /// basket2-fill
    /// bi bi-basket2-fill
    case basket2_fill = "basket2-fill"
    /// basket3
    /// bi bi-basket3
    case basket3 = "basket3"
    /// basket3-fill
    /// bi bi-basket3-fill
    case basket3_fill = "basket3-fill"
    /// battery
    /// bi bi-battery
    case battery = "battery"
    /// battery-charging
    /// bi bi-battery-charging
    case battery_charging = "battery-charging"
    /// battery-full
    /// bi bi-battery-full
    case battery_full = "battery-full"
    /// battery-half
    /// bi bi-battery-half
    case battery_half = "battery-half"
    /// battery-low
    /// bi bi-battery-low
    case battery_low = "battery-low"
    /// beaker
    /// bi bi-beaker
    case beaker = "beaker"
    /// beaker-fill
    /// bi bi-beaker-fill
    case beaker_fill = "beaker-fill"
    /// behance
    /// bi bi-behance
    case behance = "behance"
    /// bell
    /// bi bi-bell
    case bell = "bell"
    /// bell-fill
    /// bi bi-bell-fill
    case bell_fill = "bell-fill"
    /// bell-slash
    /// bi bi-bell-slash
    case bell_slash = "bell-slash"
    /// bell-slash-fill
    /// bi bi-bell-slash-fill
    case bell_slash_fill = "bell-slash-fill"
    /// bezier
    /// bi bi-bezier
    case bezier = "bezier"
    /// bezier2
    /// bi bi-bezier2
    case bezier2 = "bezier2"
    /// bicycle
    /// bi bi-bicycle
    case bicycle = "bicycle"
    /// bing
    /// bi bi-bing
    case bing = "bing"
    /// binoculars
    /// bi bi-binoculars
    case binoculars = "binoculars"
    /// binoculars-fill
    /// bi bi-binoculars-fill
    case binoculars_fill = "binoculars-fill"
    /// blockquote-left
    /// bi bi-blockquote-left
    case blockquote_left = "blockquote-left"
    /// blockquote-right
    /// bi bi-blockquote-right
    case blockquote_right = "blockquote-right"
    /// bluesky
    /// bi bi-bluesky
    case bluesky = "bluesky"
    /// bluetooth
    /// bi bi-bluetooth
    case bluetooth = "bluetooth"
    /// body-text
    /// bi bi-body-text
    case body_text = "body-text"
    /// book
    /// bi bi-book
    case book = "book"
    /// book-fill
    /// bi bi-book-fill
    case book_fill = "book-fill"
    /// book-half
    /// bi bi-book-half
    case book_half = "book-half"
    /// bookmark
    /// bi bi-bookmark
    case bookmark = "bookmark"
    /// bookmark-check
    /// bi bi-bookmark-check
    case bookmark_check = "bookmark-check"
    /// bookmark-check-fill
    /// bi bi-bookmark-check-fill
    case bookmark_check_fill = "bookmark-check-fill"
    /// bookmark-dash
    /// bi bi-bookmark-dash
    case bookmark_dash = "bookmark-dash"
    /// bookmark-dash-fill
    /// bi bi-bookmark-dash-fill
    case bookmark_dash_fill = "bookmark-dash-fill"
    /// bookmark-fill
    /// bi bi-bookmark-fill
    case bookmark_fill = "bookmark-fill"
    /// bookmark-heart
    /// bi bi-bookmark-heart
    case bookmark_heart = "bookmark-heart"
    /// bookmark-heart-fill
    /// bi bi-bookmark-heart-fill
    case bookmark_heart_fill = "bookmark-heart-fill"
    /// bookmark-plus
    /// bi bi-bookmark-plus
    case bookmark_plus = "bookmark-plus"
    /// bookmark-plus-fill
    /// bi bi-bookmark-plus-fill
    case bookmark_plus_fill = "bookmark-plus-fill"
    /// bookmark-star
    /// bi bi-bookmark-star
    case bookmark_star = "bookmark-star"
    /// bookmark-star-fill
    /// bi bi-bookmark-star-fill
    case bookmark_star_fill = "bookmark-star-fill"
    /// bookmark-x
    /// bi bi-bookmark-x
    case bookmark_x = "bookmark-x"
    /// bookmark-x-fill
    /// bi bi-bookmark-x-fill
    case bookmark_x_fill = "bookmark-x-fill"
    /// bookmarks
    /// bi bi-bookmarks
    case bookmarks = "bookmarks"
    /// bookmarks-fill
    /// bi bi-bookmarks-fill
    case bookmarks_fill = "bookmarks-fill"
    /// bookshelf
    /// bi bi-bookshelf
    case bookshelf = "bookshelf"
    /// boombox
    /// bi bi-boombox
    case boombox = "boombox"
    /// boombox-fill
    /// bi bi-boombox-fill
    case boombox_fill = "boombox-fill"
    /// bootstrap
    /// bi bi-bootstrap
    case bootstrap = "bootstrap"
    /// bootstrap-fill
    /// bi bi-bootstrap-fill
    case bootstrap_fill = "bootstrap-fill"
    /// bootstrap-reboot
    /// bi bi-bootstrap-reboot
    case bootstrap_reboot = "bootstrap-reboot"
    /// border
    /// bi bi-border
    case border = "border"
    /// border-all
    /// bi bi-border-all
    case border_all = "border-all"
    /// border-bottom
    /// bi bi-border-bottom
    case border_bottom = "border-bottom"
    /// border-center
    /// bi bi-border-center
    case border_center = "border-center"
    /// border-inner
    /// bi bi-border-inner
    case border_inner = "border-inner"
    /// border-left
    /// bi bi-border-left
    case border_left = "border-left"
    /// border-middle
    /// bi bi-border-middle
    case border_middle = "border-middle"
    /// border-outer
    /// bi bi-border-outer
    case border_outer = "border-outer"
    /// border-right
    /// bi bi-border-right
    case border_right = "border-right"
    /// border-style
    /// bi bi-border-style
    case border_style = "border-style"
    /// border-top
    /// bi bi-border-top
    case border_top = "border-top"
    /// border-width
    /// bi bi-border-width
    case border_width = "border-width"
    /// bounding-box
    /// bi bi-bounding-box
    case bounding_box = "bounding-box"
    /// bounding-box-circles
    /// bi bi-bounding-box-circles
    case bounding_box_circles = "bounding-box-circles"
    /// box
    /// bi bi-box
    case box = "box"
    /// box-arrow-down
    /// bi bi-box-arrow-down
    case box_arrow_down = "box-arrow-down"
    /// box-arrow-down-left
    /// bi bi-box-arrow-down-left
    case box_arrow_down_left = "box-arrow-down-left"
    /// box-arrow-down-right
    /// bi bi-box-arrow-down-right
    case box_arrow_down_right = "box-arrow-down-right"
    /// box-arrow-in-down
    /// bi bi-box-arrow-in-down
    case box_arrow_in_down = "box-arrow-in-down"
    /// box-arrow-in-down-left
    /// bi bi-box-arrow-in-down-left
    case box_arrow_in_down_left = "box-arrow-in-down-left"
    /// box-arrow-in-down-right
    /// bi bi-box-arrow-in-down-right
    case box_arrow_in_down_right = "box-arrow-in-down-right"
    /// box-arrow-in-left
    /// bi bi-box-arrow-in-left
    case box_arrow_in_left = "box-arrow-in-left"
    /// box-arrow-in-right
    /// bi bi-box-arrow-in-right
    case box_arrow_in_right = "box-arrow-in-right"
    /// box-arrow-in-up
    /// bi bi-box-arrow-in-up
    case box_arrow_in_up = "box-arrow-in-up"
    /// box-arrow-in-up-left
    /// bi bi-box-arrow-in-up-left
    case box_arrow_in_up_left = "box-arrow-in-up-left"
    /// box-arrow-in-up-right
    /// bi bi-box-arrow-in-up-right
    case box_arrow_in_up_right = "box-arrow-in-up-right"
    /// box-arrow-left
    /// bi bi-box-arrow-left
    case box_arrow_left = "box-arrow-left"
    /// box-arrow-right
    /// bi bi-box-arrow-right
    case box_arrow_right = "box-arrow-right"
    /// box-arrow-up
    /// bi bi-box-arrow-up
    case box_arrow_up = "box-arrow-up"
    /// box-arrow-up-left
    /// bi bi-box-arrow-up-left
    case box_arrow_up_left = "box-arrow-up-left"
    /// box-arrow-up-right
    /// bi bi-box-arrow-up-right
    case box_arrow_up_right = "box-arrow-up-right"
    /// box-fill
    /// bi bi-box-fill
    case box_fill = "box-fill"
    /// box-seam
    /// bi bi-box-seam
    case box_seam = "box-seam"
    /// box-seam-fill
    /// bi bi-box-seam-fill
    case box_seam_fill = "box-seam-fill"
    /// box2
    /// bi bi-box2
    case box2 = "box2"
    /// box2-fill
    /// bi bi-box2-fill
    case box2_fill = "box2-fill"
    /// box2-heart
    /// bi bi-box2-heart
    case box2_heart = "box2-heart"
    /// box2-heart-fill
    /// bi bi-box2-heart-fill
    case box2_heart_fill = "box2-heart-fill"
    /// boxes
    /// bi bi-boxes
    case boxes = "boxes"
    /// braces
    /// bi bi-braces
    case braces = "braces"
    /// braces-asterisk
    /// bi bi-braces-asterisk
    case braces_asterisk = "braces-asterisk"
    /// bricks
    /// bi bi-bricks
    case bricks = "bricks"
    /// briefcase
    /// bi bi-briefcase
    case briefcase = "briefcase"
    /// briefcase-fill
    /// bi bi-briefcase-fill
    case briefcase_fill = "briefcase-fill"
    /// brightness-alt-high
    /// bi bi-brightness-alt-high
    case brightness_alt_high = "brightness-alt-high"
    /// brightness-alt-high-fill
    /// bi bi-brightness-alt-high-fill
    case brightness_alt_high_fill = "brightness-alt-high-fill"
    /// brightness-alt-low
    /// bi bi-brightness-alt-low
    case brightness_alt_low = "brightness-alt-low"
    /// brightness-alt-low-fill
    /// bi bi-brightness-alt-low-fill
    case brightness_alt_low_fill = "brightness-alt-low-fill"
    /// brightness-high
    /// bi bi-brightness-high
    case brightness_high = "brightness-high"
    /// brightness-high-fill
    /// bi bi-brightness-high-fill
    case brightness_high_fill = "brightness-high-fill"
    /// brightness-low
    /// bi bi-brightness-low
    case brightness_low = "brightness-low"
    /// brightness-low-fill
    /// bi bi-brightness-low-fill
    case brightness_low_fill = "brightness-low-fill"
    /// brilliance
    /// bi bi-brilliance
    case brilliance = "brilliance"
    /// broadcast
    /// bi bi-broadcast
    case broadcast = "broadcast"
    /// broadcast-pin
    /// bi bi-broadcast-pin
    case broadcast_pin = "broadcast-pin"
    /// browser-chrome
    /// bi bi-browser-chrome
    case browser_chrome = "browser-chrome"
    /// browser-edge
    /// bi bi-browser-edge
    case browser_edge = "browser-edge"
    /// browser-firefox
    /// bi bi-browser-firefox
    case browser_firefox = "browser-firefox"
    /// browser-safari
    /// bi bi-browser-safari
    case browser_safari = "browser-safari"
    /// brush
    /// bi bi-brush
    case brush = "brush"
    /// brush-fill
    /// bi bi-brush-fill
    case brush_fill = "brush-fill"
    /// bucket
    /// bi bi-bucket
    case bucket = "bucket"
    /// bucket-fill
    /// bi bi-bucket-fill
    case bucket_fill = "bucket-fill"
    /// bug
    /// bi bi-bug
    case bug = "bug"
    /// bug-fill
    /// bi bi-bug-fill
    case bug_fill = "bug-fill"
    /// building
    /// bi bi-building
    case building = "building"
    /// building-add
    /// bi bi-building-add
    case building_add = "building-add"
    /// building-check
    /// bi bi-building-check
    case building_check = "building-check"
    /// building-dash
    /// bi bi-building-dash
    case building_dash = "building-dash"
    /// building-down
    /// bi bi-building-down
    case building_down = "building-down"
    /// building-exclamation
    /// bi bi-building-exclamation
    case building_exclamation = "building-exclamation"
    /// building-fill
    /// bi bi-building-fill
    case building_fill = "building-fill"
    /// building-fill-add
    /// bi bi-building-fill-add
    case building_fill_add = "building-fill-add"
    /// building-fill-check
    /// bi bi-building-fill-check
    case building_fill_check = "building-fill-check"
    /// building-fill-dash
    /// bi bi-building-fill-dash
    case building_fill_dash = "building-fill-dash"
    /// building-fill-down
    /// bi bi-building-fill-down
    case building_fill_down = "building-fill-down"
    /// building-fill-exclamation
    /// bi bi-building-fill-exclamation
    case building_fill_exclamation = "building-fill-exclamation"
    /// building-fill-gear
    /// bi bi-building-fill-gear
    case building_fill_gear = "building-fill-gear"
    /// building-fill-lock
    /// bi bi-building-fill-lock
    case building_fill_lock = "building-fill-lock"
    /// building-fill-slash
    /// bi bi-building-fill-slash
    case building_fill_slash = "building-fill-slash"
    /// building-fill-up
    /// bi bi-building-fill-up
    case building_fill_up = "building-fill-up"
    /// building-fill-x
    /// bi bi-building-fill-x
    case building_fill_x = "building-fill-x"
    /// building-gear
    /// bi bi-building-gear
    case building_gear = "building-gear"
    /// building-lock
    /// bi bi-building-lock
    case building_lock = "building-lock"
    /// building-slash
    /// bi bi-building-slash
    case building_slash = "building-slash"
    /// building-up
    /// bi bi-building-up
    case building_up = "building-up"
    /// building-x
    /// bi bi-building-x
    case building_x = "building-x"
    /// buildings
    /// bi bi-buildings
    case buildings = "buildings"
    /// buildings-fill
    /// bi bi-buildings-fill
    case buildings_fill = "buildings-fill"
    /// bullseye
    /// bi bi-bullseye
    case bullseye = "bullseye"
    /// bus-front
    /// bi bi-bus-front
    case bus_front = "bus-front"
    /// bus-front-fill
    /// bi bi-bus-front-fill
    case bus_front_fill = "bus-front-fill"
    /// c-circle
    /// bi bi-c-circle
    case c_circle = "c-circle"
    /// c-circle-fill
    /// bi bi-c-circle-fill
    case c_circle_fill = "c-circle-fill"
    /// c-square
    /// bi bi-c-square
    case c_square = "c-square"
    /// c-square-fill
    /// bi bi-c-square-fill
    case c_square_fill = "c-square-fill"
    /// cake
    /// bi bi-cake
    case cake = "cake"
    /// cake-fill
    /// bi bi-cake-fill
    case cake_fill = "cake-fill"
    /// cake2
    /// bi bi-cake2
    case cake2 = "cake2"
    /// cake2-fill
    /// bi bi-cake2-fill
    case cake2_fill = "cake2-fill"
    /// calculator
    /// bi bi-calculator
    case calculator = "calculator"
    /// calculator-fill
    /// bi bi-calculator-fill
    case calculator_fill = "calculator-fill"
    /// calendar
    /// bi bi-calendar
    case calendar = "calendar"
    /// calendar-check
    /// bi bi-calendar-check
    case calendar_check = "calendar-check"
    /// calendar-check-fill
    /// bi bi-calendar-check-fill
    case calendar_check_fill = "calendar-check-fill"
    /// calendar-date
    /// bi bi-calendar-date
    case calendar_date = "calendar-date"
    /// calendar-date-fill
    /// bi bi-calendar-date-fill
    case calendar_date_fill = "calendar-date-fill"
    /// calendar-day
    /// bi bi-calendar-day
    case calendar_day = "calendar-day"
    /// calendar-day-fill
    /// bi bi-calendar-day-fill
    case calendar_day_fill = "calendar-day-fill"
    /// calendar-event
    /// bi bi-calendar-event
    case calendar_event = "calendar-event"
    /// calendar-event-fill
    /// bi bi-calendar-event-fill
    case calendar_event_fill = "calendar-event-fill"
    /// calendar-fill
    /// bi bi-calendar-fill
    case calendar_fill = "calendar-fill"
    /// calendar-heart
    /// bi bi-calendar-heart
    case calendar_heart = "calendar-heart"
    /// calendar-heart-fill
    /// bi bi-calendar-heart-fill
    case calendar_heart_fill = "calendar-heart-fill"
    /// calendar-minus
    /// bi bi-calendar-minus
    case calendar_minus = "calendar-minus"
    /// calendar-minus-fill
    /// bi bi-calendar-minus-fill
    case calendar_minus_fill = "calendar-minus-fill"
    /// calendar-month
    /// bi bi-calendar-month
    case calendar_month = "calendar-month"
    /// calendar-month-fill
    /// bi bi-calendar-month-fill
    case calendar_month_fill = "calendar-month-fill"
    /// calendar-plus
    /// bi bi-calendar-plus
    case calendar_plus = "calendar-plus"
    /// calendar-plus-fill
    /// bi bi-calendar-plus-fill
    case calendar_plus_fill = "calendar-plus-fill"
    /// calendar-range
    /// bi bi-calendar-range
    case calendar_range = "calendar-range"
    /// calendar-range-fill
    /// bi bi-calendar-range-fill
    case calendar_range_fill = "calendar-range-fill"
    /// calendar-week
    /// bi bi-calendar-week
    case calendar_week = "calendar-week"
    /// calendar-week-fill
    /// bi bi-calendar-week-fill
    case calendar_week_fill = "calendar-week-fill"
    /// calendar-x
    /// bi bi-calendar-x
    case calendar_x = "calendar-x"
    /// calendar-x-fill
    /// bi bi-calendar-x-fill
    case calendar_x_fill = "calendar-x-fill"
    /// calendar2
    /// bi bi-calendar2
    case calendar2 = "calendar2"
    /// calendar2-check
    /// bi bi-calendar2-check
    case calendar2_check = "calendar2-check"
    /// calendar2-check-fill
    /// bi bi-calendar2-check-fill
    case calendar2_check_fill = "calendar2-check-fill"
    /// calendar2-date
    /// bi bi-calendar2-date
    case calendar2_date = "calendar2-date"
    /// calendar2-date-fill
    /// bi bi-calendar2-date-fill
    case calendar2_date_fill = "calendar2-date-fill"
    /// calendar2-day
    /// bi bi-calendar2-day
    case calendar2_day = "calendar2-day"
    /// calendar2-day-fill
    /// bi bi-calendar2-day-fill
    case calendar2_day_fill = "calendar2-day-fill"
    /// calendar2-event
    /// bi bi-calendar2-event
    case calendar2_event = "calendar2-event"
    /// calendar2-event-fill
    /// bi bi-calendar2-event-fill
    case calendar2_event_fill = "calendar2-event-fill"
    /// calendar2-fill
    /// bi bi-calendar2-fill
    case calendar2_fill = "calendar2-fill"
    /// calendar2-heart
    /// bi bi-calendar2-heart
    case calendar2_heart = "calendar2-heart"
    /// calendar2-heart-fill
    /// bi bi-calendar2-heart-fill
    case calendar2_heart_fill = "calendar2-heart-fill"
    /// calendar2-minus
    /// bi bi-calendar2-minus
    case calendar2_minus = "calendar2-minus"
    /// calendar2-minus-fill
    /// bi bi-calendar2-minus-fill
    case calendar2_minus_fill = "calendar2-minus-fill"
    /// calendar2-month
    /// bi bi-calendar2-month
    case calendar2_month = "calendar2-month"
    /// calendar2-month-fill
    /// bi bi-calendar2-month-fill
    case calendar2_month_fill = "calendar2-month-fill"
    /// calendar2-plus
    /// bi bi-calendar2-plus
    case calendar2_plus = "calendar2-plus"
    /// calendar2-plus-fill
    /// bi bi-calendar2-plus-fill
    case calendar2_plus_fill = "calendar2-plus-fill"
    /// calendar2-range
    /// bi bi-calendar2-range
    case calendar2_range = "calendar2-range"
    /// calendar2-range-fill
    /// bi bi-calendar2-range-fill
    case calendar2_range_fill = "calendar2-range-fill"
    /// calendar2-week
    /// bi bi-calendar2-week
    case calendar2_week = "calendar2-week"
    /// calendar2-week-fill
    /// bi bi-calendar2-week-fill
    case calendar2_week_fill = "calendar2-week-fill"
    /// calendar2-x
    /// bi bi-calendar2-x
    case calendar2_x = "calendar2-x"
    /// calendar2-x-fill
    /// bi bi-calendar2-x-fill
    case calendar2_x_fill = "calendar2-x-fill"
    /// calendar3
    /// bi bi-calendar3
    case calendar3 = "calendar3"
    /// calendar3-event
    /// bi bi-calendar3-event
    case calendar3_event = "calendar3-event"
    /// calendar3-event-fill
    /// bi bi-calendar3-event-fill
    case calendar3_event_fill = "calendar3-event-fill"
    /// calendar3-fill
    /// bi bi-calendar3-fill
    case calendar3_fill = "calendar3-fill"
    /// calendar3-range
    /// bi bi-calendar3-range
    case calendar3_range = "calendar3-range"
    /// calendar3-range-fill
    /// bi bi-calendar3-range-fill
    case calendar3_range_fill = "calendar3-range-fill"
    /// calendar3-week
    /// bi bi-calendar3-week
    case calendar3_week = "calendar3-week"
    /// calendar3-week-fill
    /// bi bi-calendar3-week-fill
    case calendar3_week_fill = "calendar3-week-fill"
    /// calendar4
    /// bi bi-calendar4
    case calendar4 = "calendar4"
    /// calendar4-event
    /// bi bi-calendar4-event
    case calendar4_event = "calendar4-event"
    /// calendar4-range
    /// bi bi-calendar4-range
    case calendar4_range = "calendar4-range"
    /// calendar4-week
    /// bi bi-calendar4-week
    case calendar4_week = "calendar4-week"
    /// camera
    /// bi bi-camera
    case camera = "camera"
    /// camera-fill
    /// bi bi-camera-fill
    case camera_fill = "camera-fill"
    /// camera-reels
    /// bi bi-camera-reels
    case camera_reels = "camera-reels"
    /// camera-reels-fill
    /// bi bi-camera-reels-fill
    case camera_reels_fill = "camera-reels-fill"
    /// camera-video
    /// bi bi-camera-video
    case camera_video = "camera-video"
    /// camera-video-fill
    /// bi bi-camera-video-fill
    case camera_video_fill = "camera-video-fill"
    /// camera-video-off
    /// bi bi-camera-video-off
    case camera_video_off = "camera-video-off"
    /// camera-video-off-fill
    /// bi bi-camera-video-off-fill
    case camera_video_off_fill = "camera-video-off-fill"
    /// camera2
    /// bi bi-camera2
    case camera2 = "camera2"
    /// capslock
    /// bi bi-capslock
    case capslock = "capslock"
    /// capslock-fill
    /// bi bi-capslock-fill
    case capslock_fill = "capslock-fill"
    /// capsule
    /// bi bi-capsule
    case capsule = "capsule"
    /// capsule-pill
    /// bi bi-capsule-pill
    case capsule_pill = "capsule-pill"
    /// car-front
    /// bi bi-car-front
    case car_front = "car-front"
    /// car-front-fill
    /// bi bi-car-front-fill
    case car_front_fill = "car-front-fill"
    /// card-checklist
    /// bi bi-card-checklist
    case card_checklist = "card-checklist"
    /// card-heading
    /// bi bi-card-heading
    case card_heading = "card-heading"
    /// card-image
    /// bi bi-card-image
    case card_image = "card-image"
    /// card-list
    /// bi bi-card-list
    case card_list = "card-list"
    /// card-text
    /// bi bi-card-text
    case card_text = "card-text"
    /// caret-down
    /// bi bi-caret-down
    case caret_down = "caret-down"
    /// caret-down-fill
    /// bi bi-caret-down-fill
    case caret_down_fill = "caret-down-fill"
    /// caret-down-square
    /// bi bi-caret-down-square
    case caret_down_square = "caret-down-square"
    /// caret-down-square-fill
    /// bi bi-caret-down-square-fill
    case caret_down_square_fill = "caret-down-square-fill"
    /// caret-left
    /// bi bi-caret-left
    case caret_left = "caret-left"
    /// caret-left-fill
    /// bi bi-caret-left-fill
    case caret_left_fill = "caret-left-fill"
    /// caret-left-square
    /// bi bi-caret-left-square
    case caret_left_square = "caret-left-square"
    /// caret-left-square-fill
    /// bi bi-caret-left-square-fill
    case caret_left_square_fill = "caret-left-square-fill"
    /// caret-right
    /// bi bi-caret-right
    case caret_right = "caret-right"
    /// caret-right-fill
    /// bi bi-caret-right-fill
    case caret_right_fill = "caret-right-fill"
    /// caret-right-square
    /// bi bi-caret-right-square
    case caret_right_square = "caret-right-square"
    /// caret-right-square-fill
    /// bi bi-caret-right-square-fill
    case caret_right_square_fill = "caret-right-square-fill"
    /// caret-up
    /// bi bi-caret-up
    case caret_up = "caret-up"
    /// caret-up-fill
    /// bi bi-caret-up-fill
    case caret_up_fill = "caret-up-fill"
    /// caret-up-square
    /// bi bi-caret-up-square
    case caret_up_square = "caret-up-square"
    /// caret-up-square-fill
    /// bi bi-caret-up-square-fill
    case caret_up_square_fill = "caret-up-square-fill"
    /// cart
    /// bi bi-cart
    case cart = "cart"
    /// cart-check
    /// bi bi-cart-check
    case cart_check = "cart-check"
    /// cart-check-fill
    /// bi bi-cart-check-fill
    case cart_check_fill = "cart-check-fill"
    /// cart-dash
    /// bi bi-cart-dash
    case cart_dash = "cart-dash"
    /// cart-dash-fill
    /// bi bi-cart-dash-fill
    case cart_dash_fill = "cart-dash-fill"
    /// cart-fill
    /// bi bi-cart-fill
    case cart_fill = "cart-fill"
    /// cart-plus
    /// bi bi-cart-plus
    case cart_plus = "cart-plus"
    /// cart-plus-fill
    /// bi bi-cart-plus-fill
    case cart_plus_fill = "cart-plus-fill"
    /// cart-x
    /// bi bi-cart-x
    case cart_x = "cart-x"
    /// cart-x-fill
    /// bi bi-cart-x-fill
    case cart_x_fill = "cart-x-fill"
    /// cart2
    /// bi bi-cart2
    case cart2 = "cart2"
    /// cart3
    /// bi bi-cart3
    case cart3 = "cart3"
    /// cart4
    /// bi bi-cart4
    case cart4 = "cart4"
    /// cash
    /// bi bi-cash
    case cash = "cash"
    /// cash-coin
    /// bi bi-cash-coin
    case cash_coin = "cash-coin"
    /// cash-stack
    /// bi bi-cash-stack
    case cash_stack = "cash-stack"
    /// cassette
    /// bi bi-cassette
    case cassette = "cassette"
    /// cassette-fill
    /// bi bi-cassette-fill
    case cassette_fill = "cassette-fill"
    /// cast
    /// bi bi-cast
    case cast = "cast"
    /// cc-circle
    /// bi bi-cc-circle
    case cc_circle = "cc-circle"
    /// cc-circle-fill
    /// bi bi-cc-circle-fill
    case cc_circle_fill = "cc-circle-fill"
    /// cc-square
    /// bi bi-cc-square
    case cc_square = "cc-square"
    /// cc-square-fill
    /// bi bi-cc-square-fill
    case cc_square_fill = "cc-square-fill"
    /// chat
    /// bi bi-chat
    case chat = "chat"
    /// chat-dots
    /// bi bi-chat-dots
    case chat_dots = "chat-dots"
    /// chat-dots-fill
    /// bi bi-chat-dots-fill
    case chat_dots_fill = "chat-dots-fill"
    /// chat-fill
    /// bi bi-chat-fill
    case chat_fill = "chat-fill"
    /// chat-heart
    /// bi bi-chat-heart
    case chat_heart = "chat-heart"
    /// chat-heart-fill
    /// bi bi-chat-heart-fill
    case chat_heart_fill = "chat-heart-fill"
    /// chat-left
    /// bi bi-chat-left
    case chat_left = "chat-left"
    /// chat-left-dots
    /// bi bi-chat-left-dots
    case chat_left_dots = "chat-left-dots"
    /// chat-left-dots-fill
    /// bi bi-chat-left-dots-fill
    case chat_left_dots_fill = "chat-left-dots-fill"
    /// chat-left-fill
    /// bi bi-chat-left-fill
    case chat_left_fill = "chat-left-fill"
    /// chat-left-heart
    /// bi bi-chat-left-heart
    case chat_left_heart = "chat-left-heart"
    /// chat-left-heart-fill
    /// bi bi-chat-left-heart-fill
    case chat_left_heart_fill = "chat-left-heart-fill"
    /// chat-left-quote
    /// bi bi-chat-left-quote
    case chat_left_quote = "chat-left-quote"
    /// chat-left-quote-fill
    /// bi bi-chat-left-quote-fill
    case chat_left_quote_fill = "chat-left-quote-fill"
    /// chat-left-text
    /// bi bi-chat-left-text
    case chat_left_text = "chat-left-text"
    /// chat-left-text-fill
    /// bi bi-chat-left-text-fill
    case chat_left_text_fill = "chat-left-text-fill"
    /// chat-quote
    /// bi bi-chat-quote
    case chat_quote = "chat-quote"
    /// chat-quote-fill
    /// bi bi-chat-quote-fill
    case chat_quote_fill = "chat-quote-fill"
    /// chat-right
    /// bi bi-chat-right
    case chat_right = "chat-right"
    /// chat-right-dots
    /// bi bi-chat-right-dots
    case chat_right_dots = "chat-right-dots"
    /// chat-right-dots-fill
    /// bi bi-chat-right-dots-fill
    case chat_right_dots_fill = "chat-right-dots-fill"
    /// chat-right-fill
    /// bi bi-chat-right-fill
    case chat_right_fill = "chat-right-fill"
    /// chat-right-heart
    /// bi bi-chat-right-heart
    case chat_right_heart = "chat-right-heart"
    /// chat-right-heart-fill
    /// bi bi-chat-right-heart-fill
    case chat_right_heart_fill = "chat-right-heart-fill"
    /// chat-right-quote
    /// bi bi-chat-right-quote
    case chat_right_quote = "chat-right-quote"
    /// chat-right-quote-fill
    /// bi bi-chat-right-quote-fill
    case chat_right_quote_fill = "chat-right-quote-fill"
    /// chat-right-text
    /// bi bi-chat-right-text
    case chat_right_text = "chat-right-text"
    /// chat-right-text-fill
    /// bi bi-chat-right-text-fill
    case chat_right_text_fill = "chat-right-text-fill"
    /// chat-square
    /// bi bi-chat-square
    case chat_square = "chat-square"
    /// chat-square-dots
    /// bi bi-chat-square-dots
    case chat_square_dots = "chat-square-dots"
    /// chat-square-dots-fill
    /// bi bi-chat-square-dots-fill
    case chat_square_dots_fill = "chat-square-dots-fill"
    /// chat-square-fill
    /// bi bi-chat-square-fill
    case chat_square_fill = "chat-square-fill"
    /// chat-square-heart
    /// bi bi-chat-square-heart
    case chat_square_heart = "chat-square-heart"
    /// chat-square-heart-fill
    /// bi bi-chat-square-heart-fill
    case chat_square_heart_fill = "chat-square-heart-fill"
    /// chat-square-quote
    /// bi bi-chat-square-quote
    case chat_square_quote = "chat-square-quote"
    /// chat-square-quote-fill
    /// bi bi-chat-square-quote-fill
    case chat_square_quote_fill = "chat-square-quote-fill"
    /// chat-square-text
    /// bi bi-chat-square-text
    case chat_square_text = "chat-square-text"
    /// chat-square-text-fill
    /// bi bi-chat-square-text-fill
    case chat_square_text_fill = "chat-square-text-fill"
    /// chat-text
    /// bi bi-chat-text
    case chat_text = "chat-text"
    /// chat-text-fill
    /// bi bi-chat-text-fill
    case chat_text_fill = "chat-text-fill"
    /// check
    /// bi bi-check
    case check = "check"
    /// check-all
    /// bi bi-check-all
    case check_all = "check-all"
    /// check-circle
    /// bi bi-check-circle
    case check_circle = "check-circle"
    /// check-circle-fill
    /// bi bi-check-circle-fill
    case check_circle_fill = "check-circle-fill"
    /// check-lg
    /// bi bi-check-lg
    case check_lg = "check-lg"
    /// check-square
    /// bi bi-check-square
    case check_square = "check-square"
    /// check-square-fill
    /// bi bi-check-square-fill
    case check_square_fill = "check-square-fill"
    /// check2
    /// bi bi-check2
    case check2 = "check2"
    /// check2-all
    /// bi bi-check2-all
    case check2_all = "check2-all"
    /// check2-circle
    /// bi bi-check2-circle
    case check2_circle = "check2-circle"
    /// check2-square
    /// bi bi-check2-square
    case check2_square = "check2-square"
    /// chevron-bar-contract
    /// bi bi-chevron-bar-contract
    case chevron_bar_contract = "chevron-bar-contract"
    /// chevron-bar-down
    /// bi bi-chevron-bar-down
    case chevron_bar_down = "chevron-bar-down"
    /// chevron-bar-expand
    /// bi bi-chevron-bar-expand
    case chevron_bar_expand = "chevron-bar-expand"
    /// chevron-bar-left
    /// bi bi-chevron-bar-left
    case chevron_bar_left = "chevron-bar-left"
    /// chevron-bar-right
    /// bi bi-chevron-bar-right
    case chevron_bar_right = "chevron-bar-right"
    /// chevron-bar-up
    /// bi bi-chevron-bar-up
    case chevron_bar_up = "chevron-bar-up"
    /// chevron-compact-down
    /// bi bi-chevron-compact-down
    case chevron_compact_down = "chevron-compact-down"
    /// chevron-compact-left
    /// bi bi-chevron-compact-left
    case chevron_compact_left = "chevron-compact-left"
    /// chevron-compact-right
    /// bi bi-chevron-compact-right
    case chevron_compact_right = "chevron-compact-right"
    /// chevron-compact-up
    /// bi bi-chevron-compact-up
    case chevron_compact_up = "chevron-compact-up"
    /// chevron-contract
    /// bi bi-chevron-contract
    case chevron_contract = "chevron-contract"
    /// chevron-double-down
    /// bi bi-chevron-double-down
    case chevron_double_down = "chevron-double-down"
    /// chevron-double-left
    /// bi bi-chevron-double-left
    case chevron_double_left = "chevron-double-left"
    /// chevron-double-right
    /// bi bi-chevron-double-right
    case chevron_double_right = "chevron-double-right"
    /// chevron-double-up
    /// bi bi-chevron-double-up
    case chevron_double_up = "chevron-double-up"
    /// chevron-down
    /// bi bi-chevron-down
    case chevron_down = "chevron-down"
    /// chevron-expand
    /// bi bi-chevron-expand
    case chevron_expand = "chevron-expand"
    /// chevron-left
    /// bi bi-chevron-left
    case chevron_left = "chevron-left"
    /// chevron-right
    /// bi bi-chevron-right
    case chevron_right = "chevron-right"
    /// chevron-up
    /// bi bi-chevron-up
    case chevron_up = "chevron-up"
    /// circle
    /// bi bi-circle
    case circle = "circle"
    /// circle-fill
    /// bi bi-circle-fill
    case circle_fill = "circle-fill"
    /// circle-half
    /// bi bi-circle-half
    case circle_half = "circle-half"
    /// circle-square
    /// bi bi-circle-square
    case circle_square = "circle-square"
    /// claude
    /// bi bi-claude
    case claude = "claude"
    /// clipboard
    /// bi bi-clipboard
    case clipboard = "clipboard"
    /// clipboard-check
    /// bi bi-clipboard-check
    case clipboard_check = "clipboard-check"
    /// clipboard-check-fill
    /// bi bi-clipboard-check-fill
    case clipboard_check_fill = "clipboard-check-fill"
    /// clipboard-data
    /// bi bi-clipboard-data
    case clipboard_data = "clipboard-data"
    /// clipboard-data-fill
    /// bi bi-clipboard-data-fill
    case clipboard_data_fill = "clipboard-data-fill"
    /// clipboard-fill
    /// bi bi-clipboard-fill
    case clipboard_fill = "clipboard-fill"
    /// clipboard-heart
    /// bi bi-clipboard-heart
    case clipboard_heart = "clipboard-heart"
    /// clipboard-heart-fill
    /// bi bi-clipboard-heart-fill
    case clipboard_heart_fill = "clipboard-heart-fill"
    /// clipboard-minus
    /// bi bi-clipboard-minus
    case clipboard_minus = "clipboard-minus"
    /// clipboard-minus-fill
    /// bi bi-clipboard-minus-fill
    case clipboard_minus_fill = "clipboard-minus-fill"
    /// clipboard-plus
    /// bi bi-clipboard-plus
    case clipboard_plus = "clipboard-plus"
    /// clipboard-plus-fill
    /// bi bi-clipboard-plus-fill
    case clipboard_plus_fill = "clipboard-plus-fill"
    /// clipboard-pulse
    /// bi bi-clipboard-pulse
    case clipboard_pulse = "clipboard-pulse"
    /// clipboard-x
    /// bi bi-clipboard-x
    case clipboard_x = "clipboard-x"
    /// clipboard-x-fill
    /// bi bi-clipboard-x-fill
    case clipboard_x_fill = "clipboard-x-fill"
    /// clipboard2
    /// bi bi-clipboard2
    case clipboard2 = "clipboard2"
    /// clipboard2-check
    /// bi bi-clipboard2-check
    case clipboard2_check = "clipboard2-check"
    /// clipboard2-check-fill
    /// bi bi-clipboard2-check-fill
    case clipboard2_check_fill = "clipboard2-check-fill"
    /// clipboard2-data
    /// bi bi-clipboard2-data
    case clipboard2_data = "clipboard2-data"
    /// clipboard2-data-fill
    /// bi bi-clipboard2-data-fill
    case clipboard2_data_fill = "clipboard2-data-fill"
    /// clipboard2-fill
    /// bi bi-clipboard2-fill
    case clipboard2_fill = "clipboard2-fill"
    /// clipboard2-heart
    /// bi bi-clipboard2-heart
    case clipboard2_heart = "clipboard2-heart"
    /// clipboard2-heart-fill
    /// bi bi-clipboard2-heart-fill
    case clipboard2_heart_fill = "clipboard2-heart-fill"
    /// clipboard2-minus
    /// bi bi-clipboard2-minus
    case clipboard2_minus = "clipboard2-minus"
    /// clipboard2-minus-fill
    /// bi bi-clipboard2-minus-fill
    case clipboard2_minus_fill = "clipboard2-minus-fill"
    /// clipboard2-plus
    /// bi bi-clipboard2-plus
    case clipboard2_plus = "clipboard2-plus"
    /// clipboard2-plus-fill
    /// bi bi-clipboard2-plus-fill
    case clipboard2_plus_fill = "clipboard2-plus-fill"
    /// clipboard2-pulse
    /// bi bi-clipboard2-pulse
    case clipboard2_pulse = "clipboard2-pulse"
    /// clipboard2-pulse-fill
    /// bi bi-clipboard2-pulse-fill
    case clipboard2_pulse_fill = "clipboard2-pulse-fill"
    /// clipboard2-x
    /// bi bi-clipboard2-x
    case clipboard2_x = "clipboard2-x"
    /// clipboard2-x-fill
    /// bi bi-clipboard2-x-fill
    case clipboard2_x_fill = "clipboard2-x-fill"
    /// clock
    /// bi bi-clock
    case clock = "clock"
    /// clock-fill
    /// bi bi-clock-fill
    case clock_fill = "clock-fill"
    /// clock-history
    /// bi bi-clock-history
    case clock_history = "clock-history"
    /// cloud
    /// bi bi-cloud
    case cloud = "cloud"
    /// cloud-arrow-down
    /// bi bi-cloud-arrow-down
    case cloud_arrow_down = "cloud-arrow-down"
    /// cloud-arrow-down-fill
    /// bi bi-cloud-arrow-down-fill
    case cloud_arrow_down_fill = "cloud-arrow-down-fill"
    /// cloud-arrow-up
    /// bi bi-cloud-arrow-up
    case cloud_arrow_up = "cloud-arrow-up"
    /// cloud-arrow-up-fill
    /// bi bi-cloud-arrow-up-fill
    case cloud_arrow_up_fill = "cloud-arrow-up-fill"
    /// cloud-check
    /// bi bi-cloud-check
    case cloud_check = "cloud-check"
    /// cloud-check-fill
    /// bi bi-cloud-check-fill
    case cloud_check_fill = "cloud-check-fill"
    /// cloud-download
    /// bi bi-cloud-download
    case cloud_download = "cloud-download"
    /// cloud-download-fill
    /// bi bi-cloud-download-fill
    case cloud_download_fill = "cloud-download-fill"
    /// cloud-drizzle
    /// bi bi-cloud-drizzle
    case cloud_drizzle = "cloud-drizzle"
    /// cloud-drizzle-fill
    /// bi bi-cloud-drizzle-fill
    case cloud_drizzle_fill = "cloud-drizzle-fill"
    /// cloud-fill
    /// bi bi-cloud-fill
    case cloud_fill = "cloud-fill"
    /// cloud-fog
    /// bi bi-cloud-fog
    case cloud_fog = "cloud-fog"
    /// cloud-fog-fill
    /// bi bi-cloud-fog-fill
    case cloud_fog_fill = "cloud-fog-fill"
    /// cloud-fog2
    /// bi bi-cloud-fog2
    case cloud_fog2 = "cloud-fog2"
    /// cloud-fog2-fill
    /// bi bi-cloud-fog2-fill
    case cloud_fog2_fill = "cloud-fog2-fill"
    /// cloud-hail
    /// bi bi-cloud-hail
    case cloud_hail = "cloud-hail"
    /// cloud-hail-fill
    /// bi bi-cloud-hail-fill
    case cloud_hail_fill = "cloud-hail-fill"
    /// cloud-haze
    /// bi bi-cloud-haze
    case cloud_haze = "cloud-haze"
    /// cloud-haze-fill
    /// bi bi-cloud-haze-fill
    case cloud_haze_fill = "cloud-haze-fill"
    /// cloud-haze2
    /// bi bi-cloud-haze2
    case cloud_haze2 = "cloud-haze2"
    /// cloud-haze2-fill
    /// bi bi-cloud-haze2-fill
    case cloud_haze2_fill = "cloud-haze2-fill"
    /// cloud-lightning
    /// bi bi-cloud-lightning
    case cloud_lightning = "cloud-lightning"
    /// cloud-lightning-fill
    /// bi bi-cloud-lightning-fill
    case cloud_lightning_fill = "cloud-lightning-fill"
    /// cloud-lightning-rain
    /// bi bi-cloud-lightning-rain
    case cloud_lightning_rain = "cloud-lightning-rain"
    /// cloud-lightning-rain-fill
    /// bi bi-cloud-lightning-rain-fill
    case cloud_lightning_rain_fill = "cloud-lightning-rain-fill"
    /// cloud-minus
    /// bi bi-cloud-minus
    case cloud_minus = "cloud-minus"
    /// cloud-minus-fill
    /// bi bi-cloud-minus-fill
    case cloud_minus_fill = "cloud-minus-fill"
    /// cloud-moon
    /// bi bi-cloud-moon
    case cloud_moon = "cloud-moon"
    /// cloud-moon-fill
    /// bi bi-cloud-moon-fill
    case cloud_moon_fill = "cloud-moon-fill"
    /// cloud-plus
    /// bi bi-cloud-plus
    case cloud_plus = "cloud-plus"
    /// cloud-plus-fill
    /// bi bi-cloud-plus-fill
    case cloud_plus_fill = "cloud-plus-fill"
    /// cloud-rain
    /// bi bi-cloud-rain
    case cloud_rain = "cloud-rain"
    /// cloud-rain-fill
    /// bi bi-cloud-rain-fill
    case cloud_rain_fill = "cloud-rain-fill"
    /// cloud-rain-heavy
    /// bi bi-cloud-rain-heavy
    case cloud_rain_heavy = "cloud-rain-heavy"
    /// cloud-rain-heavy-fill
    /// bi bi-cloud-rain-heavy-fill
    case cloud_rain_heavy_fill = "cloud-rain-heavy-fill"
    /// cloud-slash
    /// bi bi-cloud-slash
    case cloud_slash = "cloud-slash"
    /// cloud-slash-fill
    /// bi bi-cloud-slash-fill
    case cloud_slash_fill = "cloud-slash-fill"
    /// cloud-sleet
    /// bi bi-cloud-sleet
    case cloud_sleet = "cloud-sleet"
    /// cloud-sleet-fill
    /// bi bi-cloud-sleet-fill
    case cloud_sleet_fill = "cloud-sleet-fill"
    /// cloud-snow
    /// bi bi-cloud-snow
    case cloud_snow = "cloud-snow"
    /// cloud-snow-fill
    /// bi bi-cloud-snow-fill
    case cloud_snow_fill = "cloud-snow-fill"
    /// cloud-sun
    /// bi bi-cloud-sun
    case cloud_sun = "cloud-sun"
    /// cloud-sun-fill
    /// bi bi-cloud-sun-fill
    case cloud_sun_fill = "cloud-sun-fill"
    /// cloud-upload
    /// bi bi-cloud-upload
    case cloud_upload = "cloud-upload"
    /// cloud-upload-fill
    /// bi bi-cloud-upload-fill
    case cloud_upload_fill = "cloud-upload-fill"
    /// clouds
    /// bi bi-clouds
    case clouds = "clouds"
    /// clouds-fill
    /// bi bi-clouds-fill
    case clouds_fill = "clouds-fill"
    /// cloudy
    /// bi bi-cloudy
    case cloudy = "cloudy"
    /// cloudy-fill
    /// bi bi-cloudy-fill
    case cloudy_fill = "cloudy-fill"
    /// code
    /// bi bi-code
    case code = "code"
    /// code-slash
    /// bi bi-code-slash
    case code_slash = "code-slash"
    /// code-square
    /// bi bi-code-square
    case code_square = "code-square"
    /// coin
    /// bi bi-coin
    case coin = "coin"
    /// collection
    /// bi bi-collection
    case collection = "collection"
    /// collection-fill
    /// bi bi-collection-fill
    case collection_fill = "collection-fill"
    /// collection-play
    /// bi bi-collection-play
    case collection_play = "collection-play"
    /// collection-play-fill
    /// bi bi-collection-play-fill
    case collection_play_fill = "collection-play-fill"
    /// columns
    /// bi bi-columns
    case columns = "columns"
    /// columns-gap
    /// bi bi-columns-gap
    case columns_gap = "columns-gap"
    /// command
    /// bi bi-command
    case command = "command"
    /// compass
    /// bi bi-compass
    case compass = "compass"
    /// compass-fill
    /// bi bi-compass-fill
    case compass_fill = "compass-fill"
    /// cone
    /// bi bi-cone
    case cone = "cone"
    /// cone-striped
    /// bi bi-cone-striped
    case cone_striped = "cone-striped"
    /// controller
    /// bi bi-controller
    case controller = "controller"
    /// cookie
    /// bi bi-cookie
    case cookie = "cookie"
    /// copy
    /// bi bi-copy
    case copy = "copy"
    /// cpu
    /// bi bi-cpu
    case cpu = "cpu"
    /// cpu-fill
    /// bi bi-cpu-fill
    case cpu_fill = "cpu-fill"
    /// credit-card
    /// bi bi-credit-card
    case credit_card = "credit-card"
    /// credit-card-2-back
    /// bi bi-credit-card-2-back
    case credit_card_2_back = "credit-card-2-back"
    /// credit-card-2-back-fill
    /// bi bi-credit-card-2-back-fill
    case credit_card_2_back_fill = "credit-card-2-back-fill"
    /// credit-card-2-front
    /// bi bi-credit-card-2-front
    case credit_card_2_front = "credit-card-2-front"
    /// credit-card-2-front-fill
    /// bi bi-credit-card-2-front-fill
    case credit_card_2_front_fill = "credit-card-2-front-fill"
    /// credit-card-fill
    /// bi bi-credit-card-fill
    case credit_card_fill = "credit-card-fill"
    /// crop
    /// bi bi-crop
    case crop = "crop"
    /// crosshair
    /// bi bi-crosshair
    case crosshair = "crosshair"
    /// crosshair2
    /// bi bi-crosshair2
    case crosshair2 = "crosshair2"
    /// css
    /// bi bi-css
    case css = "css"
    /// cup
    /// bi bi-cup
    case cup = "cup"
    /// cup-fill
    /// bi bi-cup-fill
    case cup_fill = "cup-fill"
    /// cup-hot
    /// bi bi-cup-hot
    case cup_hot = "cup-hot"
    /// cup-hot-fill
    /// bi bi-cup-hot-fill
    case cup_hot_fill = "cup-hot-fill"
    /// cup-straw
    /// bi bi-cup-straw
    case cup_straw = "cup-straw"
    /// currency-bitcoin
    /// bi bi-currency-bitcoin
    case currency_bitcoin = "currency-bitcoin"
    /// currency-dollar
    /// bi bi-currency-dollar
    case currency_dollar = "currency-dollar"
    /// currency-euro
    /// bi bi-currency-euro
    case currency_euro = "currency-euro"
    /// currency-exchange
    /// bi bi-currency-exchange
    case currency_exchange = "currency-exchange"
    /// currency-pound
    /// bi bi-currency-pound
    case currency_pound = "currency-pound"
    /// currency-rupee
    /// bi bi-currency-rupee
    case currency_rupee = "currency-rupee"
    /// currency-yen
    /// bi bi-currency-yen
    case currency_yen = "currency-yen"
    /// cursor
    /// bi bi-cursor
    case cursor = "cursor"
    /// cursor-fill
    /// bi bi-cursor-fill
    case cursor_fill = "cursor-fill"
    /// cursor-text
    /// bi bi-cursor-text
    case cursor_text = "cursor-text"
    /// dash
    /// bi bi-dash
    case dash = "dash"
    /// dash-circle
    /// bi bi-dash-circle
    case dash_circle = "dash-circle"
    /// dash-circle-dotted
    /// bi bi-dash-circle-dotted
    case dash_circle_dotted = "dash-circle-dotted"
    /// dash-circle-fill
    /// bi bi-dash-circle-fill
    case dash_circle_fill = "dash-circle-fill"
    /// dash-lg
    /// bi bi-dash-lg
    case dash_lg = "dash-lg"
    /// dash-square
    /// bi bi-dash-square
    case dash_square = "dash-square"
    /// dash-square-dotted
    /// bi bi-dash-square-dotted
    case dash_square_dotted = "dash-square-dotted"
    /// dash-square-fill
    /// bi bi-dash-square-fill
    case dash_square_fill = "dash-square-fill"
    /// database
    /// bi bi-database
    case database = "database"
    /// database-add
    /// bi bi-database-add
    case database_add = "database-add"
    /// database-check
    /// bi bi-database-check
    case database_check = "database-check"
    /// database-dash
    /// bi bi-database-dash
    case database_dash = "database-dash"
    /// database-down
    /// bi bi-database-down
    case database_down = "database-down"
    /// database-exclamation
    /// bi bi-database-exclamation
    case database_exclamation = "database-exclamation"
    /// database-fill
    /// bi bi-database-fill
    case database_fill = "database-fill"
    /// database-fill-add
    /// bi bi-database-fill-add
    case database_fill_add = "database-fill-add"
    /// database-fill-check
    /// bi bi-database-fill-check
    case database_fill_check = "database-fill-check"
    /// database-fill-dash
    /// bi bi-database-fill-dash
    case database_fill_dash = "database-fill-dash"
    /// database-fill-down
    /// bi bi-database-fill-down
    case database_fill_down = "database-fill-down"
    /// database-fill-exclamation
    /// bi bi-database-fill-exclamation
    case database_fill_exclamation = "database-fill-exclamation"
    /// database-fill-gear
    /// bi bi-database-fill-gear
    case database_fill_gear = "database-fill-gear"
    /// database-fill-lock
    /// bi bi-database-fill-lock
    case database_fill_lock = "database-fill-lock"
    /// database-fill-slash
    /// bi bi-database-fill-slash
    case database_fill_slash = "database-fill-slash"
    /// database-fill-up
    /// bi bi-database-fill-up
    case database_fill_up = "database-fill-up"
    /// database-fill-x
    /// bi bi-database-fill-x
    case database_fill_x = "database-fill-x"
    /// database-gear
    /// bi bi-database-gear
    case database_gear = "database-gear"
    /// database-lock
    /// bi bi-database-lock
    case database_lock = "database-lock"
    /// database-slash
    /// bi bi-database-slash
    case database_slash = "database-slash"
    /// database-up
    /// bi bi-database-up
    case database_up = "database-up"
    /// database-x
    /// bi bi-database-x
    case database_x = "database-x"
    /// device-hdd
    /// bi bi-device-hdd
    case device_hdd = "device-hdd"
    /// device-hdd-fill
    /// bi bi-device-hdd-fill
    case device_hdd_fill = "device-hdd-fill"
    /// device-ssd
    /// bi bi-device-ssd
    case device_ssd = "device-ssd"
    /// device-ssd-fill
    /// bi bi-device-ssd-fill
    case device_ssd_fill = "device-ssd-fill"
    /// diagram-2
    /// bi bi-diagram-2
    case diagram_2 = "diagram-2"
    /// diagram-2-fill
    /// bi bi-diagram-2-fill
    case diagram_2_fill = "diagram-2-fill"
    /// diagram-3
    /// bi bi-diagram-3
    case diagram_3 = "diagram-3"
    /// diagram-3-fill
    /// bi bi-diagram-3-fill
    case diagram_3_fill = "diagram-3-fill"
    /// diamond
    /// bi bi-diamond
    case diamond = "diamond"
    /// diamond-fill
    /// bi bi-diamond-fill
    case diamond_fill = "diamond-fill"
    /// diamond-half
    /// bi bi-diamond-half
    case diamond_half = "diamond-half"
    /// dice-1
    /// bi bi-dice-1
    case dice_1 = "dice-1"
    /// dice-1-fill
    /// bi bi-dice-1-fill
    case dice_1_fill = "dice-1-fill"
    /// dice-2
    /// bi bi-dice-2
    case dice_2 = "dice-2"
    /// dice-2-fill
    /// bi bi-dice-2-fill
    case dice_2_fill = "dice-2-fill"
    /// dice-3
    /// bi bi-dice-3
    case dice_3 = "dice-3"
    /// dice-3-fill
    /// bi bi-dice-3-fill
    case dice_3_fill = "dice-3-fill"
    /// dice-4
    /// bi bi-dice-4
    case dice_4 = "dice-4"
    /// dice-4-fill
    /// bi bi-dice-4-fill
    case dice_4_fill = "dice-4-fill"
    /// dice-5
    /// bi bi-dice-5
    case dice_5 = "dice-5"
    /// dice-5-fill
    /// bi bi-dice-5-fill
    case dice_5_fill = "dice-5-fill"
    /// dice-6
    /// bi bi-dice-6
    case dice_6 = "dice-6"
    /// dice-6-fill
    /// bi bi-dice-6-fill
    case dice_6_fill = "dice-6-fill"
    /// disc
    /// bi bi-disc
    case disc = "disc"
    /// disc-fill
    /// bi bi-disc-fill
    case disc_fill = "disc-fill"
    /// discord
    /// bi bi-discord
    case discord = "discord"
    /// display
    /// bi bi-display
    case display = "display"
    /// display-fill
    /// bi bi-display-fill
    case display_fill = "display-fill"
    /// displayport
    /// bi bi-displayport
    case displayport = "displayport"
    /// displayport-fill
    /// bi bi-displayport-fill
    case displayport_fill = "displayport-fill"
    /// distribute-horizontal
    /// bi bi-distribute-horizontal
    case distribute_horizontal = "distribute-horizontal"
    /// distribute-vertical
    /// bi bi-distribute-vertical
    case distribute_vertical = "distribute-vertical"
    /// door-closed
    /// bi bi-door-closed
    case door_closed = "door-closed"
    /// door-closed-fill
    /// bi bi-door-closed-fill
    case door_closed_fill = "door-closed-fill"
    /// door-open
    /// bi bi-door-open
    case door_open = "door-open"
    /// door-open-fill
    /// bi bi-door-open-fill
    case door_open_fill = "door-open-fill"
    /// dot
    /// bi bi-dot
    case dot = "dot"
    /// download
    /// bi bi-download
    case download = "download"
    /// dpad
    /// bi bi-dpad
    case dpad = "dpad"
    /// dpad-fill
    /// bi bi-dpad-fill
    case dpad_fill = "dpad-fill"
    /// dribbble
    /// bi bi-dribbble
    case dribbble = "dribbble"
    /// dropbox
    /// bi bi-dropbox
    case dropbox = "dropbox"
    /// droplet
    /// bi bi-droplet
    case droplet = "droplet"
    /// droplet-fill
    /// bi bi-droplet-fill
    case droplet_fill = "droplet-fill"
    /// droplet-half
    /// bi bi-droplet-half
    case droplet_half = "droplet-half"
    /// duffle
    /// bi bi-duffle
    case duffle = "duffle"
    /// duffle-fill
    /// bi bi-duffle-fill
    case duffle_fill = "duffle-fill"
    /// ear
    /// bi bi-ear
    case ear = "ear"
    /// ear-fill
    /// bi bi-ear-fill
    case ear_fill = "ear-fill"
    /// earbuds
    /// bi bi-earbuds
    case earbuds = "earbuds"
    /// easel
    /// bi bi-easel
    case easel = "easel"
    /// easel-fill
    /// bi bi-easel-fill
    case easel_fill = "easel-fill"
    /// easel2
    /// bi bi-easel2
    case easel2 = "easel2"
    /// easel2-fill
    /// bi bi-easel2-fill
    case easel2_fill = "easel2-fill"
    /// easel3
    /// bi bi-easel3
    case easel3 = "easel3"
    /// easel3-fill
    /// bi bi-easel3-fill
    case easel3_fill = "easel3-fill"
    /// egg
    /// bi bi-egg
    case egg = "egg"
    /// egg-fill
    /// bi bi-egg-fill
    case egg_fill = "egg-fill"
    /// egg-fried
    /// bi bi-egg-fried
    case egg_fried = "egg-fried"
    /// eject
    /// bi bi-eject
    case eject = "eject"
    /// eject-fill
    /// bi bi-eject-fill
    case eject_fill = "eject-fill"
    /// emoji-angry
    /// bi bi-emoji-angry
    case emoji_angry = "emoji-angry"
    /// emoji-angry-fill
    /// bi bi-emoji-angry-fill
    case emoji_angry_fill = "emoji-angry-fill"
    /// emoji-astonished
    /// bi bi-emoji-astonished
    case emoji_astonished = "emoji-astonished"
    /// emoji-astonished-fill
    /// bi bi-emoji-astonished-fill
    case emoji_astonished_fill = "emoji-astonished-fill"
    /// emoji-dizzy
    /// bi bi-emoji-dizzy
    case emoji_dizzy = "emoji-dizzy"
    /// emoji-dizzy-fill
    /// bi bi-emoji-dizzy-fill
    case emoji_dizzy_fill = "emoji-dizzy-fill"
    /// emoji-expressionless
    /// bi bi-emoji-expressionless
    case emoji_expressionless = "emoji-expressionless"
    /// emoji-expressionless-fill
    /// bi bi-emoji-expressionless-fill
    case emoji_expressionless_fill = "emoji-expressionless-fill"
    /// emoji-frown
    /// bi bi-emoji-frown
    case emoji_frown = "emoji-frown"
    /// emoji-frown-fill
    /// bi bi-emoji-frown-fill
    case emoji_frown_fill = "emoji-frown-fill"
    /// emoji-grimace
    /// bi bi-emoji-grimace
    case emoji_grimace = "emoji-grimace"
    /// emoji-grimace-fill
    /// bi bi-emoji-grimace-fill
    case emoji_grimace_fill = "emoji-grimace-fill"
    /// emoji-grin
    /// bi bi-emoji-grin
    case emoji_grin = "emoji-grin"
    /// emoji-grin-fill
    /// bi bi-emoji-grin-fill
    case emoji_grin_fill = "emoji-grin-fill"
    /// emoji-heart-eyes
    /// bi bi-emoji-heart-eyes
    case emoji_heart_eyes = "emoji-heart-eyes"
    /// emoji-heart-eyes-fill
    /// bi bi-emoji-heart-eyes-fill
    case emoji_heart_eyes_fill = "emoji-heart-eyes-fill"
    /// emoji-kiss
    /// bi bi-emoji-kiss
    case emoji_kiss = "emoji-kiss"
    /// emoji-kiss-fill
    /// bi bi-emoji-kiss-fill
    case emoji_kiss_fill = "emoji-kiss-fill"
    /// emoji-laughing
    /// bi bi-emoji-laughing
    case emoji_laughing = "emoji-laughing"
    /// emoji-laughing-fill
    /// bi bi-emoji-laughing-fill
    case emoji_laughing_fill = "emoji-laughing-fill"
    /// emoji-neutral
    /// bi bi-emoji-neutral
    case emoji_neutral = "emoji-neutral"
    /// emoji-neutral-fill
    /// bi bi-emoji-neutral-fill
    case emoji_neutral_fill = "emoji-neutral-fill"
    /// emoji-smile
    /// bi bi-emoji-smile
    case emoji_smile = "emoji-smile"
    /// emoji-smile-fill
    /// bi bi-emoji-smile-fill
    case emoji_smile_fill = "emoji-smile-fill"
    /// emoji-smile-upside-down
    /// bi bi-emoji-smile-upside-down
    case emoji_smile_upside_down = "emoji-smile-upside-down"
    /// emoji-smile-upside-down-fill
    /// bi bi-emoji-smile-upside-down-fill
    case emoji_smile_upside_down_fill = "emoji-smile-upside-down-fill"
    /// emoji-sunglasses
    /// bi bi-emoji-sunglasses
    case emoji_sunglasses = "emoji-sunglasses"
    /// emoji-sunglasses-fill
    /// bi bi-emoji-sunglasses-fill
    case emoji_sunglasses_fill = "emoji-sunglasses-fill"
    /// emoji-surprise
    /// bi bi-emoji-surprise
    case emoji_surprise = "emoji-surprise"
    /// emoji-surprise-fill
    /// bi bi-emoji-surprise-fill
    case emoji_surprise_fill = "emoji-surprise-fill"
    /// emoji-tear
    /// bi bi-emoji-tear
    case emoji_tear = "emoji-tear"
    /// emoji-tear-fill
    /// bi bi-emoji-tear-fill
    case emoji_tear_fill = "emoji-tear-fill"
    /// emoji-wink
    /// bi bi-emoji-wink
    case emoji_wink = "emoji-wink"
    /// emoji-wink-fill
    /// bi bi-emoji-wink-fill
    case emoji_wink_fill = "emoji-wink-fill"
    /// envelope
    /// bi bi-envelope
    case envelope = "envelope"
    /// envelope-arrow-down
    /// bi bi-envelope-arrow-down
    case envelope_arrow_down = "envelope-arrow-down"
    /// envelope-arrow-down-fill
    /// bi bi-envelope-arrow-down-fill
    case envelope_arrow_down_fill = "envelope-arrow-down-fill"
    /// envelope-arrow-up
    /// bi bi-envelope-arrow-up
    case envelope_arrow_up = "envelope-arrow-up"
    /// envelope-arrow-up-fill
    /// bi bi-envelope-arrow-up-fill
    case envelope_arrow_up_fill = "envelope-arrow-up-fill"
    /// envelope-at
    /// bi bi-envelope-at
    case envelope_at = "envelope-at"
    /// envelope-at-fill
    /// bi bi-envelope-at-fill
    case envelope_at_fill = "envelope-at-fill"
    /// envelope-check
    /// bi bi-envelope-check
    case envelope_check = "envelope-check"
    /// envelope-check-fill
    /// bi bi-envelope-check-fill
    case envelope_check_fill = "envelope-check-fill"
    /// envelope-dash
    /// bi bi-envelope-dash
    case envelope_dash = "envelope-dash"
    /// envelope-dash-fill
    /// bi bi-envelope-dash-fill
    case envelope_dash_fill = "envelope-dash-fill"
    /// envelope-exclamation
    /// bi bi-envelope-exclamation
    case envelope_exclamation = "envelope-exclamation"
    /// envelope-exclamation-fill
    /// bi bi-envelope-exclamation-fill
    case envelope_exclamation_fill = "envelope-exclamation-fill"
    /// envelope-fill
    /// bi bi-envelope-fill
    case envelope_fill = "envelope-fill"
    /// envelope-heart
    /// bi bi-envelope-heart
    case envelope_heart = "envelope-heart"
    /// envelope-heart-fill
    /// bi bi-envelope-heart-fill
    case envelope_heart_fill = "envelope-heart-fill"
    /// envelope-open
    /// bi bi-envelope-open
    case envelope_open = "envelope-open"
    /// envelope-open-fill
    /// bi bi-envelope-open-fill
    case envelope_open_fill = "envelope-open-fill"
    /// envelope-open-heart
    /// bi bi-envelope-open-heart
    case envelope_open_heart = "envelope-open-heart"
    /// envelope-open-heart-fill
    /// bi bi-envelope-open-heart-fill
    case envelope_open_heart_fill = "envelope-open-heart-fill"
    /// envelope-paper
    /// bi bi-envelope-paper
    case envelope_paper = "envelope-paper"
    /// envelope-paper-fill
    /// bi bi-envelope-paper-fill
    case envelope_paper_fill = "envelope-paper-fill"
    /// envelope-paper-heart
    /// bi bi-envelope-paper-heart
    case envelope_paper_heart = "envelope-paper-heart"
    /// envelope-paper-heart-fill
    /// bi bi-envelope-paper-heart-fill
    case envelope_paper_heart_fill = "envelope-paper-heart-fill"
    /// envelope-plus
    /// bi bi-envelope-plus
    case envelope_plus = "envelope-plus"
    /// envelope-plus-fill
    /// bi bi-envelope-plus-fill
    case envelope_plus_fill = "envelope-plus-fill"
    /// envelope-slash
    /// bi bi-envelope-slash
    case envelope_slash = "envelope-slash"
    /// envelope-slash-fill
    /// bi bi-envelope-slash-fill
    case envelope_slash_fill = "envelope-slash-fill"
    /// envelope-x
    /// bi bi-envelope-x
    case envelope_x = "envelope-x"
    /// envelope-x-fill
    /// bi bi-envelope-x-fill
    case envelope_x_fill = "envelope-x-fill"
    /// eraser
    /// bi bi-eraser
    case eraser = "eraser"
    /// eraser-fill
    /// bi bi-eraser-fill
    case eraser_fill = "eraser-fill"
    /// escape
    /// bi bi-escape
    case escape = "escape"
    /// ethernet
    /// bi bi-ethernet
    case ethernet = "ethernet"
    /// ev-front
    /// bi bi-ev-front
    case ev_front = "ev-front"
    /// ev-front-fill
    /// bi bi-ev-front-fill
    case ev_front_fill = "ev-front-fill"
    /// ev-station
    /// bi bi-ev-station
    case ev_station = "ev-station"
    /// ev-station-fill
    /// bi bi-ev-station-fill
    case ev_station_fill = "ev-station-fill"
    /// exclamation
    /// bi bi-exclamation
    case exclamation = "exclamation"
    /// exclamation-circle
    /// bi bi-exclamation-circle
    case exclamation_circle = "exclamation-circle"
    /// exclamation-circle-fill
    /// bi bi-exclamation-circle-fill
    case exclamation_circle_fill = "exclamation-circle-fill"
    /// exclamation-diamond
    /// bi bi-exclamation-diamond
    case exclamation_diamond = "exclamation-diamond"
    /// exclamation-diamond-fill
    /// bi bi-exclamation-diamond-fill
    case exclamation_diamond_fill = "exclamation-diamond-fill"
    /// exclamation-lg
    /// bi bi-exclamation-lg
    case exclamation_lg = "exclamation-lg"
    /// exclamation-octagon
    /// bi bi-exclamation-octagon
    case exclamation_octagon = "exclamation-octagon"
    /// exclamation-octagon-fill
    /// bi bi-exclamation-octagon-fill
    case exclamation_octagon_fill = "exclamation-octagon-fill"
    /// exclamation-square
    /// bi bi-exclamation-square
    case exclamation_square = "exclamation-square"
    /// exclamation-square-fill
    /// bi bi-exclamation-square-fill
    case exclamation_square_fill = "exclamation-square-fill"
    /// exclamation-triangle
    /// bi bi-exclamation-triangle
    case exclamation_triangle = "exclamation-triangle"
    /// exclamation-triangle-fill
    /// bi bi-exclamation-triangle-fill
    case exclamation_triangle_fill = "exclamation-triangle-fill"
    /// exclude
    /// bi bi-exclude
    case exclude = "exclude"
    /// explicit
    /// bi bi-explicit
    case explicit = "explicit"
    /// explicit-fill
    /// bi bi-explicit-fill
    case explicit_fill = "explicit-fill"
    /// exposure
    /// bi bi-exposure
    case exposure = "exposure"
    /// eye
    /// bi bi-eye
    case eye = "eye"
    /// eye-fill
    /// bi bi-eye-fill
    case eye_fill = "eye-fill"
    /// eye-slash
    /// bi bi-eye-slash
    case eye_slash = "eye-slash"
    /// eye-slash-fill
    /// bi bi-eye-slash-fill
    case eye_slash_fill = "eye-slash-fill"
    /// eyedropper
    /// bi bi-eyedropper
    case eyedropper = "eyedropper"
    /// eyeglasses
    /// bi bi-eyeglasses
    case eyeglasses = "eyeglasses"
    /// facebook
    /// bi bi-facebook
    case facebook = "facebook"
    /// fan
    /// bi bi-fan
    case fan = "fan"
    /// fast-forward
    /// bi bi-fast-forward
    case fast_forward = "fast-forward"
    /// fast-forward-btn
    /// bi bi-fast-forward-btn
    case fast_forward_btn = "fast-forward-btn"
    /// fast-forward-btn-fill
    /// bi bi-fast-forward-btn-fill
    case fast_forward_btn_fill = "fast-forward-btn-fill"
    /// fast-forward-circle
    /// bi bi-fast-forward-circle
    case fast_forward_circle = "fast-forward-circle"
    /// fast-forward-circle-fill
    /// bi bi-fast-forward-circle-fill
    case fast_forward_circle_fill = "fast-forward-circle-fill"
    /// fast-forward-fill
    /// bi bi-fast-forward-fill
    case fast_forward_fill = "fast-forward-fill"
    /// feather
    /// bi bi-feather
    case feather = "feather"
    /// feather2
    /// bi bi-feather2
    case feather2 = "feather2"
    /// file
    /// bi bi-file
    case file = "file"
    /// file-arrow-down
    /// bi bi-file-arrow-down
    case file_arrow_down = "file-arrow-down"
    /// file-arrow-down-fill
    /// bi bi-file-arrow-down-fill
    case file_arrow_down_fill = "file-arrow-down-fill"
    /// file-arrow-up
    /// bi bi-file-arrow-up
    case file_arrow_up = "file-arrow-up"
    /// file-arrow-up-fill
    /// bi bi-file-arrow-up-fill
    case file_arrow_up_fill = "file-arrow-up-fill"
    /// file-bar-graph
    /// bi bi-file-bar-graph
    case file_bar_graph = "file-bar-graph"
    /// file-bar-graph-fill
    /// bi bi-file-bar-graph-fill
    case file_bar_graph_fill = "file-bar-graph-fill"
    /// file-binary
    /// bi bi-file-binary
    case file_binary = "file-binary"
    /// file-binary-fill
    /// bi bi-file-binary-fill
    case file_binary_fill = "file-binary-fill"
    /// file-break
    /// bi bi-file-break
    case file_break = "file-break"
    /// file-break-fill
    /// bi bi-file-break-fill
    case file_break_fill = "file-break-fill"
    /// file-check
    /// bi bi-file-check
    case file_check = "file-check"
    /// file-check-fill
    /// bi bi-file-check-fill
    case file_check_fill = "file-check-fill"
    /// file-code
    /// bi bi-file-code
    case file_code = "file-code"
    /// file-code-fill
    /// bi bi-file-code-fill
    case file_code_fill = "file-code-fill"
    /// file-diff
    /// bi bi-file-diff
    case file_diff = "file-diff"
    /// file-diff-fill
    /// bi bi-file-diff-fill
    case file_diff_fill = "file-diff-fill"
    /// file-earmark
    /// bi bi-file-earmark
    case file_earmark = "file-earmark"
    /// file-earmark-arrow-down
    /// bi bi-file-earmark-arrow-down
    case file_earmark_arrow_down = "file-earmark-arrow-down"
    /// file-earmark-arrow-down-fill
    /// bi bi-file-earmark-arrow-down-fill
    case file_earmark_arrow_down_fill = "file-earmark-arrow-down-fill"
    /// file-earmark-arrow-up
    /// bi bi-file-earmark-arrow-up
    case file_earmark_arrow_up = "file-earmark-arrow-up"
    /// file-earmark-arrow-up-fill
    /// bi bi-file-earmark-arrow-up-fill
    case file_earmark_arrow_up_fill = "file-earmark-arrow-up-fill"
    /// file-earmark-bar-graph
    /// bi bi-file-earmark-bar-graph
    case file_earmark_bar_graph = "file-earmark-bar-graph"
    /// file-earmark-bar-graph-fill
    /// bi bi-file-earmark-bar-graph-fill
    case file_earmark_bar_graph_fill = "file-earmark-bar-graph-fill"
    /// file-earmark-binary
    /// bi bi-file-earmark-binary
    case file_earmark_binary = "file-earmark-binary"
    /// file-earmark-binary-fill
    /// bi bi-file-earmark-binary-fill
    case file_earmark_binary_fill = "file-earmark-binary-fill"
    /// file-earmark-break
    /// bi bi-file-earmark-break
    case file_earmark_break = "file-earmark-break"
    /// file-earmark-break-fill
    /// bi bi-file-earmark-break-fill
    case file_earmark_break_fill = "file-earmark-break-fill"
    /// file-earmark-check
    /// bi bi-file-earmark-check
    case file_earmark_check = "file-earmark-check"
    /// file-earmark-check-fill
    /// bi bi-file-earmark-check-fill
    case file_earmark_check_fill = "file-earmark-check-fill"
    /// file-earmark-code
    /// bi bi-file-earmark-code
    case file_earmark_code = "file-earmark-code"
    /// file-earmark-code-fill
    /// bi bi-file-earmark-code-fill
    case file_earmark_code_fill = "file-earmark-code-fill"
    /// file-earmark-diff
    /// bi bi-file-earmark-diff
    case file_earmark_diff = "file-earmark-diff"
    /// file-earmark-diff-fill
    /// bi bi-file-earmark-diff-fill
    case file_earmark_diff_fill = "file-earmark-diff-fill"
    /// file-earmark-easel
    /// bi bi-file-earmark-easel
    case file_earmark_easel = "file-earmark-easel"
    /// file-earmark-easel-fill
    /// bi bi-file-earmark-easel-fill
    case file_earmark_easel_fill = "file-earmark-easel-fill"
    /// file-earmark-excel
    /// bi bi-file-earmark-excel
    case file_earmark_excel = "file-earmark-excel"
    /// file-earmark-excel-fill
    /// bi bi-file-earmark-excel-fill
    case file_earmark_excel_fill = "file-earmark-excel-fill"
    /// file-earmark-fill
    /// bi bi-file-earmark-fill
    case file_earmark_fill = "file-earmark-fill"
    /// file-earmark-font
    /// bi bi-file-earmark-font
    case file_earmark_font = "file-earmark-font"
    /// file-earmark-font-fill
    /// bi bi-file-earmark-font-fill
    case file_earmark_font_fill = "file-earmark-font-fill"
    /// file-earmark-image
    /// bi bi-file-earmark-image
    case file_earmark_image = "file-earmark-image"
    /// file-earmark-image-fill
    /// bi bi-file-earmark-image-fill
    case file_earmark_image_fill = "file-earmark-image-fill"
    /// file-earmark-lock
    /// bi bi-file-earmark-lock
    case file_earmark_lock = "file-earmark-lock"
    /// file-earmark-lock-fill
    /// bi bi-file-earmark-lock-fill
    case file_earmark_lock_fill = "file-earmark-lock-fill"
    /// file-earmark-lock2
    /// bi bi-file-earmark-lock2
    case file_earmark_lock2 = "file-earmark-lock2"
    /// file-earmark-lock2-fill
    /// bi bi-file-earmark-lock2-fill
    case file_earmark_lock2_fill = "file-earmark-lock2-fill"
    /// file-earmark-medical
    /// bi bi-file-earmark-medical
    case file_earmark_medical = "file-earmark-medical"
    /// file-earmark-medical-fill
    /// bi bi-file-earmark-medical-fill
    case file_earmark_medical_fill = "file-earmark-medical-fill"
    /// file-earmark-minus
    /// bi bi-file-earmark-minus
    case file_earmark_minus = "file-earmark-minus"
    /// file-earmark-minus-fill
    /// bi bi-file-earmark-minus-fill
    case file_earmark_minus_fill = "file-earmark-minus-fill"
    /// file-earmark-music
    /// bi bi-file-earmark-music
    case file_earmark_music = "file-earmark-music"
    /// file-earmark-music-fill
    /// bi bi-file-earmark-music-fill
    case file_earmark_music_fill = "file-earmark-music-fill"
    /// file-earmark-pdf
    /// bi bi-file-earmark-pdf
    case file_earmark_pdf = "file-earmark-pdf"
    /// file-earmark-pdf-fill
    /// bi bi-file-earmark-pdf-fill
    case file_earmark_pdf_fill = "file-earmark-pdf-fill"
    /// file-earmark-person
    /// bi bi-file-earmark-person
    case file_earmark_person = "file-earmark-person"
    /// file-earmark-person-fill
    /// bi bi-file-earmark-person-fill
    case file_earmark_person_fill = "file-earmark-person-fill"
    /// file-earmark-play
    /// bi bi-file-earmark-play
    case file_earmark_play = "file-earmark-play"
    /// file-earmark-play-fill
    /// bi bi-file-earmark-play-fill
    case file_earmark_play_fill = "file-earmark-play-fill"
    /// file-earmark-plus
    /// bi bi-file-earmark-plus
    case file_earmark_plus = "file-earmark-plus"
    /// file-earmark-plus-fill
    /// bi bi-file-earmark-plus-fill
    case file_earmark_plus_fill = "file-earmark-plus-fill"
    /// file-earmark-post
    /// bi bi-file-earmark-post
    case file_earmark_post = "file-earmark-post"
    /// file-earmark-post-fill
    /// bi bi-file-earmark-post-fill
    case file_earmark_post_fill = "file-earmark-post-fill"
    /// file-earmark-ppt
    /// bi bi-file-earmark-ppt
    case file_earmark_ppt = "file-earmark-ppt"
    /// file-earmark-ppt-fill
    /// bi bi-file-earmark-ppt-fill
    case file_earmark_ppt_fill = "file-earmark-ppt-fill"
    /// file-earmark-richtext
    /// bi bi-file-earmark-richtext
    case file_earmark_richtext = "file-earmark-richtext"
    /// file-earmark-richtext-fill
    /// bi bi-file-earmark-richtext-fill
    case file_earmark_richtext_fill = "file-earmark-richtext-fill"
    /// file-earmark-ruled
    /// bi bi-file-earmark-ruled
    case file_earmark_ruled = "file-earmark-ruled"
    /// file-earmark-ruled-fill
    /// bi bi-file-earmark-ruled-fill
    case file_earmark_ruled_fill = "file-earmark-ruled-fill"
    /// file-earmark-slides
    /// bi bi-file-earmark-slides
    case file_earmark_slides = "file-earmark-slides"
    /// file-earmark-slides-fill
    /// bi bi-file-earmark-slides-fill
    case file_earmark_slides_fill = "file-earmark-slides-fill"
    /// file-earmark-spreadsheet
    /// bi bi-file-earmark-spreadsheet
    case file_earmark_spreadsheet = "file-earmark-spreadsheet"
    /// file-earmark-spreadsheet-fill
    /// bi bi-file-earmark-spreadsheet-fill
    case file_earmark_spreadsheet_fill = "file-earmark-spreadsheet-fill"
    /// file-earmark-text
    /// bi bi-file-earmark-text
    case file_earmark_text = "file-earmark-text"
    /// file-earmark-text-fill
    /// bi bi-file-earmark-text-fill
    case file_earmark_text_fill = "file-earmark-text-fill"
    /// file-earmark-word
    /// bi bi-file-earmark-word
    case file_earmark_word = "file-earmark-word"
    /// file-earmark-word-fill
    /// bi bi-file-earmark-word-fill
    case file_earmark_word_fill = "file-earmark-word-fill"
    /// file-earmark-x
    /// bi bi-file-earmark-x
    case file_earmark_x = "file-earmark-x"
    /// file-earmark-x-fill
    /// bi bi-file-earmark-x-fill
    case file_earmark_x_fill = "file-earmark-x-fill"
    /// file-earmark-zip
    /// bi bi-file-earmark-zip
    case file_earmark_zip = "file-earmark-zip"
    /// file-earmark-zip-fill
    /// bi bi-file-earmark-zip-fill
    case file_earmark_zip_fill = "file-earmark-zip-fill"
    /// file-easel
    /// bi bi-file-easel
    case file_easel = "file-easel"
    /// file-easel-fill
    /// bi bi-file-easel-fill
    case file_easel_fill = "file-easel-fill"
    /// file-excel
    /// bi bi-file-excel
    case file_excel = "file-excel"
    /// file-excel-fill
    /// bi bi-file-excel-fill
    case file_excel_fill = "file-excel-fill"
    /// file-fill
    /// bi bi-file-fill
    case file_fill = "file-fill"
    /// file-font
    /// bi bi-file-font
    case file_font = "file-font"
    /// file-font-fill
    /// bi bi-file-font-fill
    case file_font_fill = "file-font-fill"
    /// file-image
    /// bi bi-file-image
    case file_image = "file-image"
    /// file-image-fill
    /// bi bi-file-image-fill
    case file_image_fill = "file-image-fill"
    /// file-lock
    /// bi bi-file-lock
    case file_lock = "file-lock"
    /// file-lock-fill
    /// bi bi-file-lock-fill
    case file_lock_fill = "file-lock-fill"
    /// file-lock2
    /// bi bi-file-lock2
    case file_lock2 = "file-lock2"
    /// file-lock2-fill
    /// bi bi-file-lock2-fill
    case file_lock2_fill = "file-lock2-fill"
    /// file-medical
    /// bi bi-file-medical
    case file_medical = "file-medical"
    /// file-medical-fill
    /// bi bi-file-medical-fill
    case file_medical_fill = "file-medical-fill"
    /// file-minus
    /// bi bi-file-minus
    case file_minus = "file-minus"
    /// file-minus-fill
    /// bi bi-file-minus-fill
    case file_minus_fill = "file-minus-fill"
    /// file-music
    /// bi bi-file-music
    case file_music = "file-music"
    /// file-music-fill
    /// bi bi-file-music-fill
    case file_music_fill = "file-music-fill"
    /// file-pdf
    /// bi bi-file-pdf
    case file_pdf = "file-pdf"
    /// file-pdf-fill
    /// bi bi-file-pdf-fill
    case file_pdf_fill = "file-pdf-fill"
    /// file-person
    /// bi bi-file-person
    case file_person = "file-person"
    /// file-person-fill
    /// bi bi-file-person-fill
    case file_person_fill = "file-person-fill"
    /// file-play
    /// bi bi-file-play
    case file_play = "file-play"
    /// file-play-fill
    /// bi bi-file-play-fill
    case file_play_fill = "file-play-fill"
    /// file-plus
    /// bi bi-file-plus
    case file_plus = "file-plus"
    /// file-plus-fill
    /// bi bi-file-plus-fill
    case file_plus_fill = "file-plus-fill"
    /// file-post
    /// bi bi-file-post
    case file_post = "file-post"
    /// file-post-fill
    /// bi bi-file-post-fill
    case file_post_fill = "file-post-fill"
    /// file-ppt
    /// bi bi-file-ppt
    case file_ppt = "file-ppt"
    /// file-ppt-fill
    /// bi bi-file-ppt-fill
    case file_ppt_fill = "file-ppt-fill"
    /// file-richtext
    /// bi bi-file-richtext
    case file_richtext = "file-richtext"
    /// file-richtext-fill
    /// bi bi-file-richtext-fill
    case file_richtext_fill = "file-richtext-fill"
    /// file-ruled
    /// bi bi-file-ruled
    case file_ruled = "file-ruled"
    /// file-ruled-fill
    /// bi bi-file-ruled-fill
    case file_ruled_fill = "file-ruled-fill"
    /// file-slides
    /// bi bi-file-slides
    case file_slides = "file-slides"
    /// file-slides-fill
    /// bi bi-file-slides-fill
    case file_slides_fill = "file-slides-fill"
    /// file-spreadsheet
    /// bi bi-file-spreadsheet
    case file_spreadsheet = "file-spreadsheet"
    /// file-spreadsheet-fill
    /// bi bi-file-spreadsheet-fill
    case file_spreadsheet_fill = "file-spreadsheet-fill"
    /// file-text
    /// bi bi-file-text
    case file_text = "file-text"
    /// file-text-fill
    /// bi bi-file-text-fill
    case file_text_fill = "file-text-fill"
    /// file-word
    /// bi bi-file-word
    case file_word = "file-word"
    /// file-word-fill
    /// bi bi-file-word-fill
    case file_word_fill = "file-word-fill"
    /// file-x
    /// bi bi-file-x
    case file_x = "file-x"
    /// file-x-fill
    /// bi bi-file-x-fill
    case file_x_fill = "file-x-fill"
    /// file-zip
    /// bi bi-file-zip
    case file_zip = "file-zip"
    /// file-zip-fill
    /// bi bi-file-zip-fill
    case file_zip_fill = "file-zip-fill"
    /// files
    /// bi bi-files
    case files = "files"
    /// files-alt
    /// bi bi-files-alt
    case files_alt = "files-alt"
    /// filetype-aac
    /// bi bi-filetype-aac
    case filetype_aac = "filetype-aac"
    /// filetype-ai
    /// bi bi-filetype-ai
    case filetype_ai = "filetype-ai"
    /// filetype-bmp
    /// bi bi-filetype-bmp
    case filetype_bmp = "filetype-bmp"
    /// filetype-cs
    /// bi bi-filetype-cs
    case filetype_cs = "filetype-cs"
    /// filetype-css
    /// bi bi-filetype-css
    case filetype_css = "filetype-css"
    /// filetype-csv
    /// bi bi-filetype-csv
    case filetype_csv = "filetype-csv"
    /// filetype-doc
    /// bi bi-filetype-doc
    case filetype_doc = "filetype-doc"
    /// filetype-docx
    /// bi bi-filetype-docx
    case filetype_docx = "filetype-docx"
    /// filetype-exe
    /// bi bi-filetype-exe
    case filetype_exe = "filetype-exe"
    /// filetype-gif
    /// bi bi-filetype-gif
    case filetype_gif = "filetype-gif"
    /// filetype-heic
    /// bi bi-filetype-heic
    case filetype_heic = "filetype-heic"
    /// filetype-html
    /// bi bi-filetype-html
    case filetype_html = "filetype-html"
    /// filetype-java
    /// bi bi-filetype-java
    case filetype_java = "filetype-java"
    /// filetype-jpg
    /// bi bi-filetype-jpg
    case filetype_jpg = "filetype-jpg"
    /// filetype-js
    /// bi bi-filetype-js
    case filetype_js = "filetype-js"
    /// filetype-json
    /// bi bi-filetype-json
    case filetype_json = "filetype-json"
    /// filetype-jsx
    /// bi bi-filetype-jsx
    case filetype_jsx = "filetype-jsx"
    /// filetype-key
    /// bi bi-filetype-key
    case filetype_key = "filetype-key"
    /// filetype-m4p
    /// bi bi-filetype-m4p
    case filetype_m4p = "filetype-m4p"
    /// filetype-md
    /// bi bi-filetype-md
    case filetype_md = "filetype-md"
    /// filetype-mdx
    /// bi bi-filetype-mdx
    case filetype_mdx = "filetype-mdx"
    /// filetype-mov
    /// bi bi-filetype-mov
    case filetype_mov = "filetype-mov"
    /// filetype-mp3
    /// bi bi-filetype-mp3
    case filetype_mp3 = "filetype-mp3"
    /// filetype-mp4
    /// bi bi-filetype-mp4
    case filetype_mp4 = "filetype-mp4"
    /// filetype-otf
    /// bi bi-filetype-otf
    case filetype_otf = "filetype-otf"
    /// filetype-pdf
    /// bi bi-filetype-pdf
    case filetype_pdf = "filetype-pdf"
    /// filetype-php
    /// bi bi-filetype-php
    case filetype_php = "filetype-php"
    /// filetype-png
    /// bi bi-filetype-png
    case filetype_png = "filetype-png"
    /// filetype-ppt
    /// bi bi-filetype-ppt
    case filetype_ppt = "filetype-ppt"
    /// filetype-pptx
    /// bi bi-filetype-pptx
    case filetype_pptx = "filetype-pptx"
    /// filetype-psd
    /// bi bi-filetype-psd
    case filetype_psd = "filetype-psd"
    /// filetype-py
    /// bi bi-filetype-py
    case filetype_py = "filetype-py"
    /// filetype-raw
    /// bi bi-filetype-raw
    case filetype_raw = "filetype-raw"
    /// filetype-rb
    /// bi bi-filetype-rb
    case filetype_rb = "filetype-rb"
    /// filetype-sass
    /// bi bi-filetype-sass
    case filetype_sass = "filetype-sass"
    /// filetype-scss
    /// bi bi-filetype-scss
    case filetype_scss = "filetype-scss"
    /// filetype-sh
    /// bi bi-filetype-sh
    case filetype_sh = "filetype-sh"
    /// filetype-sql
    /// bi bi-filetype-sql
    case filetype_sql = "filetype-sql"
    /// filetype-svg
    /// bi bi-filetype-svg
    case filetype_svg = "filetype-svg"
    /// filetype-tiff
    /// bi bi-filetype-tiff
    case filetype_tiff = "filetype-tiff"
    /// filetype-tsx
    /// bi bi-filetype-tsx
    case filetype_tsx = "filetype-tsx"
    /// filetype-ttf
    /// bi bi-filetype-ttf
    case filetype_ttf = "filetype-ttf"
    /// filetype-txt
    /// bi bi-filetype-txt
    case filetype_txt = "filetype-txt"
    /// filetype-wav
    /// bi bi-filetype-wav
    case filetype_wav = "filetype-wav"
    /// filetype-woff
    /// bi bi-filetype-woff
    case filetype_woff = "filetype-woff"
    /// filetype-xls
    /// bi bi-filetype-xls
    case filetype_xls = "filetype-xls"
    /// filetype-xlsx
    /// bi bi-filetype-xlsx
    case filetype_xlsx = "filetype-xlsx"
    /// filetype-xml
    /// bi bi-filetype-xml
    case filetype_xml = "filetype-xml"
    /// filetype-yml
    /// bi bi-filetype-yml
    case filetype_yml = "filetype-yml"
    /// film
    /// bi bi-film
    case film = "film"
    /// filter
    /// bi bi-filter
    case filter = "filter"
    /// filter-circle
    /// bi bi-filter-circle
    case filter_circle = "filter-circle"
    /// filter-circle-fill
    /// bi bi-filter-circle-fill
    case filter_circle_fill = "filter-circle-fill"
    /// filter-left
    /// bi bi-filter-left
    case filter_left = "filter-left"
    /// filter-right
    /// bi bi-filter-right
    case filter_right = "filter-right"
    /// filter-square
    /// bi bi-filter-square
    case filter_square = "filter-square"
    /// filter-square-fill
    /// bi bi-filter-square-fill
    case filter_square_fill = "filter-square-fill"
    /// fingerprint
    /// bi bi-fingerprint
    case fingerprint = "fingerprint"
    /// fire
    /// bi bi-fire
    case fire = "fire"
    /// flag
    /// bi bi-flag
    case flag = "flag"
    /// flag-fill
    /// bi bi-flag-fill
    case flag_fill = "flag-fill"
    /// flask
    /// bi bi-flask
    case flask = "flask"
    /// flask-fill
    /// bi bi-flask-fill
    case flask_fill = "flask-fill"
    /// flask-florence
    /// bi bi-flask-florence
    case flask_florence = "flask-florence"
    /// flask-florence-fill
    /// bi bi-flask-florence-fill
    case flask_florence_fill = "flask-florence-fill"
    /// floppy
    /// bi bi-floppy
    case floppy = "floppy"
    /// floppy-fill
    /// bi bi-floppy-fill
    case floppy_fill = "floppy-fill"
    /// floppy2
    /// bi bi-floppy2
    case floppy2 = "floppy2"
    /// floppy2-fill
    /// bi bi-floppy2-fill
    case floppy2_fill = "floppy2-fill"
    /// flower1
    /// bi bi-flower1
    case flower1 = "flower1"
    /// flower2
    /// bi bi-flower2
    case flower2 = "flower2"
    /// flower3
    /// bi bi-flower3
    case flower3 = "flower3"
    /// folder
    /// bi bi-folder
    case folder = "folder"
    /// folder-check
    /// bi bi-folder-check
    case folder_check = "folder-check"
    /// folder-fill
    /// bi bi-folder-fill
    case folder_fill = "folder-fill"
    /// folder-minus
    /// bi bi-folder-minus
    case folder_minus = "folder-minus"
    /// folder-plus
    /// bi bi-folder-plus
    case folder_plus = "folder-plus"
    /// folder-symlink
    /// bi bi-folder-symlink
    case folder_symlink = "folder-symlink"
    /// folder-symlink-fill
    /// bi bi-folder-symlink-fill
    case folder_symlink_fill = "folder-symlink-fill"
    /// folder-x
    /// bi bi-folder-x
    case folder_x = "folder-x"
    /// folder2
    /// bi bi-folder2
    case folder2 = "folder2"
    /// folder2-open
    /// bi bi-folder2-open
    case folder2_open = "folder2-open"
    /// fonts
    /// bi bi-fonts
    case fonts = "fonts"
    /// fork-knife
    /// bi bi-fork-knife
    case fork_knife = "fork-knife"
    /// forward
    /// bi bi-forward
    case forward = "forward"
    /// forward-fill
    /// bi bi-forward-fill
    case forward_fill = "forward-fill"
    /// front
    /// bi bi-front
    case front = "front"
    /// fuel-pump
    /// bi bi-fuel-pump
    case fuel_pump = "fuel-pump"
    /// fuel-pump-diesel
    /// bi bi-fuel-pump-diesel
    case fuel_pump_diesel = "fuel-pump-diesel"
    /// fuel-pump-diesel-fill
    /// bi bi-fuel-pump-diesel-fill
    case fuel_pump_diesel_fill = "fuel-pump-diesel-fill"
    /// fuel-pump-fill
    /// bi bi-fuel-pump-fill
    case fuel_pump_fill = "fuel-pump-fill"
    /// fullscreen
    /// bi bi-fullscreen
    case fullscreen = "fullscreen"
    /// fullscreen-exit
    /// bi bi-fullscreen-exit
    case fullscreen_exit = "fullscreen-exit"
    /// funnel
    /// bi bi-funnel
    case funnel = "funnel"
    /// funnel-fill
    /// bi bi-funnel-fill
    case funnel_fill = "funnel-fill"
    /// gear
    /// bi bi-gear
    case gear = "gear"
    /// gear-fill
    /// bi bi-gear-fill
    case gear_fill = "gear-fill"
    /// gear-wide
    /// bi bi-gear-wide
    case gear_wide = "gear-wide"
    /// gear-wide-connected
    /// bi bi-gear-wide-connected
    case gear_wide_connected = "gear-wide-connected"
    /// gem
    /// bi bi-gem
    case gem = "gem"
    /// gender-ambiguous
    /// bi bi-gender-ambiguous
    case gender_ambiguous = "gender-ambiguous"
    /// gender-female
    /// bi bi-gender-female
    case gender_female = "gender-female"
    /// gender-male
    /// bi bi-gender-male
    case gender_male = "gender-male"
    /// gender-neuter
    /// bi bi-gender-neuter
    case gender_neuter = "gender-neuter"
    /// gender-trans
    /// bi bi-gender-trans
    case gender_trans = "gender-trans"
    /// geo
    /// bi bi-geo
    case geo = "geo"
    /// geo-alt
    /// bi bi-geo-alt
    case geo_alt = "geo-alt"
    /// geo-alt-fill
    /// bi bi-geo-alt-fill
    case geo_alt_fill = "geo-alt-fill"
    /// geo-fill
    /// bi bi-geo-fill
    case geo_fill = "geo-fill"
    /// gift
    /// bi bi-gift
    case gift = "gift"
    /// gift-fill
    /// bi bi-gift-fill
    case gift_fill = "gift-fill"
    /// git
    /// bi bi-git
    case git = "git"
    /// github
    /// bi bi-github
    case github = "github"
    /// gitlab
    /// bi bi-gitlab
    case gitlab = "gitlab"
    /// globe
    /// bi bi-globe
    case globe = "globe"
    /// globe-americas
    /// bi bi-globe-americas
    case globe_americas = "globe-americas"
    /// globe-americas-fill
    /// bi bi-globe-americas-fill
    case globe_americas_fill = "globe-americas-fill"
    /// globe-asia-australia
    /// bi bi-globe-asia-australia
    case globe_asia_australia = "globe-asia-australia"
    /// globe-asia-australia-fill
    /// bi bi-globe-asia-australia-fill
    case globe_asia_australia_fill = "globe-asia-australia-fill"
    /// globe-central-south-asia
    /// bi bi-globe-central-south-asia
    case globe_central_south_asia = "globe-central-south-asia"
    /// globe-central-south-asia-fill
    /// bi bi-globe-central-south-asia-fill
    case globe_central_south_asia_fill = "globe-central-south-asia-fill"
    /// globe-europe-africa
    /// bi bi-globe-europe-africa
    case globe_europe_africa = "globe-europe-africa"
    /// globe-europe-africa-fill
    /// bi bi-globe-europe-africa-fill
    case globe_europe_africa_fill = "globe-europe-africa-fill"
    /// globe2
    /// bi bi-globe2
    case globe2 = "globe2"
    /// google
    /// bi bi-google
    case google = "google"
    /// google-play
    /// bi bi-google-play
    case google_play = "google-play"
    /// gpu-card
    /// bi bi-gpu-card
    case gpu_card = "gpu-card"
    /// graph-down
    /// bi bi-graph-down
    case graph_down = "graph-down"
    /// graph-down-arrow
    /// bi bi-graph-down-arrow
    case graph_down_arrow = "graph-down-arrow"
    /// graph-up
    /// bi bi-graph-up
    case graph_up = "graph-up"
    /// graph-up-arrow
    /// bi bi-graph-up-arrow
    case graph_up_arrow = "graph-up-arrow"
    /// grid
    /// bi bi-grid
    case grid = "grid"
    /// grid-1x2
    /// bi bi-grid-1x2
    case grid_1x2 = "grid-1x2"
    /// grid-1x2-fill
    /// bi bi-grid-1x2-fill
    case grid_1x2_fill = "grid-1x2-fill"
    /// grid-3x2
    /// bi bi-grid-3x2
    case grid_3x2 = "grid-3x2"
    /// grid-3x2-gap
    /// bi bi-grid-3x2-gap
    case grid_3x2_gap = "grid-3x2-gap"
    /// grid-3x2-gap-fill
    /// bi bi-grid-3x2-gap-fill
    case grid_3x2_gap_fill = "grid-3x2-gap-fill"
    /// grid-3x3
    /// bi bi-grid-3x3
    case grid_3x3 = "grid-3x3"
    /// grid-3x3-gap
    /// bi bi-grid-3x3-gap
    case grid_3x3_gap = "grid-3x3-gap"
    /// grid-3x3-gap-fill
    /// bi bi-grid-3x3-gap-fill
    case grid_3x3_gap_fill = "grid-3x3-gap-fill"
    /// grid-fill
    /// bi bi-grid-fill
    case grid_fill = "grid-fill"
    /// grip-horizontal
    /// bi bi-grip-horizontal
    case grip_horizontal = "grip-horizontal"
    /// grip-vertical
    /// bi bi-grip-vertical
    case grip_vertical = "grip-vertical"
    /// h-circle
    /// bi bi-h-circle
    case h_circle = "h-circle"
    /// h-circle-fill
    /// bi bi-h-circle-fill
    case h_circle_fill = "h-circle-fill"
    /// h-square
    /// bi bi-h-square
    case h_square = "h-square"
    /// h-square-fill
    /// bi bi-h-square-fill
    case h_square_fill = "h-square-fill"
    /// hammer
    /// bi bi-hammer
    case hammer = "hammer"
    /// hand-index
    /// bi bi-hand-index
    case hand_index = "hand-index"
    /// hand-index-fill
    /// bi bi-hand-index-fill
    case hand_index_fill = "hand-index-fill"
    /// hand-index-thumb
    /// bi bi-hand-index-thumb
    case hand_index_thumb = "hand-index-thumb"
    /// hand-index-thumb-fill
    /// bi bi-hand-index-thumb-fill
    case hand_index_thumb_fill = "hand-index-thumb-fill"
    /// hand-thumbs-down
    /// bi bi-hand-thumbs-down
    case hand_thumbs_down = "hand-thumbs-down"
    /// hand-thumbs-down-fill
    /// bi bi-hand-thumbs-down-fill
    case hand_thumbs_down_fill = "hand-thumbs-down-fill"
    /// hand-thumbs-up
    /// bi bi-hand-thumbs-up
    case hand_thumbs_up = "hand-thumbs-up"
    /// hand-thumbs-up-fill
    /// bi bi-hand-thumbs-up-fill
    case hand_thumbs_up_fill = "hand-thumbs-up-fill"
    /// handbag
    /// bi bi-handbag
    case handbag = "handbag"
    /// handbag-fill
    /// bi bi-handbag-fill
    case handbag_fill = "handbag-fill"
    /// hash
    /// bi bi-hash
    case hash = "hash"
    /// hdd
    /// bi bi-hdd
    case hdd = "hdd"
    /// hdd-fill
    /// bi bi-hdd-fill
    case hdd_fill = "hdd-fill"
    /// hdd-network
    /// bi bi-hdd-network
    case hdd_network = "hdd-network"
    /// hdd-network-fill
    /// bi bi-hdd-network-fill
    case hdd_network_fill = "hdd-network-fill"
    /// hdd-rack
    /// bi bi-hdd-rack
    case hdd_rack = "hdd-rack"
    /// hdd-rack-fill
    /// bi bi-hdd-rack-fill
    case hdd_rack_fill = "hdd-rack-fill"
    /// hdd-stack
    /// bi bi-hdd-stack
    case hdd_stack = "hdd-stack"
    /// hdd-stack-fill
    /// bi bi-hdd-stack-fill
    case hdd_stack_fill = "hdd-stack-fill"
    /// hdmi
    /// bi bi-hdmi
    case hdmi = "hdmi"
    /// hdmi-fill
    /// bi bi-hdmi-fill
    case hdmi_fill = "hdmi-fill"
    /// headphones
    /// bi bi-headphones
    case headphones = "headphones"
    /// headset
    /// bi bi-headset
    case headset = "headset"
    /// headset-vr
    /// bi bi-headset-vr
    case headset_vr = "headset-vr"
    /// heart
    /// bi bi-heart
    case heart = "heart"
    /// heart-arrow
    /// bi bi-heart-arrow
    case heart_arrow = "heart-arrow"
    /// heart-fill
    /// bi bi-heart-fill
    case heart_fill = "heart-fill"
    /// heart-half
    /// bi bi-heart-half
    case heart_half = "heart-half"
    /// heart-pulse
    /// bi bi-heart-pulse
    case heart_pulse = "heart-pulse"
    /// heart-pulse-fill
    /// bi bi-heart-pulse-fill
    case heart_pulse_fill = "heart-pulse-fill"
    /// heartbreak
    /// bi bi-heartbreak
    case heartbreak = "heartbreak"
    /// heartbreak-fill
    /// bi bi-heartbreak-fill
    case heartbreak_fill = "heartbreak-fill"
    /// hearts
    /// bi bi-hearts
    case hearts = "hearts"
    /// heptagon
    /// bi bi-heptagon
    case heptagon = "heptagon"
    /// heptagon-fill
    /// bi bi-heptagon-fill
    case heptagon_fill = "heptagon-fill"
    /// heptagon-half
    /// bi bi-heptagon-half
    case heptagon_half = "heptagon-half"
    /// hexagon
    /// bi bi-hexagon
    case hexagon = "hexagon"
    /// hexagon-fill
    /// bi bi-hexagon-fill
    case hexagon_fill = "hexagon-fill"
    /// hexagon-half
    /// bi bi-hexagon-half
    case hexagon_half = "hexagon-half"
    /// highlighter
    /// bi bi-highlighter
    case highlighter = "highlighter"
    /// highlights
    /// bi bi-highlights
    case highlights = "highlights"
    /// hospital
    /// bi bi-hospital
    case hospital = "hospital"
    /// hospital-fill
    /// bi bi-hospital-fill
    case hospital_fill = "hospital-fill"
    /// hourglass
    /// bi bi-hourglass
    case hourglass = "hourglass"
    /// hourglass-bottom
    /// bi bi-hourglass-bottom
    case hourglass_bottom = "hourglass-bottom"
    /// hourglass-split
    /// bi bi-hourglass-split
    case hourglass_split = "hourglass-split"
    /// hourglass-top
    /// bi bi-hourglass-top
    case hourglass_top = "hourglass-top"
    /// house
    /// bi bi-house
    case house = "house"
    /// house-add
    /// bi bi-house-add
    case house_add = "house-add"
    /// house-add-fill
    /// bi bi-house-add-fill
    case house_add_fill = "house-add-fill"
    /// house-check
    /// bi bi-house-check
    case house_check = "house-check"
    /// house-check-fill
    /// bi bi-house-check-fill
    case house_check_fill = "house-check-fill"
    /// house-dash
    /// bi bi-house-dash
    case house_dash = "house-dash"
    /// house-dash-fill
    /// bi bi-house-dash-fill
    case house_dash_fill = "house-dash-fill"
    /// house-door
    /// bi bi-house-door
    case house_door = "house-door"
    /// house-door-fill
    /// bi bi-house-door-fill
    case house_door_fill = "house-door-fill"
    /// house-down
    /// bi bi-house-down
    case house_down = "house-down"
    /// house-down-fill
    /// bi bi-house-down-fill
    case house_down_fill = "house-down-fill"
    /// house-exclamation
    /// bi bi-house-exclamation
    case house_exclamation = "house-exclamation"
    /// house-exclamation-fill
    /// bi bi-house-exclamation-fill
    case house_exclamation_fill = "house-exclamation-fill"
    /// house-fill
    /// bi bi-house-fill
    case house_fill = "house-fill"
    /// house-gear
    /// bi bi-house-gear
    case house_gear = "house-gear"
    /// house-gear-fill
    /// bi bi-house-gear-fill
    case house_gear_fill = "house-gear-fill"
    /// house-heart
    /// bi bi-house-heart
    case house_heart = "house-heart"
    /// house-heart-fill
    /// bi bi-house-heart-fill
    case house_heart_fill = "house-heart-fill"
    /// house-lock
    /// bi bi-house-lock
    case house_lock = "house-lock"
    /// house-lock-fill
    /// bi bi-house-lock-fill
    case house_lock_fill = "house-lock-fill"
    /// house-slash
    /// bi bi-house-slash
    case house_slash = "house-slash"
    /// house-slash-fill
    /// bi bi-house-slash-fill
    case house_slash_fill = "house-slash-fill"
    /// house-up
    /// bi bi-house-up
    case house_up = "house-up"
    /// house-up-fill
    /// bi bi-house-up-fill
    case house_up_fill = "house-up-fill"
    /// house-x
    /// bi bi-house-x
    case house_x = "house-x"
    /// house-x-fill
    /// bi bi-house-x-fill
    case house_x_fill = "house-x-fill"
    /// houses
    /// bi bi-houses
    case houses = "houses"
    /// houses-fill
    /// bi bi-houses-fill
    case houses_fill = "houses-fill"
    /// hr
    /// bi bi-hr
    case hr = "hr"
    /// hurricane
    /// bi bi-hurricane
    case hurricane = "hurricane"
    /// hypnotize
    /// bi bi-hypnotize
    case hypnotize = "hypnotize"
    /// image
    /// bi bi-image
    case image = "image"
    /// image-alt
    /// bi bi-image-alt
    case image_alt = "image-alt"
    /// image-fill
    /// bi bi-image-fill
    case image_fill = "image-fill"
    /// images
    /// bi bi-images
    case images = "images"
    /// inbox
    /// bi bi-inbox
    case inbox = "inbox"
    /// inbox-fill
    /// bi bi-inbox-fill
    case inbox_fill = "inbox-fill"
    /// inboxes
    /// bi bi-inboxes
    case inboxes = "inboxes"
    /// inboxes-fill
    /// bi bi-inboxes-fill
    case inboxes_fill = "inboxes-fill"
    /// incognito
    /// bi bi-incognito
    case incognito = "incognito"
    /// indent
    /// bi bi-indent
    case indent = "indent"
    /// infinity
    /// bi bi-infinity
    case infinity = "infinity"
    /// info
    /// bi bi-info
    case info = "info"
    /// info-circle
    /// bi bi-info-circle
    case info_circle = "info-circle"
    /// info-circle-fill
    /// bi bi-info-circle-fill
    case info_circle_fill = "info-circle-fill"
    /// info-lg
    /// bi bi-info-lg
    case info_lg = "info-lg"
    /// info-square
    /// bi bi-info-square
    case info_square = "info-square"
    /// info-square-fill
    /// bi bi-info-square-fill
    case info_square_fill = "info-square-fill"
    /// input-cursor
    /// bi bi-input-cursor
    case input_cursor = "input-cursor"
    /// input-cursor-text
    /// bi bi-input-cursor-text
    case input_cursor_text = "input-cursor-text"
    /// instagram
    /// bi bi-instagram
    case instagram = "instagram"
    /// intersect
    /// bi bi-intersect
    case intersect = "intersect"
    /// javascript
    /// bi bi-javascript
    case javascript = "javascript"
    /// journal
    /// bi bi-journal
    case journal = "journal"
    /// journal-album
    /// bi bi-journal-album
    case journal_album = "journal-album"
    /// journal-arrow-down
    /// bi bi-journal-arrow-down
    case journal_arrow_down = "journal-arrow-down"
    /// journal-arrow-up
    /// bi bi-journal-arrow-up
    case journal_arrow_up = "journal-arrow-up"
    /// journal-bookmark
    /// bi bi-journal-bookmark
    case journal_bookmark = "journal-bookmark"
    /// journal-bookmark-fill
    /// bi bi-journal-bookmark-fill
    case journal_bookmark_fill = "journal-bookmark-fill"
    /// journal-check
    /// bi bi-journal-check
    case journal_check = "journal-check"
    /// journal-code
    /// bi bi-journal-code
    case journal_code = "journal-code"
    /// journal-medical
    /// bi bi-journal-medical
    case journal_medical = "journal-medical"
    /// journal-minus
    /// bi bi-journal-minus
    case journal_minus = "journal-minus"
    /// journal-plus
    /// bi bi-journal-plus
    case journal_plus = "journal-plus"
    /// journal-richtext
    /// bi bi-journal-richtext
    case journal_richtext = "journal-richtext"
    /// journal-text
    /// bi bi-journal-text
    case journal_text = "journal-text"
    /// journal-x
    /// bi bi-journal-x
    case journal_x = "journal-x"
    /// journals
    /// bi bi-journals
    case journals = "journals"
    /// joystick
    /// bi bi-joystick
    case joystick = "joystick"
    /// justify
    /// bi bi-justify
    case justify = "justify"
    /// justify-left
    /// bi bi-justify-left
    case justify_left = "justify-left"
    /// justify-right
    /// bi bi-justify-right
    case justify_right = "justify-right"
    /// kanban
    /// bi bi-kanban
    case kanban = "kanban"
    /// kanban-fill
    /// bi bi-kanban-fill
    case kanban_fill = "kanban-fill"
    /// key
    /// bi bi-key
    case key = "key"
    /// key-fill
    /// bi bi-key-fill
    case key_fill = "key-fill"
    /// keyboard
    /// bi bi-keyboard
    case keyboard = "keyboard"
    /// keyboard-fill
    /// bi bi-keyboard-fill
    case keyboard_fill = "keyboard-fill"
    /// ladder
    /// bi bi-ladder
    case ladder = "ladder"
    /// lamp
    /// bi bi-lamp
    case lamp = "lamp"
    /// lamp-fill
    /// bi bi-lamp-fill
    case lamp_fill = "lamp-fill"
    /// laptop
    /// bi bi-laptop
    case laptop = "laptop"
    /// laptop-fill
    /// bi bi-laptop-fill
    case laptop_fill = "laptop-fill"
    /// layer-backward
    /// bi bi-layer-backward
    case layer_backward = "layer-backward"
    /// layer-forward
    /// bi bi-layer-forward
    case layer_forward = "layer-forward"
    /// layers
    /// bi bi-layers
    case layers = "layers"
    /// layers-fill
    /// bi bi-layers-fill
    case layers_fill = "layers-fill"
    /// layers-half
    /// bi bi-layers-half
    case layers_half = "layers-half"
    /// layout-sidebar
    /// bi bi-layout-sidebar
    case layout_sidebar = "layout-sidebar"
    /// layout-sidebar-inset
    /// bi bi-layout-sidebar-inset
    case layout_sidebar_inset = "layout-sidebar-inset"
    /// layout-sidebar-inset-reverse
    /// bi bi-layout-sidebar-inset-reverse
    case layout_sidebar_inset_reverse = "layout-sidebar-inset-reverse"
    /// layout-sidebar-reverse
    /// bi bi-layout-sidebar-reverse
    case layout_sidebar_reverse = "layout-sidebar-reverse"
    /// layout-split
    /// bi bi-layout-split
    case layout_split = "layout-split"
    /// layout-text-sidebar
    /// bi bi-layout-text-sidebar
    case layout_text_sidebar = "layout-text-sidebar"
    /// layout-text-sidebar-reverse
    /// bi bi-layout-text-sidebar-reverse
    case layout_text_sidebar_reverse = "layout-text-sidebar-reverse"
    /// layout-text-window
    /// bi bi-layout-text-window
    case layout_text_window = "layout-text-window"
    /// layout-text-window-reverse
    /// bi bi-layout-text-window-reverse
    case layout_text_window_reverse = "layout-text-window-reverse"
    /// layout-three-columns
    /// bi bi-layout-three-columns
    case layout_three_columns = "layout-three-columns"
    /// layout-wtf
    /// bi bi-layout-wtf
    case layout_wtf = "layout-wtf"
    /// leaf
    /// bi bi-leaf
    case leaf = "leaf"
    /// leaf-fill
    /// bi bi-leaf-fill
    case leaf_fill = "leaf-fill"
    /// life-preserver
    /// bi bi-life-preserver
    case life_preserver = "life-preserver"
    /// lightbulb
    /// bi bi-lightbulb
    case lightbulb = "lightbulb"
    /// lightbulb-fill
    /// bi bi-lightbulb-fill
    case lightbulb_fill = "lightbulb-fill"
    /// lightbulb-off
    /// bi bi-lightbulb-off
    case lightbulb_off = "lightbulb-off"
    /// lightbulb-off-fill
    /// bi bi-lightbulb-off-fill
    case lightbulb_off_fill = "lightbulb-off-fill"
    /// lightning
    /// bi bi-lightning
    case lightning = "lightning"
    /// lightning-charge
    /// bi bi-lightning-charge
    case lightning_charge = "lightning-charge"
    /// lightning-charge-fill
    /// bi bi-lightning-charge-fill
    case lightning_charge_fill = "lightning-charge-fill"
    /// lightning-fill
    /// bi bi-lightning-fill
    case lightning_fill = "lightning-fill"
    /// line
    /// bi bi-line
    case line = "line"
    /// link
    /// bi bi-link
    case link = "link"
    /// link-45deg
    /// bi bi-link-45deg
    case link_45deg = "link-45deg"
    /// linkedin
    /// bi bi-linkedin
    case linkedin = "linkedin"
    /// list
    /// bi bi-list
    case list = "list"
    /// list-check
    /// bi bi-list-check
    case list_check = "list-check"
    /// list-columns
    /// bi bi-list-columns
    case list_columns = "list-columns"
    /// list-columns-reverse
    /// bi bi-list-columns-reverse
    case list_columns_reverse = "list-columns-reverse"
    /// list-nested
    /// bi bi-list-nested
    case list_nested = "list-nested"
    /// list-ol
    /// bi bi-list-ol
    case list_ol = "list-ol"
    /// list-stars
    /// bi bi-list-stars
    case list_stars = "list-stars"
    /// list-task
    /// bi bi-list-task
    case list_task = "list-task"
    /// list-ul
    /// bi bi-list-ul
    case list_ul = "list-ul"
    /// lock
    /// bi bi-lock
    case lock = "lock"
    /// lock-fill
    /// bi bi-lock-fill
    case lock_fill = "lock-fill"
    /// luggage
    /// bi bi-luggage
    case luggage = "luggage"
    /// luggage-fill
    /// bi bi-luggage-fill
    case luggage_fill = "luggage-fill"
    /// lungs
    /// bi bi-lungs
    case lungs = "lungs"
    /// lungs-fill
    /// bi bi-lungs-fill
    case lungs_fill = "lungs-fill"
    /// magic
    /// bi bi-magic
    case magic = "magic"
    /// magnet
    /// bi bi-magnet
    case magnet = "magnet"
    /// magnet-fill
    /// bi bi-magnet-fill
    case magnet_fill = "magnet-fill"
    /// mailbox
    /// bi bi-mailbox
    case mailbox = "mailbox"
    /// mailbox-flag
    /// bi bi-mailbox-flag
    case mailbox_flag = "mailbox-flag"
    /// mailbox2
    /// bi bi-mailbox2
    case mailbox2 = "mailbox2"
    /// mailbox2-flag
    /// bi bi-mailbox2-flag
    case mailbox2_flag = "mailbox2-flag"
    /// map
    /// bi bi-map
    case map = "map"
    /// map-fill
    /// bi bi-map-fill
    case map_fill = "map-fill"
    /// markdown
    /// bi bi-markdown
    case markdown = "markdown"
    /// markdown-fill
    /// bi bi-markdown-fill
    case markdown_fill = "markdown-fill"
    /// marker-tip
    /// bi bi-marker-tip
    case marker_tip = "marker-tip"
    /// mask
    /// bi bi-mask
    case mask = "mask"
    /// mastodon
    /// bi bi-mastodon
    case mastodon = "mastodon"
    /// measuring-cup
    /// bi bi-measuring-cup
    case measuring_cup = "measuring-cup"
    /// measuring-cup-fill
    /// bi bi-measuring-cup-fill
    case measuring_cup_fill = "measuring-cup-fill"
    /// medium
    /// bi bi-medium
    case medium = "medium"
    /// megaphone
    /// bi bi-megaphone
    case megaphone = "megaphone"
    /// megaphone-fill
    /// bi bi-megaphone-fill
    case megaphone_fill = "megaphone-fill"
    /// memory
    /// bi bi-memory
    case memory = "memory"
    /// menu-app
    /// bi bi-menu-app
    case menu_app = "menu-app"
    /// menu-app-fill
    /// bi bi-menu-app-fill
    case menu_app_fill = "menu-app-fill"
    /// menu-button
    /// bi bi-menu-button
    case menu_button = "menu-button"
    /// menu-button-fill
    /// bi bi-menu-button-fill
    case menu_button_fill = "menu-button-fill"
    /// menu-button-wide
    /// bi bi-menu-button-wide
    case menu_button_wide = "menu-button-wide"
    /// menu-button-wide-fill
    /// bi bi-menu-button-wide-fill
    case menu_button_wide_fill = "menu-button-wide-fill"
    /// menu-down
    /// bi bi-menu-down
    case menu_down = "menu-down"
    /// menu-up
    /// bi bi-menu-up
    case menu_up = "menu-up"
    /// messenger
    /// bi bi-messenger
    case messenger = "messenger"
    /// meta
    /// bi bi-meta
    case meta = "meta"
    /// mic
    /// bi bi-mic
    case mic = "mic"
    /// mic-fill
    /// bi bi-mic-fill
    case mic_fill = "mic-fill"
    /// mic-mute
    /// bi bi-mic-mute
    case mic_mute = "mic-mute"
    /// mic-mute-fill
    /// bi bi-mic-mute-fill
    case mic_mute_fill = "mic-mute-fill"
    /// microsoft
    /// bi bi-microsoft
    case microsoft = "microsoft"
    /// microsoft-teams
    /// bi bi-microsoft-teams
    case microsoft_teams = "microsoft-teams"
    /// minecart
    /// bi bi-minecart
    case minecart = "minecart"
    /// minecart-loaded
    /// bi bi-minecart-loaded
    case minecart_loaded = "minecart-loaded"
    /// modem
    /// bi bi-modem
    case modem = "modem"
    /// modem-fill
    /// bi bi-modem-fill
    case modem_fill = "modem-fill"
    /// moisture
    /// bi bi-moisture
    case moisture = "moisture"
    /// moon
    /// bi bi-moon
    case moon = "moon"
    /// moon-fill
    /// bi bi-moon-fill
    case moon_fill = "moon-fill"
    /// moon-stars
    /// bi bi-moon-stars
    case moon_stars = "moon-stars"
    /// moon-stars-fill
    /// bi bi-moon-stars-fill
    case moon_stars_fill = "moon-stars-fill"
    /// mortarboard
    /// bi bi-mortarboard
    case mortarboard = "mortarboard"
    /// mortarboard-fill
    /// bi bi-mortarboard-fill
    case mortarboard_fill = "mortarboard-fill"
    /// motherboard
    /// bi bi-motherboard
    case motherboard = "motherboard"
    /// motherboard-fill
    /// bi bi-motherboard-fill
    case motherboard_fill = "motherboard-fill"
    /// mouse
    /// bi bi-mouse
    case mouse = "mouse"
    /// mouse-fill
    /// bi bi-mouse-fill
    case mouse_fill = "mouse-fill"
    /// mouse2
    /// bi bi-mouse2
    case mouse2 = "mouse2"
    /// mouse2-fill
    /// bi bi-mouse2-fill
    case mouse2_fill = "mouse2-fill"
    /// mouse3
    /// bi bi-mouse3
    case mouse3 = "mouse3"
    /// mouse3-fill
    /// bi bi-mouse3-fill
    case mouse3_fill = "mouse3-fill"
    /// music-note
    /// bi bi-music-note
    case music_note = "music-note"
    /// music-note-beamed
    /// bi bi-music-note-beamed
    case music_note_beamed = "music-note-beamed"
    /// music-note-list
    /// bi bi-music-note-list
    case music_note_list = "music-note-list"
    /// music-player
    /// bi bi-music-player
    case music_player = "music-player"
    /// music-player-fill
    /// bi bi-music-player-fill
    case music_player_fill = "music-player-fill"
    /// newspaper
    /// bi bi-newspaper
    case newspaper = "newspaper"
    /// nintendo-switch
    /// bi bi-nintendo-switch
    case nintendo_switch = "nintendo-switch"
    /// node-minus
    /// bi bi-node-minus
    case node_minus = "node-minus"
    /// node-minus-fill
    /// bi bi-node-minus-fill
    case node_minus_fill = "node-minus-fill"
    /// node-plus
    /// bi bi-node-plus
    case node_plus = "node-plus"
    /// node-plus-fill
    /// bi bi-node-plus-fill
    case node_plus_fill = "node-plus-fill"
    /// noise-reduction
    /// bi bi-noise-reduction
    case noise_reduction = "noise-reduction"
    /// nut
    /// bi bi-nut
    case nut = "nut"
    /// nut-fill
    /// bi bi-nut-fill
    case nut_fill = "nut-fill"
    /// nvidia
    /// bi bi-nvidia
    case nvidia = "nvidia"
    /// nvme
    /// bi bi-nvme
    case nvme = "nvme"
    /// nvme-fill
    /// bi bi-nvme-fill
    case nvme_fill = "nvme-fill"
    /// octagon
    /// bi bi-octagon
    case octagon = "octagon"
    /// octagon-fill
    /// bi bi-octagon-fill
    case octagon_fill = "octagon-fill"
    /// octagon-half
    /// bi bi-octagon-half
    case octagon_half = "octagon-half"
    /// openai
    /// bi bi-openai
    case openai = "openai"
    /// opencollective
    /// bi bi-opencollective
    case opencollective = "opencollective"
    /// optical-audio
    /// bi bi-optical-audio
    case optical_audio = "optical-audio"
    /// optical-audio-fill
    /// bi bi-optical-audio-fill
    case optical_audio_fill = "optical-audio-fill"
    /// option
    /// bi bi-option
    case option = "option"
    /// outlet
    /// bi bi-outlet
    case outlet = "outlet"
    /// p-circle
    /// bi bi-p-circle
    case p_circle = "p-circle"
    /// p-circle-fill
    /// bi bi-p-circle-fill
    case p_circle_fill = "p-circle-fill"
    /// p-square
    /// bi bi-p-square
    case p_square = "p-square"
    /// p-square-fill
    /// bi bi-p-square-fill
    case p_square_fill = "p-square-fill"
    /// paint-bucket
    /// bi bi-paint-bucket
    case paint_bucket = "paint-bucket"
    /// palette
    /// bi bi-palette
    case palette = "palette"
    /// palette-fill
    /// bi bi-palette-fill
    case palette_fill = "palette-fill"
    /// palette2
    /// bi bi-palette2
    case palette2 = "palette2"
    /// paperclip
    /// bi bi-paperclip
    case paperclip = "paperclip"
    /// paragraph
    /// bi bi-paragraph
    case paragraph = "paragraph"
    /// pass
    /// bi bi-pass
    case pass = "pass"
    /// pass-fill
    /// bi bi-pass-fill
    case pass_fill = "pass-fill"
    /// passport
    /// bi bi-passport
    case passport = "passport"
    /// passport-fill
    /// bi bi-passport-fill
    case passport_fill = "passport-fill"
    /// patch-check
    /// bi bi-patch-check
    case patch_check = "patch-check"
    /// patch-check-fill
    /// bi bi-patch-check-fill
    case patch_check_fill = "patch-check-fill"
    /// patch-exclamation
    /// bi bi-patch-exclamation
    case patch_exclamation = "patch-exclamation"
    /// patch-exclamation-fill
    /// bi bi-patch-exclamation-fill
    case patch_exclamation_fill = "patch-exclamation-fill"
    /// patch-minus
    /// bi bi-patch-minus
    case patch_minus = "patch-minus"
    /// patch-minus-fill
    /// bi bi-patch-minus-fill
    case patch_minus_fill = "patch-minus-fill"
    /// patch-plus
    /// bi bi-patch-plus
    case patch_plus = "patch-plus"
    /// patch-plus-fill
    /// bi bi-patch-plus-fill
    case patch_plus_fill = "patch-plus-fill"
    /// patch-question
    /// bi bi-patch-question
    case patch_question = "patch-question"
    /// patch-question-fill
    /// bi bi-patch-question-fill
    case patch_question_fill = "patch-question-fill"
    /// pause
    /// bi bi-pause
    case pause = "pause"
    /// pause-btn
    /// bi bi-pause-btn
    case pause_btn = "pause-btn"
    /// pause-btn-fill
    /// bi bi-pause-btn-fill
    case pause_btn_fill = "pause-btn-fill"
    /// pause-circle
    /// bi bi-pause-circle
    case pause_circle = "pause-circle"
    /// pause-circle-fill
    /// bi bi-pause-circle-fill
    case pause_circle_fill = "pause-circle-fill"
    /// pause-fill
    /// bi bi-pause-fill
    case pause_fill = "pause-fill"
    /// paypal
    /// bi bi-paypal
    case paypal = "paypal"
    /// pc
    /// bi bi-pc
    case pc = "pc"
    /// pc-display
    /// bi bi-pc-display
    case pc_display = "pc-display"
    /// pc-display-horizontal
    /// bi bi-pc-display-horizontal
    case pc_display_horizontal = "pc-display-horizontal"
    /// pc-horizontal
    /// bi bi-pc-horizontal
    case pc_horizontal = "pc-horizontal"
    /// pci-card
    /// bi bi-pci-card
    case pci_card = "pci-card"
    /// pci-card-network
    /// bi bi-pci-card-network
    case pci_card_network = "pci-card-network"
    /// pci-card-sound
    /// bi bi-pci-card-sound
    case pci_card_sound = "pci-card-sound"
    /// peace
    /// bi bi-peace
    case peace = "peace"
    /// peace-fill
    /// bi bi-peace-fill
    case peace_fill = "peace-fill"
    /// pen
    /// bi bi-pen
    case pen = "pen"
    /// pen-fill
    /// bi bi-pen-fill
    case pen_fill = "pen-fill"
    /// pencil
    /// bi bi-pencil
    case pencil = "pencil"
    /// pencil-fill
    /// bi bi-pencil-fill
    case pencil_fill = "pencil-fill"
    /// pencil-square
    /// bi bi-pencil-square
    case pencil_square = "pencil-square"
    /// pentagon
    /// bi bi-pentagon
    case pentagon = "pentagon"
    /// pentagon-fill
    /// bi bi-pentagon-fill
    case pentagon_fill = "pentagon-fill"
    /// pentagon-half
    /// bi bi-pentagon-half
    case pentagon_half = "pentagon-half"
    /// people
    /// bi bi-people
    case people = "people"
    /// people-fill
    /// bi bi-people-fill
    case people_fill = "people-fill"
    /// percent
    /// bi bi-percent
    case percent = "percent"
    /// perplexity
    /// bi bi-perplexity
    case perplexity = "perplexity"
    /// person
    /// bi bi-person
    case person = "person"
    /// person-add
    /// bi bi-person-add
    case person_add = "person-add"
    /// person-arms-up
    /// bi bi-person-arms-up
    case person_arms_up = "person-arms-up"
    /// person-badge
    /// bi bi-person-badge
    case person_badge = "person-badge"
    /// person-badge-fill
    /// bi bi-person-badge-fill
    case person_badge_fill = "person-badge-fill"
    /// person-bounding-box
    /// bi bi-person-bounding-box
    case person_bounding_box = "person-bounding-box"
    /// person-check
    /// bi bi-person-check
    case person_check = "person-check"
    /// person-check-fill
    /// bi bi-person-check-fill
    case person_check_fill = "person-check-fill"
    /// person-circle
    /// bi bi-person-circle
    case person_circle = "person-circle"
    /// person-dash
    /// bi bi-person-dash
    case person_dash = "person-dash"
    /// person-dash-fill
    /// bi bi-person-dash-fill
    case person_dash_fill = "person-dash-fill"
    /// person-down
    /// bi bi-person-down
    case person_down = "person-down"
    /// person-exclamation
    /// bi bi-person-exclamation
    case person_exclamation = "person-exclamation"
    /// person-fill
    /// bi bi-person-fill
    case person_fill = "person-fill"
    /// person-fill-add
    /// bi bi-person-fill-add
    case person_fill_add = "person-fill-add"
    /// person-fill-check
    /// bi bi-person-fill-check
    case person_fill_check = "person-fill-check"
    /// person-fill-dash
    /// bi bi-person-fill-dash
    case person_fill_dash = "person-fill-dash"
    /// person-fill-down
    /// bi bi-person-fill-down
    case person_fill_down = "person-fill-down"
    /// person-fill-exclamation
    /// bi bi-person-fill-exclamation
    case person_fill_exclamation = "person-fill-exclamation"
    /// person-fill-gear
    /// bi bi-person-fill-gear
    case person_fill_gear = "person-fill-gear"
    /// person-fill-lock
    /// bi bi-person-fill-lock
    case person_fill_lock = "person-fill-lock"
    /// person-fill-slash
    /// bi bi-person-fill-slash
    case person_fill_slash = "person-fill-slash"
    /// person-fill-up
    /// bi bi-person-fill-up
    case person_fill_up = "person-fill-up"
    /// person-fill-x
    /// bi bi-person-fill-x
    case person_fill_x = "person-fill-x"
    /// person-gear
    /// bi bi-person-gear
    case person_gear = "person-gear"
    /// person-heart
    /// bi bi-person-heart
    case person_heart = "person-heart"
    /// person-hearts
    /// bi bi-person-hearts
    case person_hearts = "person-hearts"
    /// person-lines-fill
    /// bi bi-person-lines-fill
    case person_lines_fill = "person-lines-fill"
    /// person-lock
    /// bi bi-person-lock
    case person_lock = "person-lock"
    /// person-plus
    /// bi bi-person-plus
    case person_plus = "person-plus"
    /// person-plus-fill
    /// bi bi-person-plus-fill
    case person_plus_fill = "person-plus-fill"
    /// person-raised-hand
    /// bi bi-person-raised-hand
    case person_raised_hand = "person-raised-hand"
    /// person-rolodex
    /// bi bi-person-rolodex
    case person_rolodex = "person-rolodex"
    /// person-slash
    /// bi bi-person-slash
    case person_slash = "person-slash"
    /// person-square
    /// bi bi-person-square
    case person_square = "person-square"
    /// person-standing
    /// bi bi-person-standing
    case person_standing = "person-standing"
    /// person-standing-dress
    /// bi bi-person-standing-dress
    case person_standing_dress = "person-standing-dress"
    /// person-up
    /// bi bi-person-up
    case person_up = "person-up"
    /// person-vcard
    /// bi bi-person-vcard
    case person_vcard = "person-vcard"
    /// person-vcard-fill
    /// bi bi-person-vcard-fill
    case person_vcard_fill = "person-vcard-fill"
    /// person-video
    /// bi bi-person-video
    case person_video = "person-video"
    /// person-video2
    /// bi bi-person-video2
    case person_video2 = "person-video2"
    /// person-video3
    /// bi bi-person-video3
    case person_video3 = "person-video3"
    /// person-walking
    /// bi bi-person-walking
    case person_walking = "person-walking"
    /// person-wheelchair
    /// bi bi-person-wheelchair
    case person_wheelchair = "person-wheelchair"
    /// person-workspace
    /// bi bi-person-workspace
    case person_workspace = "person-workspace"
    /// person-x
    /// bi bi-person-x
    case person_x = "person-x"
    /// person-x-fill
    /// bi bi-person-x-fill
    case person_x_fill = "person-x-fill"
    /// phone
    /// bi bi-phone
    case phone = "phone"
    /// phone-fill
    /// bi bi-phone-fill
    case phone_fill = "phone-fill"
    /// phone-flip
    /// bi bi-phone-flip
    case phone_flip = "phone-flip"
    /// phone-landscape
    /// bi bi-phone-landscape
    case phone_landscape = "phone-landscape"
    /// phone-landscape-fill
    /// bi bi-phone-landscape-fill
    case phone_landscape_fill = "phone-landscape-fill"
    /// phone-vibrate
    /// bi bi-phone-vibrate
    case phone_vibrate = "phone-vibrate"
    /// phone-vibrate-fill
    /// bi bi-phone-vibrate-fill
    case phone_vibrate_fill = "phone-vibrate-fill"
    /// pie-chart
    /// bi bi-pie-chart
    case pie_chart = "pie-chart"
    /// pie-chart-fill
    /// bi bi-pie-chart-fill
    case pie_chart_fill = "pie-chart-fill"
    /// piggy-bank
    /// bi bi-piggy-bank
    case piggy_bank = "piggy-bank"
    /// piggy-bank-fill
    /// bi bi-piggy-bank-fill
    case piggy_bank_fill = "piggy-bank-fill"
    /// pin
    /// bi bi-pin
    case pin = "pin"
    /// pin-angle
    /// bi bi-pin-angle
    case pin_angle = "pin-angle"
    /// pin-angle-fill
    /// bi bi-pin-angle-fill
    case pin_angle_fill = "pin-angle-fill"
    /// pin-fill
    /// bi bi-pin-fill
    case pin_fill = "pin-fill"
    /// pin-map
    /// bi bi-pin-map
    case pin_map = "pin-map"
    /// pin-map-fill
    /// bi bi-pin-map-fill
    case pin_map_fill = "pin-map-fill"
    /// pinterest
    /// bi bi-pinterest
    case pinterest = "pinterest"
    /// pip
    /// bi bi-pip
    case pip = "pip"
    /// pip-fill
    /// bi bi-pip-fill
    case pip_fill = "pip-fill"
    /// play
    /// bi bi-play
    case play = "play"
    /// play-btn
    /// bi bi-play-btn
    case play_btn = "play-btn"
    /// play-btn-fill
    /// bi bi-play-btn-fill
    case play_btn_fill = "play-btn-fill"
    /// play-circle
    /// bi bi-play-circle
    case play_circle = "play-circle"
    /// play-circle-fill
    /// bi bi-play-circle-fill
    case play_circle_fill = "play-circle-fill"
    /// play-fill
    /// bi bi-play-fill
    case play_fill = "play-fill"
    /// playstation
    /// bi bi-playstation
    case playstation = "playstation"
    /// plug
    /// bi bi-plug
    case plug = "plug"
    /// plug-fill
    /// bi bi-plug-fill
    case plug_fill = "plug-fill"
    /// plugin
    /// bi bi-plugin
    case plugin = "plugin"
    /// plus
    /// bi bi-plus
    case plus = "plus"
    /// plus-circle
    /// bi bi-plus-circle
    case plus_circle = "plus-circle"
    /// plus-circle-dotted
    /// bi bi-plus-circle-dotted
    case plus_circle_dotted = "plus-circle-dotted"
    /// plus-circle-fill
    /// bi bi-plus-circle-fill
    case plus_circle_fill = "plus-circle-fill"
    /// plus-lg
    /// bi bi-plus-lg
    case plus_lg = "plus-lg"
    /// plus-slash-minus
    /// bi bi-plus-slash-minus
    case plus_slash_minus = "plus-slash-minus"
    /// plus-square
    /// bi bi-plus-square
    case plus_square = "plus-square"
    /// plus-square-dotted
    /// bi bi-plus-square-dotted
    case plus_square_dotted = "plus-square-dotted"
    /// plus-square-fill
    /// bi bi-plus-square-fill
    case plus_square_fill = "plus-square-fill"
    /// postage
    /// bi bi-postage
    case postage = "postage"
    /// postage-fill
    /// bi bi-postage-fill
    case postage_fill = "postage-fill"
    /// postage-heart
    /// bi bi-postage-heart
    case postage_heart = "postage-heart"
    /// postage-heart-fill
    /// bi bi-postage-heart-fill
    case postage_heart_fill = "postage-heart-fill"
    /// postcard
    /// bi bi-postcard
    case postcard = "postcard"
    /// postcard-fill
    /// bi bi-postcard-fill
    case postcard_fill = "postcard-fill"
    /// postcard-heart
    /// bi bi-postcard-heart
    case postcard_heart = "postcard-heart"
    /// postcard-heart-fill
    /// bi bi-postcard-heart-fill
    case postcard_heart_fill = "postcard-heart-fill"
    /// power
    /// bi bi-power
    case power = "power"
    /// prescription
    /// bi bi-prescription
    case prescription = "prescription"
    /// prescription2
    /// bi bi-prescription2
    case prescription2 = "prescription2"
    /// printer
    /// bi bi-printer
    case printer = "printer"
    /// printer-fill
    /// bi bi-printer-fill
    case printer_fill = "printer-fill"
    /// projector
    /// bi bi-projector
    case projector = "projector"
    /// projector-fill
    /// bi bi-projector-fill
    case projector_fill = "projector-fill"
    /// puzzle
    /// bi bi-puzzle
    case puzzle = "puzzle"
    /// puzzle-fill
    /// bi bi-puzzle-fill
    case puzzle_fill = "puzzle-fill"
    /// qr-code
    /// bi bi-qr-code
    case qr_code = "qr-code"
    /// qr-code-scan
    /// bi bi-qr-code-scan
    case qr_code_scan = "qr-code-scan"
    /// question
    /// bi bi-question
    case question = "question"
    /// question-circle
    /// bi bi-question-circle
    case question_circle = "question-circle"
    /// question-circle-fill
    /// bi bi-question-circle-fill
    case question_circle_fill = "question-circle-fill"
    /// question-diamond
    /// bi bi-question-diamond
    case question_diamond = "question-diamond"
    /// question-diamond-fill
    /// bi bi-question-diamond-fill
    case question_diamond_fill = "question-diamond-fill"
    /// question-lg
    /// bi bi-question-lg
    case question_lg = "question-lg"
    /// question-octagon
    /// bi bi-question-octagon
    case question_octagon = "question-octagon"
    /// question-octagon-fill
    /// bi bi-question-octagon-fill
    case question_octagon_fill = "question-octagon-fill"
    /// question-square
    /// bi bi-question-square
    case question_square = "question-square"
    /// question-square-fill
    /// bi bi-question-square-fill
    case question_square_fill = "question-square-fill"
    /// quora
    /// bi bi-quora
    case quora = "quora"
    /// quote
    /// bi bi-quote
    case quote = "quote"
    /// r-circle
    /// bi bi-r-circle
    case r_circle = "r-circle"
    /// r-circle-fill
    /// bi bi-r-circle-fill
    case r_circle_fill = "r-circle-fill"
    /// r-square
    /// bi bi-r-square
    case r_square = "r-square"
    /// r-square-fill
    /// bi bi-r-square-fill
    case r_square_fill = "r-square-fill"
    /// radar
    /// bi bi-radar
    case radar = "radar"
    /// radioactive
    /// bi bi-radioactive
    case radioactive = "radioactive"
    /// rainbow
    /// bi bi-rainbow
    case rainbow = "rainbow"
    /// receipt
    /// bi bi-receipt
    case receipt = "receipt"
    /// receipt-cutoff
    /// bi bi-receipt-cutoff
    case receipt_cutoff = "receipt-cutoff"
    /// reception-0
    /// bi bi-reception-0
    case reception_0 = "reception-0"
    /// reception-1
    /// bi bi-reception-1
    case reception_1 = "reception-1"
    /// reception-2
    /// bi bi-reception-2
    case reception_2 = "reception-2"
    /// reception-3
    /// bi bi-reception-3
    case reception_3 = "reception-3"
    /// reception-4
    /// bi bi-reception-4
    case reception_4 = "reception-4"
    /// record
    /// bi bi-record
    case record = "record"
    /// record-btn
    /// bi bi-record-btn
    case record_btn = "record-btn"
    /// record-btn-fill
    /// bi bi-record-btn-fill
    case record_btn_fill = "record-btn-fill"
    /// record-circle
    /// bi bi-record-circle
    case record_circle = "record-circle"
    /// record-circle-fill
    /// bi bi-record-circle-fill
    case record_circle_fill = "record-circle-fill"
    /// record-fill
    /// bi bi-record-fill
    case record_fill = "record-fill"
    /// record2
    /// bi bi-record2
    case record2 = "record2"
    /// record2-fill
    /// bi bi-record2-fill
    case record2_fill = "record2-fill"
    /// recycle
    /// bi bi-recycle
    case recycle = "recycle"
    /// reddit
    /// bi bi-reddit
    case reddit = "reddit"
    /// regex
    /// bi bi-regex
    case regex = "regex"
    /// repeat
    /// bi bi-repeat
    case `repeat` = "repeat"
    /// repeat-1
    /// bi bi-repeat-1
    case repeat_1 = "repeat-1"
    /// reply
    /// bi bi-reply
    case reply = "reply"
    /// reply-all
    /// bi bi-reply-all
    case reply_all = "reply-all"
    /// reply-all-fill
    /// bi bi-reply-all-fill
    case reply_all_fill = "reply-all-fill"
    /// reply-fill
    /// bi bi-reply-fill
    case reply_fill = "reply-fill"
    /// rewind
    /// bi bi-rewind
    case rewind = "rewind"
    /// rewind-btn
    /// bi bi-rewind-btn
    case rewind_btn = "rewind-btn"
    /// rewind-btn-fill
    /// bi bi-rewind-btn-fill
    case rewind_btn_fill = "rewind-btn-fill"
    /// rewind-circle
    /// bi bi-rewind-circle
    case rewind_circle = "rewind-circle"
    /// rewind-circle-fill
    /// bi bi-rewind-circle-fill
    case rewind_circle_fill = "rewind-circle-fill"
    /// rewind-fill
    /// bi bi-rewind-fill
    case rewind_fill = "rewind-fill"
    /// robot
    /// bi bi-robot
    case robot = "robot"
    /// rocket
    /// bi bi-rocket
    case rocket = "rocket"
    /// rocket-fill
    /// bi bi-rocket-fill
    case rocket_fill = "rocket-fill"
    /// rocket-takeoff
    /// bi bi-rocket-takeoff
    case rocket_takeoff = "rocket-takeoff"
    /// rocket-takeoff-fill
    /// bi bi-rocket-takeoff-fill
    case rocket_takeoff_fill = "rocket-takeoff-fill"
    /// router
    /// bi bi-router
    case router = "router"
    /// router-fill
    /// bi bi-router-fill
    case router_fill = "router-fill"
    /// rss
    /// bi bi-rss
    case rss = "rss"
    /// rss-fill
    /// bi bi-rss-fill
    case rss_fill = "rss-fill"
    /// rulers
    /// bi bi-rulers
    case rulers = "rulers"
    /// safe
    /// bi bi-safe
    case safe = "safe"
    /// safe-fill
    /// bi bi-safe-fill
    case safe_fill = "safe-fill"
    /// safe2
    /// bi bi-safe2
    case safe2 = "safe2"
    /// safe2-fill
    /// bi bi-safe2-fill
    case safe2_fill = "safe2-fill"
    /// save
    /// bi bi-save
    case save = "save"
    /// save-fill
    /// bi bi-save-fill
    case save_fill = "save-fill"
    /// save2
    /// bi bi-save2
    case save2 = "save2"
    /// save2-fill
    /// bi bi-save2-fill
    case save2_fill = "save2-fill"
    /// scissors
    /// bi bi-scissors
    case scissors = "scissors"
    /// scooter
    /// bi bi-scooter
    case scooter = "scooter"
    /// screwdriver
    /// bi bi-screwdriver
    case screwdriver = "screwdriver"
    /// sd-card
    /// bi bi-sd-card
    case sd_card = "sd-card"
    /// sd-card-fill
    /// bi bi-sd-card-fill
    case sd_card_fill = "sd-card-fill"
    /// search
    /// bi bi-search
    case search = "search"
    /// search-heart
    /// bi bi-search-heart
    case search_heart = "search-heart"
    /// search-heart-fill
    /// bi bi-search-heart-fill
    case search_heart_fill = "search-heart-fill"
    /// segmented-nav
    /// bi bi-segmented-nav
    case segmented_nav = "segmented-nav"
    /// send
    /// bi bi-send
    case send = "send"
    /// send-arrow-down
    /// bi bi-send-arrow-down
    case send_arrow_down = "send-arrow-down"
    /// send-arrow-down-fill
    /// bi bi-send-arrow-down-fill
    case send_arrow_down_fill = "send-arrow-down-fill"
    /// send-arrow-up
    /// bi bi-send-arrow-up
    case send_arrow_up = "send-arrow-up"
    /// send-arrow-up-fill
    /// bi bi-send-arrow-up-fill
    case send_arrow_up_fill = "send-arrow-up-fill"
    /// send-check
    /// bi bi-send-check
    case send_check = "send-check"
    /// send-check-fill
    /// bi bi-send-check-fill
    case send_check_fill = "send-check-fill"
    /// send-dash
    /// bi bi-send-dash
    case send_dash = "send-dash"
    /// send-dash-fill
    /// bi bi-send-dash-fill
    case send_dash_fill = "send-dash-fill"
    /// send-exclamation
    /// bi bi-send-exclamation
    case send_exclamation = "send-exclamation"
    /// send-exclamation-fill
    /// bi bi-send-exclamation-fill
    case send_exclamation_fill = "send-exclamation-fill"
    /// send-fill
    /// bi bi-send-fill
    case send_fill = "send-fill"
    /// send-plus
    /// bi bi-send-plus
    case send_plus = "send-plus"
    /// send-plus-fill
    /// bi bi-send-plus-fill
    case send_plus_fill = "send-plus-fill"
    /// send-slash
    /// bi bi-send-slash
    case send_slash = "send-slash"
    /// send-slash-fill
    /// bi bi-send-slash-fill
    case send_slash_fill = "send-slash-fill"
    /// send-x
    /// bi bi-send-x
    case send_x = "send-x"
    /// send-x-fill
    /// bi bi-send-x-fill
    case send_x_fill = "send-x-fill"
    /// server
    /// bi bi-server
    case server = "server"
    /// shadows
    /// bi bi-shadows
    case shadows = "shadows"
    /// share
    /// bi bi-share
    case share = "share"
    /// share-fill
    /// bi bi-share-fill
    case share_fill = "share-fill"
    /// shield
    /// bi bi-shield
    case shield = "shield"
    /// shield-check
    /// bi bi-shield-check
    case shield_check = "shield-check"
    /// shield-exclamation
    /// bi bi-shield-exclamation
    case shield_exclamation = "shield-exclamation"
    /// shield-fill
    /// bi bi-shield-fill
    case shield_fill = "shield-fill"
    /// shield-fill-check
    /// bi bi-shield-fill-check
    case shield_fill_check = "shield-fill-check"
    /// shield-fill-exclamation
    /// bi bi-shield-fill-exclamation
    case shield_fill_exclamation = "shield-fill-exclamation"
    /// shield-fill-minus
    /// bi bi-shield-fill-minus
    case shield_fill_minus = "shield-fill-minus"
    /// shield-fill-plus
    /// bi bi-shield-fill-plus
    case shield_fill_plus = "shield-fill-plus"
    /// shield-fill-x
    /// bi bi-shield-fill-x
    case shield_fill_x = "shield-fill-x"
    /// shield-lock
    /// bi bi-shield-lock
    case shield_lock = "shield-lock"
    /// shield-lock-fill
    /// bi bi-shield-lock-fill
    case shield_lock_fill = "shield-lock-fill"
    /// shield-minus
    /// bi bi-shield-minus
    case shield_minus = "shield-minus"
    /// shield-plus
    /// bi bi-shield-plus
    case shield_plus = "shield-plus"
    /// shield-shaded
    /// bi bi-shield-shaded
    case shield_shaded = "shield-shaded"
    /// shield-slash
    /// bi bi-shield-slash
    case shield_slash = "shield-slash"
    /// shield-slash-fill
    /// bi bi-shield-slash-fill
    case shield_slash_fill = "shield-slash-fill"
    /// shield-x
    /// bi bi-shield-x
    case shield_x = "shield-x"
    /// shift
    /// bi bi-shift
    case shift = "shift"
    /// shift-fill
    /// bi bi-shift-fill
    case shift_fill = "shift-fill"
    /// shop
    /// bi bi-shop
    case shop = "shop"
    /// shop-window
    /// bi bi-shop-window
    case shop_window = "shop-window"
    /// shuffle
    /// bi bi-shuffle
    case shuffle = "shuffle"
    /// sign-dead-end
    /// bi bi-sign-dead-end
    case sign_dead_end = "sign-dead-end"
    /// sign-dead-end-fill
    /// bi bi-sign-dead-end-fill
    case sign_dead_end_fill = "sign-dead-end-fill"
    /// sign-do-not-enter
    /// bi bi-sign-do-not-enter
    case sign_do_not_enter = "sign-do-not-enter"
    /// sign-do-not-enter-fill
    /// bi bi-sign-do-not-enter-fill
    case sign_do_not_enter_fill = "sign-do-not-enter-fill"
    /// sign-intersection
    /// bi bi-sign-intersection
    case sign_intersection = "sign-intersection"
    /// sign-intersection-fill
    /// bi bi-sign-intersection-fill
    case sign_intersection_fill = "sign-intersection-fill"
    /// sign-intersection-side
    /// bi bi-sign-intersection-side
    case sign_intersection_side = "sign-intersection-side"
    /// sign-intersection-side-fill
    /// bi bi-sign-intersection-side-fill
    case sign_intersection_side_fill = "sign-intersection-side-fill"
    /// sign-intersection-t
    /// bi bi-sign-intersection-t
    case sign_intersection_t = "sign-intersection-t"
    /// sign-intersection-t-fill
    /// bi bi-sign-intersection-t-fill
    case sign_intersection_t_fill = "sign-intersection-t-fill"
    /// sign-intersection-y
    /// bi bi-sign-intersection-y
    case sign_intersection_y = "sign-intersection-y"
    /// sign-intersection-y-fill
    /// bi bi-sign-intersection-y-fill
    case sign_intersection_y_fill = "sign-intersection-y-fill"
    /// sign-merge-left
    /// bi bi-sign-merge-left
    case sign_merge_left = "sign-merge-left"
    /// sign-merge-left-fill
    /// bi bi-sign-merge-left-fill
    case sign_merge_left_fill = "sign-merge-left-fill"
    /// sign-merge-right
    /// bi bi-sign-merge-right
    case sign_merge_right = "sign-merge-right"
    /// sign-merge-right-fill
    /// bi bi-sign-merge-right-fill
    case sign_merge_right_fill = "sign-merge-right-fill"
    /// sign-no-left-turn
    /// bi bi-sign-no-left-turn
    case sign_no_left_turn = "sign-no-left-turn"
    /// sign-no-left-turn-fill
    /// bi bi-sign-no-left-turn-fill
    case sign_no_left_turn_fill = "sign-no-left-turn-fill"
    /// sign-no-parking
    /// bi bi-sign-no-parking
    case sign_no_parking = "sign-no-parking"
    /// sign-no-parking-fill
    /// bi bi-sign-no-parking-fill
    case sign_no_parking_fill = "sign-no-parking-fill"
    /// sign-no-right-turn
    /// bi bi-sign-no-right-turn
    case sign_no_right_turn = "sign-no-right-turn"
    /// sign-no-right-turn-fill
    /// bi bi-sign-no-right-turn-fill
    case sign_no_right_turn_fill = "sign-no-right-turn-fill"
    /// sign-railroad
    /// bi bi-sign-railroad
    case sign_railroad = "sign-railroad"
    /// sign-railroad-fill
    /// bi bi-sign-railroad-fill
    case sign_railroad_fill = "sign-railroad-fill"
    /// sign-stop
    /// bi bi-sign-stop
    case sign_stop = "sign-stop"
    /// sign-stop-fill
    /// bi bi-sign-stop-fill
    case sign_stop_fill = "sign-stop-fill"
    /// sign-stop-lights
    /// bi bi-sign-stop-lights
    case sign_stop_lights = "sign-stop-lights"
    /// sign-stop-lights-fill
    /// bi bi-sign-stop-lights-fill
    case sign_stop_lights_fill = "sign-stop-lights-fill"
    /// sign-turn-left
    /// bi bi-sign-turn-left
    case sign_turn_left = "sign-turn-left"
    /// sign-turn-left-fill
    /// bi bi-sign-turn-left-fill
    case sign_turn_left_fill = "sign-turn-left-fill"
    /// sign-turn-right
    /// bi bi-sign-turn-right
    case sign_turn_right = "sign-turn-right"
    /// sign-turn-right-fill
    /// bi bi-sign-turn-right-fill
    case sign_turn_right_fill = "sign-turn-right-fill"
    /// sign-turn-slight-left
    /// bi bi-sign-turn-slight-left
    case sign_turn_slight_left = "sign-turn-slight-left"
    /// sign-turn-slight-left-fill
    /// bi bi-sign-turn-slight-left-fill
    case sign_turn_slight_left_fill = "sign-turn-slight-left-fill"
    /// sign-turn-slight-right
    /// bi bi-sign-turn-slight-right
    case sign_turn_slight_right = "sign-turn-slight-right"
    /// sign-turn-slight-right-fill
    /// bi bi-sign-turn-slight-right-fill
    case sign_turn_slight_right_fill = "sign-turn-slight-right-fill"
    /// sign-yield
    /// bi bi-sign-yield
    case sign_yield = "sign-yield"
    /// sign-yield-fill
    /// bi bi-sign-yield-fill
    case sign_yield_fill = "sign-yield-fill"
    /// signal
    /// bi bi-signal
    case signal = "signal"
    /// signpost
    /// bi bi-signpost
    case signpost = "signpost"
    /// signpost-2
    /// bi bi-signpost-2
    case signpost_2 = "signpost-2"
    /// signpost-2-fill
    /// bi bi-signpost-2-fill
    case signpost_2_fill = "signpost-2-fill"
    /// signpost-fill
    /// bi bi-signpost-fill
    case signpost_fill = "signpost-fill"
    /// signpost-split
    /// bi bi-signpost-split
    case signpost_split = "signpost-split"
    /// signpost-split-fill
    /// bi bi-signpost-split-fill
    case signpost_split_fill = "signpost-split-fill"
    /// sim
    /// bi bi-sim
    case sim = "sim"
    /// sim-fill
    /// bi bi-sim-fill
    case sim_fill = "sim-fill"
    /// sim-slash
    /// bi bi-sim-slash
    case sim_slash = "sim-slash"
    /// sim-slash-fill
    /// bi bi-sim-slash-fill
    case sim_slash_fill = "sim-slash-fill"
    /// sina-weibo
    /// bi bi-sina-weibo
    case sina_weibo = "sina-weibo"
    /// skip-backward
    /// bi bi-skip-backward
    case skip_backward = "skip-backward"
    /// skip-backward-btn
    /// bi bi-skip-backward-btn
    case skip_backward_btn = "skip-backward-btn"
    /// skip-backward-btn-fill
    /// bi bi-skip-backward-btn-fill
    case skip_backward_btn_fill = "skip-backward-btn-fill"
    /// skip-backward-circle
    /// bi bi-skip-backward-circle
    case skip_backward_circle = "skip-backward-circle"
    /// skip-backward-circle-fill
    /// bi bi-skip-backward-circle-fill
    case skip_backward_circle_fill = "skip-backward-circle-fill"
    /// skip-backward-fill
    /// bi bi-skip-backward-fill
    case skip_backward_fill = "skip-backward-fill"
    /// skip-end
    /// bi bi-skip-end
    case skip_end = "skip-end"
    /// skip-end-btn
    /// bi bi-skip-end-btn
    case skip_end_btn = "skip-end-btn"
    /// skip-end-btn-fill
    /// bi bi-skip-end-btn-fill
    case skip_end_btn_fill = "skip-end-btn-fill"
    /// skip-end-circle
    /// bi bi-skip-end-circle
    case skip_end_circle = "skip-end-circle"
    /// skip-end-circle-fill
    /// bi bi-skip-end-circle-fill
    case skip_end_circle_fill = "skip-end-circle-fill"
    /// skip-end-fill
    /// bi bi-skip-end-fill
    case skip_end_fill = "skip-end-fill"
    /// skip-forward
    /// bi bi-skip-forward
    case skip_forward = "skip-forward"
    /// skip-forward-btn
    /// bi bi-skip-forward-btn
    case skip_forward_btn = "skip-forward-btn"
    /// skip-forward-btn-fill
    /// bi bi-skip-forward-btn-fill
    case skip_forward_btn_fill = "skip-forward-btn-fill"
    /// skip-forward-circle
    /// bi bi-skip-forward-circle
    case skip_forward_circle = "skip-forward-circle"
    /// skip-forward-circle-fill
    /// bi bi-skip-forward-circle-fill
    case skip_forward_circle_fill = "skip-forward-circle-fill"
    /// skip-forward-fill
    /// bi bi-skip-forward-fill
    case skip_forward_fill = "skip-forward-fill"
    /// skip-start
    /// bi bi-skip-start
    case skip_start = "skip-start"
    /// skip-start-btn
    /// bi bi-skip-start-btn
    case skip_start_btn = "skip-start-btn"
    /// skip-start-btn-fill
    /// bi bi-skip-start-btn-fill
    case skip_start_btn_fill = "skip-start-btn-fill"
    /// skip-start-circle
    /// bi bi-skip-start-circle
    case skip_start_circle = "skip-start-circle"
    /// skip-start-circle-fill
    /// bi bi-skip-start-circle-fill
    case skip_start_circle_fill = "skip-start-circle-fill"
    /// skip-start-fill
    /// bi bi-skip-start-fill
    case skip_start_fill = "skip-start-fill"
    /// skype
    /// bi bi-skype
    case skype = "skype"
    /// slack
    /// bi bi-slack
    case slack = "slack"
    /// slash
    /// bi bi-slash
    case slash = "slash"
    /// slash-circle
    /// bi bi-slash-circle
    case slash_circle = "slash-circle"
    /// slash-circle-fill
    /// bi bi-slash-circle-fill
    case slash_circle_fill = "slash-circle-fill"
    /// slash-lg
    /// bi bi-slash-lg
    case slash_lg = "slash-lg"
    /// slash-square
    /// bi bi-slash-square
    case slash_square = "slash-square"
    /// slash-square-fill
    /// bi bi-slash-square-fill
    case slash_square_fill = "slash-square-fill"
    /// sliders
    /// bi bi-sliders
    case sliders = "sliders"
    /// sliders2
    /// bi bi-sliders2
    case sliders2 = "sliders2"
    /// sliders2-vertical
    /// bi bi-sliders2-vertical
    case sliders2_vertical = "sliders2-vertical"
    /// smartwatch
    /// bi bi-smartwatch
    case smartwatch = "smartwatch"
    /// snapchat
    /// bi bi-snapchat
    case snapchat = "snapchat"
    /// snow
    /// bi bi-snow
    case snow = "snow"
    /// snow2
    /// bi bi-snow2
    case snow2 = "snow2"
    /// snow3
    /// bi bi-snow3
    case snow3 = "snow3"
    /// sort-alpha-down
    /// bi bi-sort-alpha-down
    case sort_alpha_down = "sort-alpha-down"
    /// sort-alpha-down-alt
    /// bi bi-sort-alpha-down-alt
    case sort_alpha_down_alt = "sort-alpha-down-alt"
    /// sort-alpha-up
    /// bi bi-sort-alpha-up
    case sort_alpha_up = "sort-alpha-up"
    /// sort-alpha-up-alt
    /// bi bi-sort-alpha-up-alt
    case sort_alpha_up_alt = "sort-alpha-up-alt"
    /// sort-down
    /// bi bi-sort-down
    case sort_down = "sort-down"
    /// sort-down-alt
    /// bi bi-sort-down-alt
    case sort_down_alt = "sort-down-alt"
    /// sort-numeric-down
    /// bi bi-sort-numeric-down
    case sort_numeric_down = "sort-numeric-down"
    /// sort-numeric-down-alt
    /// bi bi-sort-numeric-down-alt
    case sort_numeric_down_alt = "sort-numeric-down-alt"
    /// sort-numeric-up
    /// bi bi-sort-numeric-up
    case sort_numeric_up = "sort-numeric-up"
    /// sort-numeric-up-alt
    /// bi bi-sort-numeric-up-alt
    case sort_numeric_up_alt = "sort-numeric-up-alt"
    /// sort-up
    /// bi bi-sort-up
    case sort_up = "sort-up"
    /// sort-up-alt
    /// bi bi-sort-up-alt
    case sort_up_alt = "sort-up-alt"
    /// soundwave
    /// bi bi-soundwave
    case soundwave = "soundwave"
    /// sourceforge
    /// bi bi-sourceforge
    case sourceforge = "sourceforge"
    /// speaker
    /// bi bi-speaker
    case speaker = "speaker"
    /// speaker-fill
    /// bi bi-speaker-fill
    case speaker_fill = "speaker-fill"
    /// speedometer
    /// bi bi-speedometer
    case speedometer = "speedometer"
    /// speedometer2
    /// bi bi-speedometer2
    case speedometer2 = "speedometer2"
    /// spellcheck
    /// bi bi-spellcheck
    case spellcheck = "spellcheck"
    /// spotify
    /// bi bi-spotify
    case spotify = "spotify"
    /// square
    /// bi bi-square
    case square = "square"
    /// square-fill
    /// bi bi-square-fill
    case square_fill = "square-fill"
    /// square-half
    /// bi bi-square-half
    case square_half = "square-half"
    /// stack
    /// bi bi-stack
    case stack = "stack"
    /// stack-overflow
    /// bi bi-stack-overflow
    case stack_overflow = "stack-overflow"
    /// star
    /// bi bi-star
    case star = "star"
    /// star-fill
    /// bi bi-star-fill
    case star_fill = "star-fill"
    /// star-half
    /// bi bi-star-half
    case star_half = "star-half"
    /// stars
    /// bi bi-stars
    case stars = "stars"
    /// steam
    /// bi bi-steam
    case steam = "steam"
    /// stickies
    /// bi bi-stickies
    case stickies = "stickies"
    /// stickies-fill
    /// bi bi-stickies-fill
    case stickies_fill = "stickies-fill"
    /// sticky
    /// bi bi-sticky
    case sticky = "sticky"
    /// sticky-fill
    /// bi bi-sticky-fill
    case sticky_fill = "sticky-fill"
    /// stop
    /// bi bi-stop
    case stop = "stop"
    /// stop-btn
    /// bi bi-stop-btn
    case stop_btn = "stop-btn"
    /// stop-btn-fill
    /// bi bi-stop-btn-fill
    case stop_btn_fill = "stop-btn-fill"
    /// stop-circle
    /// bi bi-stop-circle
    case stop_circle = "stop-circle"
    /// stop-circle-fill
    /// bi bi-stop-circle-fill
    case stop_circle_fill = "stop-circle-fill"
    /// stop-fill
    /// bi bi-stop-fill
    case stop_fill = "stop-fill"
    /// stoplights
    /// bi bi-stoplights
    case stoplights = "stoplights"
    /// stoplights-fill
    /// bi bi-stoplights-fill
    case stoplights_fill = "stoplights-fill"
    /// stopwatch
    /// bi bi-stopwatch
    case stopwatch = "stopwatch"
    /// stopwatch-fill
    /// bi bi-stopwatch-fill
    case stopwatch_fill = "stopwatch-fill"
    /// strava
    /// bi bi-strava
    case strava = "strava"
    /// stripe
    /// bi bi-stripe
    case stripe = "stripe"
    /// subscript
    /// bi bi-subscript
    case `subscript` = "subscript"
    /// substack
    /// bi bi-substack
    case substack = "substack"
    /// subtract
    /// bi bi-subtract
    case subtract = "subtract"
    /// suit-club
    /// bi bi-suit-club
    case suit_club = "suit-club"
    /// suit-club-fill
    /// bi bi-suit-club-fill
    case suit_club_fill = "suit-club-fill"
    /// suit-diamond
    /// bi bi-suit-diamond
    case suit_diamond = "suit-diamond"
    /// suit-diamond-fill
    /// bi bi-suit-diamond-fill
    case suit_diamond_fill = "suit-diamond-fill"
    /// suit-heart
    /// bi bi-suit-heart
    case suit_heart = "suit-heart"
    /// suit-heart-fill
    /// bi bi-suit-heart-fill
    case suit_heart_fill = "suit-heart-fill"
    /// suit-spade
    /// bi bi-suit-spade
    case suit_spade = "suit-spade"
    /// suit-spade-fill
    /// bi bi-suit-spade-fill
    case suit_spade_fill = "suit-spade-fill"
    /// suitcase
    /// bi bi-suitcase
    case suitcase = "suitcase"
    /// suitcase-fill
    /// bi bi-suitcase-fill
    case suitcase_fill = "suitcase-fill"
    /// suitcase-lg
    /// bi bi-suitcase-lg
    case suitcase_lg = "suitcase-lg"
    /// suitcase-lg-fill
    /// bi bi-suitcase-lg-fill
    case suitcase_lg_fill = "suitcase-lg-fill"
    /// suitcase2
    /// bi bi-suitcase2
    case suitcase2 = "suitcase2"
    /// suitcase2-fill
    /// bi bi-suitcase2-fill
    case suitcase2_fill = "suitcase2-fill"
    /// sun
    /// bi bi-sun
    case sun = "sun"
    /// sun-fill
    /// bi bi-sun-fill
    case sun_fill = "sun-fill"
    /// sunglasses
    /// bi bi-sunglasses
    case sunglasses = "sunglasses"
    /// sunrise
    /// bi bi-sunrise
    case sunrise = "sunrise"
    /// sunrise-fill
    /// bi bi-sunrise-fill
    case sunrise_fill = "sunrise-fill"
    /// sunset
    /// bi bi-sunset
    case sunset = "sunset"
    /// sunset-fill
    /// bi bi-sunset-fill
    case sunset_fill = "sunset-fill"
    /// superscript
    /// bi bi-superscript
    case superscript = "superscript"
    /// symmetry-horizontal
    /// bi bi-symmetry-horizontal
    case symmetry_horizontal = "symmetry-horizontal"
    /// symmetry-vertical
    /// bi bi-symmetry-vertical
    case symmetry_vertical = "symmetry-vertical"
    /// table
    /// bi bi-table
    case table = "table"
    /// tablet
    /// bi bi-tablet
    case tablet = "tablet"
    /// tablet-fill
    /// bi bi-tablet-fill
    case tablet_fill = "tablet-fill"
    /// tablet-landscape
    /// bi bi-tablet-landscape
    case tablet_landscape = "tablet-landscape"
    /// tablet-landscape-fill
    /// bi bi-tablet-landscape-fill
    case tablet_landscape_fill = "tablet-landscape-fill"
    /// tag
    /// bi bi-tag
    case tag = "tag"
    /// tag-fill
    /// bi bi-tag-fill
    case tag_fill = "tag-fill"
    /// tags
    /// bi bi-tags
    case tags = "tags"
    /// tags-fill
    /// bi bi-tags-fill
    case tags_fill = "tags-fill"
    /// taxi-front
    /// bi bi-taxi-front
    case taxi_front = "taxi-front"
    /// taxi-front-fill
    /// bi bi-taxi-front-fill
    case taxi_front_fill = "taxi-front-fill"
    /// telegram
    /// bi bi-telegram
    case telegram = "telegram"
    /// telephone
    /// bi bi-telephone
    case telephone = "telephone"
    /// telephone-fill
    /// bi bi-telephone-fill
    case telephone_fill = "telephone-fill"
    /// telephone-forward
    /// bi bi-telephone-forward
    case telephone_forward = "telephone-forward"
    /// telephone-forward-fill
    /// bi bi-telephone-forward-fill
    case telephone_forward_fill = "telephone-forward-fill"
    /// telephone-inbound
    /// bi bi-telephone-inbound
    case telephone_inbound = "telephone-inbound"
    /// telephone-inbound-fill
    /// bi bi-telephone-inbound-fill
    case telephone_inbound_fill = "telephone-inbound-fill"
    /// telephone-minus
    /// bi bi-telephone-minus
    case telephone_minus = "telephone-minus"
    /// telephone-minus-fill
    /// bi bi-telephone-minus-fill
    case telephone_minus_fill = "telephone-minus-fill"
    /// telephone-outbound
    /// bi bi-telephone-outbound
    case telephone_outbound = "telephone-outbound"
    /// telephone-outbound-fill
    /// bi bi-telephone-outbound-fill
    case telephone_outbound_fill = "telephone-outbound-fill"
    /// telephone-plus
    /// bi bi-telephone-plus
    case telephone_plus = "telephone-plus"
    /// telephone-plus-fill
    /// bi bi-telephone-plus-fill
    case telephone_plus_fill = "telephone-plus-fill"
    /// telephone-x
    /// bi bi-telephone-x
    case telephone_x = "telephone-x"
    /// telephone-x-fill
    /// bi bi-telephone-x-fill
    case telephone_x_fill = "telephone-x-fill"
    /// tencent-qq
    /// bi bi-tencent-qq
    case tencent_qq = "tencent-qq"
    /// terminal
    /// bi bi-terminal
    case terminal = "terminal"
    /// terminal-dash
    /// bi bi-terminal-dash
    case terminal_dash = "terminal-dash"
    /// terminal-fill
    /// bi bi-terminal-fill
    case terminal_fill = "terminal-fill"
    /// terminal-plus
    /// bi bi-terminal-plus
    case terminal_plus = "terminal-plus"
    /// terminal-split
    /// bi bi-terminal-split
    case terminal_split = "terminal-split"
    /// terminal-x
    /// bi bi-terminal-x
    case terminal_x = "terminal-x"
    /// text-center
    /// bi bi-text-center
    case text_center = "text-center"
    /// text-indent-left
    /// bi bi-text-indent-left
    case text_indent_left = "text-indent-left"
    /// text-indent-right
    /// bi bi-text-indent-right
    case text_indent_right = "text-indent-right"
    /// text-left
    /// bi bi-text-left
    case text_left = "text-left"
    /// text-paragraph
    /// bi bi-text-paragraph
    case text_paragraph = "text-paragraph"
    /// text-right
    /// bi bi-text-right
    case text_right = "text-right"
    /// text-wrap
    /// bi bi-text-wrap
    case text_wrap = "text-wrap"
    /// textarea
    /// bi bi-textarea
    case textarea = "textarea"
    /// textarea-resize
    /// bi bi-textarea-resize
    case textarea_resize = "textarea-resize"
    /// textarea-t
    /// bi bi-textarea-t
    case textarea_t = "textarea-t"
    /// thermometer
    /// bi bi-thermometer
    case thermometer = "thermometer"
    /// thermometer-half
    /// bi bi-thermometer-half
    case thermometer_half = "thermometer-half"
    /// thermometer-high
    /// bi bi-thermometer-high
    case thermometer_high = "thermometer-high"
    /// thermometer-low
    /// bi bi-thermometer-low
    case thermometer_low = "thermometer-low"
    /// thermometer-snow
    /// bi bi-thermometer-snow
    case thermometer_snow = "thermometer-snow"
    /// thermometer-sun
    /// bi bi-thermometer-sun
    case thermometer_sun = "thermometer-sun"
    /// threads
    /// bi bi-threads
    case threads = "threads"
    /// threads-fill
    /// bi bi-threads-fill
    case threads_fill = "threads-fill"
    /// three-dots
    /// bi bi-three-dots
    case three_dots = "three-dots"
    /// three-dots-vertical
    /// bi bi-three-dots-vertical
    case three_dots_vertical = "three-dots-vertical"
    /// thunderbolt
    /// bi bi-thunderbolt
    case thunderbolt = "thunderbolt"
    /// thunderbolt-fill
    /// bi bi-thunderbolt-fill
    case thunderbolt_fill = "thunderbolt-fill"
    /// ticket
    /// bi bi-ticket
    case ticket = "ticket"
    /// ticket-detailed
    /// bi bi-ticket-detailed
    case ticket_detailed = "ticket-detailed"
    /// ticket-detailed-fill
    /// bi bi-ticket-detailed-fill
    case ticket_detailed_fill = "ticket-detailed-fill"
    /// ticket-fill
    /// bi bi-ticket-fill
    case ticket_fill = "ticket-fill"
    /// ticket-perforated
    /// bi bi-ticket-perforated
    case ticket_perforated = "ticket-perforated"
    /// ticket-perforated-fill
    /// bi bi-ticket-perforated-fill
    case ticket_perforated_fill = "ticket-perforated-fill"
    /// tiktok
    /// bi bi-tiktok
    case tiktok = "tiktok"
    /// toggle-off
    /// bi bi-toggle-off
    case toggle_off = "toggle-off"
    /// toggle-on
    /// bi bi-toggle-on
    case toggle_on = "toggle-on"
    /// toggle2-off
    /// bi bi-toggle2-off
    case toggle2_off = "toggle2-off"
    /// toggle2-on
    /// bi bi-toggle2-on
    case toggle2_on = "toggle2-on"
    /// toggles
    /// bi bi-toggles
    case toggles = "toggles"
    /// toggles2
    /// bi bi-toggles2
    case toggles2 = "toggles2"
    /// tools
    /// bi bi-tools
    case tools = "tools"
    /// tornado
    /// bi bi-tornado
    case tornado = "tornado"
    /// train-freight-front
    /// bi bi-train-freight-front
    case train_freight_front = "train-freight-front"
    /// train-freight-front-fill
    /// bi bi-train-freight-front-fill
    case train_freight_front_fill = "train-freight-front-fill"
    /// train-front
    /// bi bi-train-front
    case train_front = "train-front"
    /// train-front-fill
    /// bi bi-train-front-fill
    case train_front_fill = "train-front-fill"
    /// train-lightrail-front
    /// bi bi-train-lightrail-front
    case train_lightrail_front = "train-lightrail-front"
    /// train-lightrail-front-fill
    /// bi bi-train-lightrail-front-fill
    case train_lightrail_front_fill = "train-lightrail-front-fill"
    /// translate
    /// bi bi-translate
    case translate = "translate"
    /// transparency
    /// bi bi-transparency
    case transparency = "transparency"
    /// trash
    /// bi bi-trash
    case trash = "trash"
    /// trash-fill
    /// bi bi-trash-fill
    case trash_fill = "trash-fill"
    /// trash2
    /// bi bi-trash2
    case trash2 = "trash2"
    /// trash2-fill
    /// bi bi-trash2-fill
    case trash2_fill = "trash2-fill"
    /// trash3
    /// bi bi-trash3
    case trash3 = "trash3"
    /// trash3-fill
    /// bi bi-trash3-fill
    case trash3_fill = "trash3-fill"
    /// tree
    /// bi bi-tree
    case tree = "tree"
    /// tree-fill
    /// bi bi-tree-fill
    case tree_fill = "tree-fill"
    /// trello
    /// bi bi-trello
    case trello = "trello"
    /// triangle
    /// bi bi-triangle
    case triangle = "triangle"
    /// triangle-fill
    /// bi bi-triangle-fill
    case triangle_fill = "triangle-fill"
    /// triangle-half
    /// bi bi-triangle-half
    case triangle_half = "triangle-half"
    /// trophy
    /// bi bi-trophy
    case trophy = "trophy"
    /// trophy-fill
    /// bi bi-trophy-fill
    case trophy_fill = "trophy-fill"
    /// tropical-storm
    /// bi bi-tropical-storm
    case tropical_storm = "tropical-storm"
    /// truck
    /// bi bi-truck
    case truck = "truck"
    /// truck-flatbed
    /// bi bi-truck-flatbed
    case truck_flatbed = "truck-flatbed"
    /// truck-front
    /// bi bi-truck-front
    case truck_front = "truck-front"
    /// truck-front-fill
    /// bi bi-truck-front-fill
    case truck_front_fill = "truck-front-fill"
    /// tsunami
    /// bi bi-tsunami
    case tsunami = "tsunami"
    /// tux
    /// bi bi-tux
    case tux = "tux"
    /// tv
    /// bi bi-tv
    case tv = "tv"
    /// tv-fill
    /// bi bi-tv-fill
    case tv_fill = "tv-fill"
    /// twitch
    /// bi bi-twitch
    case twitch = "twitch"
    /// twitter
    /// bi bi-twitter
    case twitter = "twitter"
    /// twitter-x
    /// bi bi-twitter-x
    case twitter_x = "twitter-x"
    /// type
    /// bi bi-type
    case type = "type"
    /// type-bold
    /// bi bi-type-bold
    case type_bold = "type-bold"
    /// type-h1
    /// bi bi-type-h1
    case type_h1 = "type-h1"
    /// type-h2
    /// bi bi-type-h2
    case type_h2 = "type-h2"
    /// type-h3
    /// bi bi-type-h3
    case type_h3 = "type-h3"
    /// type-h4
    /// bi bi-type-h4
    case type_h4 = "type-h4"
    /// type-h5
    /// bi bi-type-h5
    case type_h5 = "type-h5"
    /// type-h6
    /// bi bi-type-h6
    case type_h6 = "type-h6"
    /// type-italic
    /// bi bi-type-italic
    case type_italic = "type-italic"
    /// type-strikethrough
    /// bi bi-type-strikethrough
    case type_strikethrough = "type-strikethrough"
    /// type-underline
    /// bi bi-type-underline
    case type_underline = "type-underline"
    /// typescript
    /// bi bi-typescript
    case typescript = "typescript"
    /// ubuntu
    /// bi bi-ubuntu
    case ubuntu = "ubuntu"
    /// ui-checks
    /// bi bi-ui-checks
    case ui_checks = "ui-checks"
    /// ui-checks-grid
    /// bi bi-ui-checks-grid
    case ui_checks_grid = "ui-checks-grid"
    /// ui-radios
    /// bi bi-ui-radios
    case ui_radios = "ui-radios"
    /// ui-radios-grid
    /// bi bi-ui-radios-grid
    case ui_radios_grid = "ui-radios-grid"
    /// umbrella
    /// bi bi-umbrella
    case umbrella = "umbrella"
    /// umbrella-fill
    /// bi bi-umbrella-fill
    case umbrella_fill = "umbrella-fill"
    /// unindent
    /// bi bi-unindent
    case unindent = "unindent"
    /// union
    /// bi bi-union
    case union = "union"
    /// unity
    /// bi bi-unity
    case unity = "unity"
    /// universal-access
    /// bi bi-universal-access
    case universal_access = "universal-access"
    /// universal-access-circle
    /// bi bi-universal-access-circle
    case universal_access_circle = "universal-access-circle"
    /// unlock
    /// bi bi-unlock
    case unlock = "unlock"
    /// unlock-fill
    /// bi bi-unlock-fill
    case unlock_fill = "unlock-fill"
    /// unlock2
    /// bi bi-unlock2
    case unlock2 = "unlock2"
    /// unlock2-fill
    /// bi bi-unlock2-fill
    case unlock2_fill = "unlock2-fill"
    /// upc
    /// bi bi-upc
    case upc = "upc"
    /// upc-scan
    /// bi bi-upc-scan
    case upc_scan = "upc-scan"
    /// upload
    /// bi bi-upload
    case upload = "upload"
    /// usb
    /// bi bi-usb
    case usb = "usb"
    /// usb-c
    /// bi bi-usb-c
    case usb_c = "usb-c"
    /// usb-c-fill
    /// bi bi-usb-c-fill
    case usb_c_fill = "usb-c-fill"
    /// usb-drive
    /// bi bi-usb-drive
    case usb_drive = "usb-drive"
    /// usb-drive-fill
    /// bi bi-usb-drive-fill
    case usb_drive_fill = "usb-drive-fill"
    /// usb-fill
    /// bi bi-usb-fill
    case usb_fill = "usb-fill"
    /// usb-micro
    /// bi bi-usb-micro
    case usb_micro = "usb-micro"
    /// usb-micro-fill
    /// bi bi-usb-micro-fill
    case usb_micro_fill = "usb-micro-fill"
    /// usb-mini
    /// bi bi-usb-mini
    case usb_mini = "usb-mini"
    /// usb-mini-fill
    /// bi bi-usb-mini-fill
    case usb_mini_fill = "usb-mini-fill"
    /// usb-plug
    /// bi bi-usb-plug
    case usb_plug = "usb-plug"
    /// usb-plug-fill
    /// bi bi-usb-plug-fill
    case usb_plug_fill = "usb-plug-fill"
    /// usb-symbol
    /// bi bi-usb-symbol
    case usb_symbol = "usb-symbol"
    /// valentine
    /// bi bi-valentine
    case valentine = "valentine"
    /// valentine2
    /// bi bi-valentine2
    case valentine2 = "valentine2"
    /// vector-pen
    /// bi bi-vector-pen
    case vector_pen = "vector-pen"
    /// view-list
    /// bi bi-view-list
    case view_list = "view-list"
    /// view-stacked
    /// bi bi-view-stacked
    case view_stacked = "view-stacked"
    /// vignette
    /// bi bi-vignette
    case vignette = "vignette"
    /// vimeo
    /// bi bi-vimeo
    case vimeo = "vimeo"
    /// vinyl
    /// bi bi-vinyl
    case vinyl = "vinyl"
    /// vinyl-fill
    /// bi bi-vinyl-fill
    case vinyl_fill = "vinyl-fill"
    /// virus
    /// bi bi-virus
    case virus = "virus"
    /// virus2
    /// bi bi-virus2
    case virus2 = "virus2"
    /// voicemail
    /// bi bi-voicemail
    case voicemail = "voicemail"
    /// volume-down
    /// bi bi-volume-down
    case volume_down = "volume-down"
    /// volume-down-fill
    /// bi bi-volume-down-fill
    case volume_down_fill = "volume-down-fill"
    /// volume-mute
    /// bi bi-volume-mute
    case volume_mute = "volume-mute"
    /// volume-mute-fill
    /// bi bi-volume-mute-fill
    case volume_mute_fill = "volume-mute-fill"
    /// volume-off
    /// bi bi-volume-off
    case volume_off = "volume-off"
    /// volume-off-fill
    /// bi bi-volume-off-fill
    case volume_off_fill = "volume-off-fill"
    /// volume-up
    /// bi bi-volume-up
    case volume_up = "volume-up"
    /// volume-up-fill
    /// bi bi-volume-up-fill
    case volume_up_fill = "volume-up-fill"
    /// vr
    /// bi bi-vr
    case vr = "vr"
    /// wallet
    /// bi bi-wallet
    case wallet = "wallet"
    /// wallet-fill
    /// bi bi-wallet-fill
    case wallet_fill = "wallet-fill"
    /// wallet2
    /// bi bi-wallet2
    case wallet2 = "wallet2"
    /// watch
    /// bi bi-watch
    case watch = "watch"
    /// water
    /// bi bi-water
    case water = "water"
    /// webcam
    /// bi bi-webcam
    case webcam = "webcam"
    /// webcam-fill
    /// bi bi-webcam-fill
    case webcam_fill = "webcam-fill"
    /// wechat
    /// bi bi-wechat
    case wechat = "wechat"
    /// whatsapp
    /// bi bi-whatsapp
    case whatsapp = "whatsapp"
    /// wifi
    /// bi bi-wifi
    case wifi = "wifi"
    /// wifi-1
    /// bi bi-wifi-1
    case wifi_1 = "wifi-1"
    /// wifi-2
    /// bi bi-wifi-2
    case wifi_2 = "wifi-2"
    /// wifi-off
    /// bi bi-wifi-off
    case wifi_off = "wifi-off"
    /// wikipedia
    /// bi bi-wikipedia
    case wikipedia = "wikipedia"
    /// wind
    /// bi bi-wind
    case wind = "wind"
    /// window
    /// bi bi-window
    case window = "window"
    /// window-dash
    /// bi bi-window-dash
    case window_dash = "window-dash"
    /// window-desktop
    /// bi bi-window-desktop
    case window_desktop = "window-desktop"
    /// window-dock
    /// bi bi-window-dock
    case window_dock = "window-dock"
    /// window-fullscreen
    /// bi bi-window-fullscreen
    case window_fullscreen = "window-fullscreen"
    /// window-plus
    /// bi bi-window-plus
    case window_plus = "window-plus"
    /// window-sidebar
    /// bi bi-window-sidebar
    case window_sidebar = "window-sidebar"
    /// window-split
    /// bi bi-window-split
    case window_split = "window-split"
    /// window-stack
    /// bi bi-window-stack
    case window_stack = "window-stack"
    /// window-x
    /// bi bi-window-x
    case window_x = "window-x"
    /// windows
    /// bi bi-windows
    case windows = "windows"
    /// wordpress
    /// bi bi-wordpress
    case wordpress = "wordpress"
    /// wrench
    /// bi bi-wrench
    case wrench = "wrench"
    /// wrench-adjustable
    /// bi bi-wrench-adjustable
    case wrench_adjustable = "wrench-adjustable"
    /// wrench-adjustable-circle
    /// bi bi-wrench-adjustable-circle
    case wrench_adjustable_circle = "wrench-adjustable-circle"
    /// wrench-adjustable-circle-fill
    /// bi bi-wrench-adjustable-circle-fill
    case wrench_adjustable_circle_fill = "wrench-adjustable-circle-fill"
    /// x
    /// bi bi-x
    case x = "x"
    /// x-circle
    /// bi bi-x-circle
    case x_circle = "x-circle"
    /// x-circle-fill
    /// bi bi-x-circle-fill
    case x_circle_fill = "x-circle-fill"
    /// x-diamond
    /// bi bi-x-diamond
    case x_diamond = "x-diamond"
    /// x-diamond-fill
    /// bi bi-x-diamond-fill
    case x_diamond_fill = "x-diamond-fill"
    /// x-lg
    /// bi bi-x-lg
    case x_lg = "x-lg"
    /// x-octagon
    /// bi bi-x-octagon
    case x_octagon = "x-octagon"
    /// x-octagon-fill
    /// bi bi-x-octagon-fill
    case x_octagon_fill = "x-octagon-fill"
    /// x-square
    /// bi bi-x-square
    case x_square = "x-square"
    /// x-square-fill
    /// bi bi-x-square-fill
    case x_square_fill = "x-square-fill"
    /// xbox
    /// bi bi-xbox
    case xbox = "xbox"
    /// yelp
    /// bi bi-yelp
    case yelp = "yelp"
    /// yin-yang
    /// bi bi-yin-yang
    case yin_yang = "yin-yang"
    /// youtube
    /// bi bi-youtube
    case youtube = "youtube"
    /// zoom-in
    /// bi bi-zoom-in
    case zoom_in = "zoom-in"
    /// zoom-out
    /// bi bi-zoom-out
    case zoom_out = "zoom-out"
}
