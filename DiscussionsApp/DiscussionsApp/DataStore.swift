import Foundation

@MainActor
class DataStore: ObservableObject {
    let networkSettings = NetworkSettings()
}
