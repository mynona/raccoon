// Preview app only. Same code as ThemeSwitcher.detectThemeScript.
// Loaded as a blocking script in <head>, so data-theme is set before first paint.

(() => {
    let explicitlyPreferredTheme = null;
    try {
        if (window.localStorage) {
            let stored = localStorage.getItem('theme');
            // 'raumnebenan' was the former name of the 'emerald-mine' theme
            if (stored === 'raumnebenan') {
                stored = 'emerald-mine';
                localStorage.setItem('theme', stored);
            }
            if (stored) {
                document.documentElement.setAttribute('data-theme', stored);
                explicitlyPreferredTheme = stored;
            }
        }
    } catch (e) {}

    if (explicitlyPreferredTheme === null) {
        document.documentElement.setAttribute('data-theme', 'emerald-mine');
        try {
            if (window.localStorage) {
                localStorage.setItem('theme', 'emerald-mine');
            }
        } catch (e) {}
    }
})();
