//
//  ContentView.swift
//  Project 13
//
//  Created by Gabriel Marmen on 2022-09-07.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 50.0
    
    @State private var showingImagePicker = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var showingFilterSheet = false
    
    
    
    
    //@State private var radiusActive = false
    //@State private var intensityActive = false
    var inputKeys: [String]{
        currentFilter.inputKeys
    }
    var radiusActive: Bool {
        if inputKeys.contains(kCIInputRadiusKey) {
            return true
        }
        else {
            return false
        }
        
    }
    var intensityActive: Bool {
        if inputKeys.contains(kCIInputIntensityKey) {
            return true
        }
        else {
            return false
        }
        
    }
    
    
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                        .disabled(!intensityActive)
                }
                .padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius, in: 5.0...25.0)
                        .onChange(of: filterRadius) { _ in
                                applyProcessing()
                            }
                        .disabled(!radiusActive)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    //Functions for the ContentView
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius , forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }
    
    func save() {
        
            guard let processedImage = processedImage else { return }

            let imageSaver = ImageSaver()

            imageSaver.successHandler = {
                print("Success!")
            }

            imageSaver.errorHandler = {
                print("Oops: \($0.localizedDescription)")
            }

            imageSaver.writePhotoToAlbum(image: processedImage)
        
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
