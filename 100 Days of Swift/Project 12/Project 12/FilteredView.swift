//
//  FilteredView.swift
//  Project 12
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    private var predicateString: String
    private var sortDescriptor: SortDescriptor<Singer>
    
    
    enum Predicate: String {
        case beginsWith
    }
    enum Sort: String {
        case FamilyName, FirstName
    }
    init(filter: String, predicate: Predicate, sortBy: Sort) {
        
        
        switch predicate {
        case .beginsWith:
            predicateString = "lastName BEGINSWITH %@"
        }
        
        switch sortBy {
        case .FamilyName:
            sortDescriptor = SortDescriptor(\.lastName)
        case .FirstName:
            sortDescriptor = SortDescriptor(\.lastName)
        }
        
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [sortDescriptor], predicate: NSPredicate(format: predicateString, filter))
    }
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
    }
    
    
    
}


