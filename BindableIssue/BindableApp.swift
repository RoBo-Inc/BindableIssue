import SwiftUI

@main
struct BindableApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsView(
                store: .init(initialState: .init(something: .init(flag: true))) {
                    Settings()
                }
            )
        }
    }
}
