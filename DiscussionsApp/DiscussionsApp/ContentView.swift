import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State var discussion: Discussion?

    var discussionURL: URL {
        dataStore.networkSettings.discussionsURL
    }

    var body: some View {
        VStack {
            Spacer()
            Text("Total Comments").font(.headline).padding()

            if let comments = discussion?.totalComments {
                Text("\(comments)").font(.title)
            } else {
                ProgressView()
            }

            Spacer()
            Text("`\(discussionURL)`").font(.caption).padding(.bottom)
        }
        .task {
            guard let (data, _) = try? await URLSession.shared.data(from: discussionURL) else {
                discussion = .init(totalComments: 0)
                return
            }
            discussion = (try? JSONDecoder().decode(Discussion.self, from: data)) ?? .init(totalComments: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
