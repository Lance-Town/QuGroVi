//
//  ContentView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 3/24/22.
//

import CodeScanner
import SwiftUI

struct ShoppingCartButtonView: View {
    @Binding var isPressed: Bool
    var circleColor: Color = .blue
    var cartColor: Color = .white
    var width: CGFloat = 66
    var height: CGFloat = 66
    var alignment: Alignment = .bottomTrailing
    var systemImage: String = "cart"
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: width, height: height, alignment: alignment)
            
            Button {
                isPressed = true
            } label: {
                Image(systemName: systemImage)
            }
            .font(.largeTitle)
            .foregroundColor(cartColor)
        }
        .padding()
        .padding(.trailing, 5)
    }
}

struct ContentView: View {
    // Get a MOC to store view context
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var products: FetchedResults<Product>
    
    @State private var isPressed = false
    
    @State private var showScanSuccess = false
    @State private var details = ""
    
    var body: some View {
        ZStack {
            CodeScannerView(codeTypes: [.ean13], scanMode: .continuous, scanInterval: 6.5, showViewfinder: true, simulatedData: "036000291452", shouldVibrateOnSuccess: true, isTorchOn: false, completion: handleScan)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    ShoppingCartButtonView(isPressed: $isPressed)
                }
            }
        }
        .sheet(isPresented: $isPressed) {
            ShoppingCartView(products: products)
            
            // DEMO ONLY
//            ProductDemoVideoView(products: products)
        }
        .alert("Success", isPresented: $showScanSuccess) {
            Button("Ok") { showScanSuccess = false }
        } message: {
            Text("\(details)")
            
            // DEMO ONLY
//            Text("Raw Kombucha Added!")
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        showScanSuccess = true
        
        switch result {
        case .success(let result):
            details = result.string
            guard details.count > 0 else { return }
            
            // If EAN-13, turn it to a UPC-A
            if details.count == 13 {
                details.removeFirst()
            }
            
            // check for duplicates
            if !products.isEmpty {
                for i in 0...(products.count - 1){
                    if products[i].barCode == details {
                        products[i].itemCount += 1
                        return
                    }
                }
            }
            
//          Initialize product
            let product = Product(context: moc)
            product.barCode = details
            product.itemCount = 1
            
////            DEMO ONLY
//            let product = Product(context: moc)
//            product.barCode = "Raw Kombucha"
//            product.itemCount = 1
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
