//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriel Marmen on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var name = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0.20
    @FocusState private var amountIsFocused: Bool

    private let tipPercentages = [0.05,0.10,0.15,0.20,0]
    private var SplitAmount: Double{
        (checkAmount * tipPercentage + checkAmount) / Double(numberOfPeople)
    }
    private var totalCheckAmount: Double{
        checkAmount * tipPercentage + checkAmount
    }
    

    
    var body: some View {

        NavigationView
        {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<99, id: \.self){
                            Text("\($0) people")
                        }
                    }
                    .onChange(of: numberOfPeople, perform: { (value) in
                                                amountIsFocused = false
                                            })
                    
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    //Picker("Tip Percentage", selection: $tipPercentage) {
                    //    ForEach(1..<100){
                    //        Text(Double($0)/100, format: .percent).tag(Double($0)/100)
                    //    }
                    //}
                    .onChange(of: tipPercentage, perform: { (value) in
                                                amountIsFocused = false
                                            })
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                
                
                Section{
                    Text(SplitAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                Section{
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Check Amount")
                }

            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
