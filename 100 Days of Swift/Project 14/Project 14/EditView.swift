//
//  EditView.swift
//  Project 14
//
//  Created by Gabriel Marmen on 2022-09-12.
//

import SwiftUI

struct EditView: View {
    
    
    @StateObject var editViewModel: viewModel
    @Environment(\.dismiss) var dismiss
    
    
    var onSave: (Location) -> Void
    


    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }
                Section("Nearby…") {
                    switch editViewModel.loadingState {
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = editViewModel.location
                    newLocation.id = UUID()
                    newLocation.name = editViewModel.name
                    newLocation.description = editViewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
        .task {
            await fetchNearbyPlaces()
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        self.onSave = onSave
        _editViewModel = StateObject(wrappedValue: viewModel(location: location))
    }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(editViewModel.location.coordinate.latitude)%7C\(editViewModel.location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(Result.self, from: data)

            // success – convert the array values to our pages array
            editViewModel.pages = items.query.pages.values.sorted()
            editViewModel.loadingState = .loaded
        } catch {
            // if we're still here it means the request failed somehow
            editViewModel.loadingState = .failed
        }
    }
}


