//
//  ContentView.swift
//  Project 9
//
//  Created by Gabriel Marmen on 2022-08-22.
//

import SwiftUI

struct Arrow: Shape {
    
    var orientation: Double
    
    var animatableData: Double {
        get { orientation }
        set { orientation = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY/4))
        
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/4))
        path.move(to: CGPoint(x: rect.maxX/2 , y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))

        return path
    }
}

struct ContentView: View {
    
    @State private var arrowThickness = 10.0
    @State private var orientation = 0.0
    
    var body: some View {
        VStack{
            Arrow(orientation: orientation)
                .stroke(.gray, style: StrokeStyle(lineWidth: arrowThickness, lineCap: .round, lineJoin: .round))
                .padding(100)
                .onTapGesture {
                    withAnimation {
                        arrowThickness += 3
                    }
                }
                .rotationEffect(Angle(degrees: orientation))
            Slider(value: $arrowThickness, in: 3...30)
                .padding(30)
            
            Button("Random Thickness") {
                withAnimation(.interactiveSpring()){
                    arrowThickness = Double.random(in: 4..<30)
                }
                
            }
            .padding()
            Button("Random Orientation") {
                withAnimation(){
                    orientation = Double.random(in: 0..<360)
                }
                
            }
            .padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
