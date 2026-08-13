# melnychenkoca/homebrew-movamem

Homebrew tap for [movaMem](https://github.com/melnychenkoca/movaMem) — per-application
keyboard layout memory for macOS.

## Install

```bash
brew tap melnychenkoca/movamem
brew install --cask --no-quarantine movamem
open /Applications/movaMem.app
```

### Why `--no-quarantine`

movaMem is built without an Apple Developer ID, so the release is ad-hoc signed
rather than notarized. Homebrew quarantines cask downloads by default, and macOS
refuses to launch a quarantined app that has no notarization ticket — reporting
it as **"damaged and can't be opened"**. The app is not damaged; that is simply
the message macOS uses.

`--no-quarantine` skips applying the quarantine attribute, so the app launches
normally.

If you prefer to leave quarantine in place, install without the flag and approve
the app once instead:

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
