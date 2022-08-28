//
//  ContentView.swift
//  Project 10
//
//  Created by Gabriel Marmen on 2022-08-26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Orders()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.order.specialRequestEnabled.animation())

                    if order.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.order.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
