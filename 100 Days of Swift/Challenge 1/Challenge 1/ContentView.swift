//
//  ContentView.swift
//  Challenge 1
//
//  Created by Gabriel Marmen on 2022-08-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input: String = ""
    @State private var selectedInputMeasurement: UnitLength = UnitLength.kilometers
    @State private var selectedOutputMeasurement: UnitLength = UnitLength.miles
    
    private var inputDouble: Double{
        Double(input) ?? 0.0
    }
    private var measurementInput: Measurement<UnitLength> {
        return Measurement(value: inputDouble, unit: selectedInputMeasurement)
    }
    private var measurementOutputString: String {
        return String((round(measurementInput.converted(to: selectedOutputMeasurement).value * 100)/100).formatted()) + " " + selectedOutputMeasurement.symbol
    }
    
    
    
    private let measurementUnits: [UnitLength] = [UnitLength.kilometers, UnitLength.miles, UnitLength.feet, UnitLength.centimeters]

    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Value", text: $input)
                        .keyboardType(.decimalPad)
                    Picker("Input Measurement", selection: $selectedInputMeasurement) {
                        ForEach(measurementUnits, id: \.self){ value in
                            Text(value.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                } header: {
                    Text("Convert")
                }
                
                Section{
                    Picker("Input Measurement", selection: $selectedOutputMeasurement) {
                        ForEach(measurementUnits, id: \.self){ value in
                            Text(value.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(measurementOutputString)
                    
                } header: {
                    Text("To")
                }
            }
            .navigationTitle("Unit Converter")
        }
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
