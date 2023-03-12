import SwiftUI
import Screenshotting

struct FormExample: View {
  enum NotifyMeAboutType { case directMessages, mentions, anything }
  enum ProfileImageSize { case large, medium, small }
  @State var notifyMeAbout = NotifyMeAboutType.directMessages
  @State var playNotificationSounds = true
  @State var sendReadReceipts = false
  @State var profileImageSize = ProfileImageSize.medium

  var body: some View {
#if os(macOS)
    HStack {
      Spacer()
      Form {
        Picker("Notify Me About:", selection: $notifyMeAbout) {
          Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
          Text("Mentions").tag(NotifyMeAboutType.mentions)
          Text("Anything").tag(NotifyMeAboutType.anything)
        }
        Toggle("Play notification sounds", isOn: $playNotificationSounds)
        Toggle("Send read receipts", isOn: $sendReadReceipts)

        Picker("Profile Image Size:", selection: $profileImageSize) {
          Text("Large").tag(ProfileImageSize.large)
          Text("Medium").tag(ProfileImageSize.medium)
          Text("Small").tag(ProfileImageSize.small)
        }
        .pickerStyle(.inline)

        Button("Clear Image Cache") {}
      }
      Spacer()
    }
#else
    NavigationView {
      Form {
        Section(header: Text("Notifications")) {
          Picker("Notify Me About", selection: $notifyMeAbout) {
            Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
            Text("Mentions").tag(NotifyMeAboutType.mentions)
            Text("Anything").tag(NotifyMeAboutType.anything)
          }
          Toggle("Play notification sounds", isOn: $playNotificationSounds)
          Toggle("Send read receipts", isOn: $sendReadReceipts)
        }
        Section(header: Text("User Profiles")) {
          Picker("Profile Image Size", selection: $profileImageSize) {
            Text("Large").tag(ProfileImageSize.large)
            Text("Medium").tag(ProfileImageSize.medium)
            Text("Small").tag(ProfileImageSize.small)
          }
          Button("Clear Image Cache") {}
        }
      }
    }
#endif
  }
}

class FormExample_Previews: PreviewProvider {
  static var previews: some View {
    //CaptureScreenshots(fromXcode: true) {
      FormExample()
        .padding()
        .background()
        .previewLayout(.sizeThatFits)
        .screenshot("Form5")
      //.screenshot("OmgWut")
    //}
  }
}
