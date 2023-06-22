//
//  ContentView.swift
//  xrOS-loaded
//
//  Created by Rayan Khan on 6/21/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Combine

class RepoViewModel: ObservableObject {
    @Published var repos: [Repo] = [
        Repo(id: 0, name: "Test Repo", url: URL(string: "URL")!),
        Repo(id: 1, name: "00p1um Repo", url: URL(string: "http://00p1um.com")!)
    ]
    
    @Published var selectedRepo: Repo? = nil
    @Published var apps: [Apps] = []
    var cancellables = Set<AnyCancellable>()
    
    func fetchApps() {
        guard let url = selectedRepo?.url else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ESign.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { eSign in
                self.apps = eSign.apps
            })
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject var viewModel = RepoViewModel()
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.repos) { repo in
                Text(repo.name)
                    .onTapGesture {
                        viewModel.selectedRepo = repo
                        viewModel.fetchApps()
                    }
            }
            .navigationTitle("Repositories")
        } detail: {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)

                List(viewModel.apps) { app in
                    Text(app.name)
                }
            }
            .navigationTitle(viewModel.selectedRepo?.name ?? "Select a Repo")
            .padding()
        }
    }
}



#Preview {
    ContentView()
}
