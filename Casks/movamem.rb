cask "movamem" do
  version "1.2.2"
  sha256 "7e5b05192a9f0eaf6dde23064de497e12fda71a3d1bc43d7679a434deaa040b7"

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
    an Apple Developer ID. macOS will refuse to open it and report that it is
    "damaged". It is not damaged — that is just the message macOS uses for a
    quarantined app with no notarization ticket.

    Clear the quarantine attribute:
      xattr -dr com.apple.quarantine /Applications/movaMem.app

    Or approve it once in System Settings > Privacy & Security, using the
    "Open Anyway" button that appears after the first blocked launch.

    If you enable "Launch at Login", re-check it after an upgrade: the ad-hoc
    signature changes on every build, which can drop the login registration.
  EOS
end
