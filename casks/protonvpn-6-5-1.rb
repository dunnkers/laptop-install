cask "protonvpn-6-5-1" do
  version "6.5.1"
  sha256 "d50a49f14c50b0ef8ad68a89fc9685d5699ba2d4f92cb4c34317291b425435f8"

  url "https://vpn.protondownload.com/download/macos/#{version}/ProtonVPN_mac_v#{version}.dmg"
  name "ProtonVPN"
  desc "VPN client focusing on security"
  homepage "https://protonvpn.com/"

  # The Sparkle feed can contain items on the "beta" channel, so we restrict
  # matching to the default channel.

  auto_updates false
  depends_on macos: :sonoma

  app "ProtonVPN.app"

  uninstall launchctl: "ch.protonvpn.ProtonVPNStarter",
            quit:      "ch.protonvpn.mac"

  zap trash: [
    "~/Library/Application Scripts/*.group.ch.protonvpn.mac",
    "~/Library/Application Scripts/ch.protonvpn.*",
    "~/Library/Application Support/CrashReporter/ProtonVPN*",
    "~/Library/Application Support/ProtonVPN",
    "~/Library/Caches/ch.protonvpn.mac",
    "~/Library/Caches/com.apple.nsurlsessiond/Downloads/ch.protonvpn.mac",
    "~/Library/Caches/SentryCrash/ProtonVPN",
    "~/Library/Containers/ch.protonvpn.*",
    "~/Library/Cookies/ch.protonvpn.mac.binarycookies",
    "~/Library/Group Containers/*.group.ch.protonvpn.mac",
    "~/Library/Logs/ProtonVPN.log",
    "~/Library/Preferences/ch.protonvpn.mac.plist",
    "~/Library/WebKit/ch.protonvpn.mac",
  ]
end
