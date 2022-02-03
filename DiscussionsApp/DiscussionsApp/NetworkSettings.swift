import Foundation

struct NetworkSettings {

    enum Environments {
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
        let defaultEnvironment = Bundle.main.object(forInfoDictionaryKey: "DEFAULT_NETWORK_SETTINGS") as? String
        let storedEnvironment = UserDefaults.standard.value(forKey: "networkSettings") as? String
        let resolvedEnvironment = storedEnvironment ?? defaultEnvironment

        switch resolvedEnvironment {
        case "testing":
            self = Environments.testing
        case "local":
            self = Environments.local
        default:
            self = Environments.production
        }
    }
}
