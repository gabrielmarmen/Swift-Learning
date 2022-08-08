//
//  ContentView.swift
//  Project 4
//
//  Created by Gabriel Marmen on 2022-08-06.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        
        var components = DateComponents()
        
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
        
    }
    
    var recommendedBedTime: String {
        calculateBedtime()
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Spacer()
                        DatePicker("Please enter a time :", selection: $wakeUp, displayedComponents: .hourAndMinute )
                            .labelsHidden()
                    }
                } header: {
                    Text("When do you want to wake up?")
                        
                }
                
                Section{
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }header: {
                    Text("Desired amount of sleep ?")
                }
                
                Section{
                    Picker("Daily coffee intake", selection: $coffeeAmount){
                        ForEach(1..<21, id: \.self){ i in
                            if i == 1 {
                                Text("\(i) cup")
                            }
                            else{
                                Text("\(i) cups")
                            }
                            
                        }
                        
                    }
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1...20, step: 1)
                }header: {
                    Text("Daily coffee intake")
                }
                
                Section{
                    HStack{
                        Text("You should go to bed at:")
                            .font(.headline)
                        Text(recommendedBedTime)
                    }
                    
                }
                
                
            }
            .navigationTitle(Text("BetterSleep"))
            
            Text("Sheesh")
            
        }
        
        
    }
    
    func calculateBedtime() -> String{
        do {
            let MLconfigs = MLModelConfiguration()
            let model = try SleepCalculator(configuration: MLconfigs)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            
            let result = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let prediction = wakeUp - result.actualSleep
            
            return prediction.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Error"
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
