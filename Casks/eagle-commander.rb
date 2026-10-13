# The Homebrew cask (D111). The source of truth is this file; release.sh fills
# in the version and the checksum and copies it into ulebule/homebrew-tap.
cask "eagle-commander" do
  version "1.1.0"
  sha256 "b686360053e54e306b45ee322fad44b7fc575d86a6069bdd7f749ba270ba65a3"

  url "https://github.com/ulebule/eagle-commander-releases/releases/download/v#{version}/EagleCommander.dmg"
  name "Eagle Commander"
  desc "Two-panel file manager in the tradition of Total Commander"
  homepage "https://eaglecommander.eaglesoft.si/"

  # Release candidates share the feed on the beta channel; brew follows only
  # the finished versions, which have no channel.
  livecheck do
    url "https://eaglecommander.eaglesoft.si/appcast-1.xml"
    strategy :sparkle do |items|
      items.find { |item| item.channel.nil? }&.short_version
    end
  end

  # Sparkle updates the app; brew must not fight it (D109).
  auto_updates true
  depends_on macos: :sonoma

  app "Eagle Commander.app"

  zap trash: [
    "~/Library/Application Support/EagleCommander",
    "~/Library/Caches/si.eaglesoft.eaglecommander",
    "~/Library/HTTPStorages/si.eaglesoft.eaglecommander",
    "~/Library/Preferences/si.eaglesoft.eaglecommander.plist",
    "~/Library/Saved Application State/si.eaglesoft.eaglecommander.savedState",
  ]
end
