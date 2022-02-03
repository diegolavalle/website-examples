import Foundation

struct NetworkSettings {

    enum Presets {
        static let production = NetworkSettings(
            discussionsURL: URL(string: "https://data.diegolavalle.com/discussion/6.json")!
        )

        static let testing = NetworkSettings(
            discussionsURL: URL(string: "http://localhost:8080/discussion/6.json")!
        )

        static let local = NetworkSettings(
            discussionsURL: Bundle.main.url(forResource: "discussion", withExtension: "json5")!
        )
    }

    let discussionsURL: URL
}

extension NetworkSettings {

    init() {
        let defaultPreset = Bundle.main.object(forInfoDictionaryKey: "DEFAULT_NETWORK_SETTINGS") as? String
        let storedPreset = UserDefaults.standard.value(forKey: "networkSettings") as? String
        let resolvedPreset = storedPreset ?? defaultPreset

        switch resolvedPreset {
        case "testing":
            self = Presets.testing
        case "local":
            self = Presets.local
        default:
            self = Presets.production
        }
    }
}
