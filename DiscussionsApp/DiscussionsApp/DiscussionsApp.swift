import SwiftUI

@main
struct DiscussionsApp: App {

    init() {
        // Cache the environment variable in app storage (user defaults).
        if let networkSettings = ProcessInfo.processInfo.environment["NETWORK_SETTINGS"] {
            UserDefaults.standard.set(networkSettings, forKey: "networkSettings")
        }
    }

    @StateObject var dataStore = DataStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(dataStore)
        }
    }
}
