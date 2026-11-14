// Preview app only. Same code as DarkLightModeToggle.detectModeScript.
// Loaded as a blocking script in <head>, so the dark class is set before first paint.

let explicitelyPreferScheme = false
if (window.localStorage) {
    if (localStorage.getItem('colorMode') === 'dark') {
        document.documentElement.classList.add('dark')
        explicitelyPreferScheme = 'dark'
    } else if (localStorage.getItem('colorMode') === 'light') {
        document.documentElement.classList.remove('dark')
        explicitelyPreferScheme = 'light'
    }
}

if (localStorage.getItem("colorMode") === null) {
  if (explicitelyPreferScheme !== 'light' && window.matchMedia('(prefers-color-scheme:dark)').matches) {
      document.documentElement.classList.add('dark')
      localStorage.setItem('colorMode', 'dark')
  } else {
      localStorage.setItem('colorMode', 'light')
  }
}
