//
//  EditView-ViewModel.swift
//  Project 14
//
//  Created by Gabriel Marmen on 2022-09-14.
//

import Foundation

extension EditView {
    @MainActor class viewModel: ObservableObject {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        

        @Published var name: String
        @Published var description: String
        
        @Published var location: Location
        
        init(location: Location) {
            
            self.location = location
            

            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
    }
}
