# melnychenkoca/homebrew-movamem

Homebrew tap for [movaMem](https://github.com/melnychenkoca/movaMem) — per-application
keyboard layout memory for macOS.

## Install

```bash
brew tap melnychenkoca/movamem
brew trust --cask melnychenkoca/movamem/movamem
brew install --cask movamem
xattr -dr com.apple.quarantine /Applications/movaMem.app
open /Applications/movaMem.app
```

### Why the extra steps

movaMem is built without an Apple Developer ID, so the release is ad-hoc signed
rather than notarized. Two separate gates stand in the way, and each step clears
one of them.

**`brew trust`** — Homebrew 5 will not load casks from third-party taps until you
trust them explicitly. Without it the install stops before downloading anything.
This is Homebrew's own gate, and has nothing to do with macOS.

**`xattr -dr com.apple.quarantine`** — Homebrew marks cask downloads with the
quarantine attribute, and macOS refuses to launch a quarantined app that has no
notarization ticket, reporting it as **"damaged and can't be opened"**. The app is
not damaged; that is simply the message macOS uses.

> This is what `brew install --cask --no-quarantine` used to do. That flag was
> removed in Homebrew 5 and now fails with `invalid option: --no-quarantine`.

If you prefer to leave the quarantine attribute in place, skip that step and
approve the app once instead:

1. Try to open movaMem and let macOS block it
2. Open System Settings > Privacy & Security
3. Scroll down and click **Open Anyway**

On macOS 15 (Sequoia) and later this is the only manual route — Apple removed the
old Control-click > Open bypass.

## Upgrade

```bash
brew upgrade --cask movamem
```

If you use **Launch at Login**, re-check it in the menu after upgrading. The
ad-hoc signature changes on every build, and macOS ties the login registration to
the app's signature, so an upgrade can drop it.

## Uninstall

```bash
brew uninstall --cask movamem
```

This leaves your remembered layouts in place. To remove them too:

```bash
brew uninstall --zap --cask movamem
```

## Building from source instead

The tap ships a prebuilt universal binary. To compile it yourself, see the
[main repository](https://github.com/melnychenkoca/movaMem) — it needs only the
Command Line Tools, not full Xcode.

## Maintenance

`Casks/movamem.rb` is updated automatically. Tagging a release in the
[main repository](https://github.com/melnychenkoca/movaMem) builds the universal
app, publishes it, and pushes the new `version` and `sha256` here. Hand edits to
those two stanzas will be overwritten by the next release.
