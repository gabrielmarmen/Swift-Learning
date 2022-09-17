//
//  ContentView.swift
//  Shared
//
//  Created by Gabriel Marmen on 2022-08-13.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var businessItems: [ExpenseItem] {
        var tempArray = [ExpenseItem]()
        for expenseItem in expenses.items {
            if expenseItem.type == "Business"{
                tempArray.append(expenseItem)
            }
        }
        return tempArray
    }
    private var personalItems: [ExpenseItem] {
        var tempArray = [ExpenseItem]()
        for expenseItem in expenses.items {
            if expenseItem.type == "Personal"{
                tempArray.append(expenseItem)
            }
        }
        return tempArray
    }
    
    var body: some View {
        NavigationView{
            List{
                    Section{
                        if personalItems.count != 0{
                            ForEach(personalItems){ item in
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .foregroundColor(getAmountColor(for: item))
                                }
                            }
                            .onDelete(perform: removePersonalItems)
                        }
                        else{
                            Text("No personal expenses yet")
                                .foregroundColor(.secondary)
                        }
                    } header: {
                        Text("Personal expenses")
                    }
                
                
                    Section{
                        if businessItems.count != 0 {
                            ForEach(businessItems){ item in
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .foregroundColor(getAmountColor(for: item))
                                }
                                .accessibilityElement()
                                .accessibilityLabel(item.name)
                                .accessibilityValue(String(item.amount))
                            }
                            .onDelete(perform: removeBusinessItems)
                        }
                        else{
                            Text("No business expenses yet")
                                .foregroundColor(.secondary)
                        }
                    } header: {
                        Text("business expenses")
                    }
                
                
                
                
            }
            .navigationTitle("iExpenses")
            .toolbar{
                Button{
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet){
        let tempPersonalItems = personalItems[offsets.first ?? 0]
    
        expenses.items.removeAll(where: {$0.id == tempPersonalItems.id})
    }
    func removeBusinessItems(at offsets: IndexSet){
        let tempBusinessItems = businessItems[offsets.first ?? 0]
        expenses.items.removeAll(where: {$0.id == tempBusinessItems.id})
    }
    func getAmountColor(for item: ExpenseItem) -> Color{
        switch item.amount {
        case 0..<10:
            return .green
        case 10..<100:
            return .secondary
        default:
            return .red
        }

    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
