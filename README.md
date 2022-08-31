# chromium-patches

My custom [Chromium](https://source.chromium.org/chromium/chromium/src) patches, including:

* Extension-less startpage that maintains its address bar focus.
* Dynamic GTK dark mode for Linux distros with a Night/Day theme

PKGBUILD is of [ungoogled-chromium](https://aur.archlinux.org/packages/ungoogled-chromium/) although [these patches](https://github.com/qcasey/chromium-patches/tree/main/patches) can be applied to any Chromium build.

# Custom Startpage

**Problem:** Google Chrome ([Chromium](https://source.chromium.org/chromium/chromium/src) pictured here) requires you to install an extension to change your new tab page. This would be fine, except that new tab loses focus of the searchbar! It also loads far slower than it should.

**Solution:** Build Chromium with all instances of chrome://newtab replaced with your custom startpage URL. [This patch](https://github.com/qcasey/chromium-patches/blob/main/patches/custom-startpage.patch) does the replacement, and also adds some checks to ensure the URL is hidden and the searchbar keeps its focus. :smiley:

![startpage.gif](https://github.com/qcasey/chromium-patches/blob/main/startpage.gif?raw=true)

# GTK Dark Theme

**Problem:** Chrome does not respect GTK themes when it sets `prefers-color-scheme`. It's a somewhat long-lived bug in Chromium on Linux. Here is the bugreport and Electron issue:

* https://bugs.chromium.org/p/chromium/issues/detail?id=998903
* https://github.com/electron/electron/issues/21427

**Solution-(ish):** Use [this patch](https://github.com/qcasey/chromium-patches/blob/main/patches/gtk-dark-mode-switch-fix.patch) to add a very naive forced update to the Web and NativeUI themes. This most likely should be done with listeners like Chromium already uses for Windows and MacOS, but GTK seems deliberately left out.

## Gnome 42 Note

This patch correctly handles dark/light theme switching on GTK's **theme variants**. As of Gnome 42 this is now a legacy feature.

This patch does not work Gnome 42's "Dark Style Preference". **You must switch themes**, not style preference. Firefox handles this new feature correctly, would appreciate help implementing it here.

At the time of writing, the "legacy" feature is still a valid way to switch between light and dark desktop themes. I switch Adawita/Adawita Dark [with this extension](https://nightthemeswitcher.romainvigier.fr/) for example.

## Chromium / Firefox Comparisons

As of August 2022 this still works.

#### Before (web content theme not changed)
![before](https://github.com/qcasey/chromium-patches/raw/main/before.gif)

#### After (theme changes, thank you Mr. Duck)
![after](https://github.com/qcasey/chromium-patches/raw/main/after.gif)
