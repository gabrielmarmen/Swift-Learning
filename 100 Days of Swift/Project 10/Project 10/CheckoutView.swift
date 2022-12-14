//
//  CheckoutView.swift
//  Project 10
//
//  Created by Gabriel Marmen on 2022-08-28.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Orders
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var alertTitle = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                

                Text("Your total is \(order.order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                    
                }
                .padding()
                    
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
    
        
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            alertTitle = "Everything good !"
            showingConfirmation = true
        } catch {
            
            alertTitle = "Oops..."
            confirmationMessage = """
            We were not able to place your order ...
            Please try again Later
            """
            showingConfirmation = true
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Orders())
    }
}
