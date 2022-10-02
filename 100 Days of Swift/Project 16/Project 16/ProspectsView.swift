//
//  ProspectsView.swift
//  Project 16
//
//  Created by Gabriel Marmen on 2022-09-27.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSorting = false
    @State private var sorting = SortingType.name
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortingType {
        case name, email
    }
    
    let filter: FilterType
    
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .foregroundColor(Color.green)
                            }
                            else {
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Sort") {
                        isShowingSorting = true
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            
            
        }
        .confirmationDialog("Sort by", isPresented: $isShowingSorting) {
            Button("Name"){
                sorting = .name
            }
            Button("Email"){
                sorting = .email
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return sort(prospects.people)
        case .contacted:
            return sort(prospects.people.filter { $0.isContacted })
        case .uncontacted:
            return sort(prospects.people.filter { !$0.isContacted })
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
       
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            let person2 = Prospect()
            person2.name = "Gabriel Marmen"
            person2.emailAddress = "zabton@outlook.com"
            prospects.add(person2)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func sort(_ people: [Prospect]) -> [Prospect] {
        
        switch sorting{
        case .name:
            return people.sorted(by: {$0.name < $1.name})
        case .email:
            return people.sorted(by: {$0.emailAddress < $1.emailAddress})
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
