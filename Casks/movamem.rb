cask "movamem" do
  version "1.0.0"
  # Replaced on each release with the checksum printed by the release workflow.
  # Until the first tag is pushed there is no asset to hash, so this is a
  # placeholder and `brew install` will fail on mismatch by design.
  sha256 "REPLACE_WITH_RELEASE_SHA256"

  url "https://github.com/melnychenkoca/movaMem/releases/download/v#{version}/movaMem.zip"
  name "movaMem"
  desc "Per-application keyboard layout memory"
  homepage "https://github.com/melnychenkoca/movaMem"

  # Cask reads a bare symbol as "this version or newer", so this is macOS 14+.
  depends_on macos: :sonoma

  app "movaMem.app"

  # movaMem is a menu bar app with no window, so an upgrade or uninstall that
  # leaves the old copy running would silently keep managing layouts.
  uninstall quit: "com.movamem.app"

  # Only run by `brew uninstall --zap`, never by a plain uninstall, so a user's
  # remembered layouts survive an ordinary reinstall.
  zap trash: "~/Library/Application Support/movaMem"

  caveats <<~EOS
    movaMem is ad-hoc signed rather than notarized, because it is built without
    an Apple Developer ID. If you installed without `--no-quarantine`, macOS
    will refuse to open it and report that it is "damaged". It is not damaged.

    Either reinstall with:
      brew install --cask --no-quarantine movamem

    Or approve it once in System Settings > Privacy & Security, using the
    "Open Anyway" button that appears after the first blocked launch.

    If you enable "Launch at Login", re-check it after an upgrade: the ad-hoc
    signature changes on every build, which can drop the login registration.
  EOS
end
