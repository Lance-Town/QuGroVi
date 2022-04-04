//
//  ContentView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 3/24/22.
//

import CodeScanner
import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @State private var items = [Item]()
    
    @State private var showScanSuccess = false
    @State private var details = ""
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .fill(.red)
//                .ignoresSafeArea()
            
//            CodeScannerView(codeTypes: [.qr], simulatedData: "Bottle Water/n 2.99", completion: handleScan)
//                .ignoresSafeArea()
            
            CodeScannerView(codeTypes: [.upce, .ean8, .gs1DataBar, .codabar, .code128, .code39, .code39Mod43, .ean13, .code93, .itf14], scanMode: .continuous, scanInterval: 10.0, showViewfinder: true, simulatedData: "006453657891", shouldVibrateOnSuccess: true, isTorchOn: false, completion: handleScan)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
//                            .fill(Color(red: 51/255, green: 153/255, blue: 1))
                            .fill(.blue)
                            .frame(width: 66, height: 66, alignment: .bottomTrailing)
                        
                        Button {
                            isPressed = true
                        } label: {
                            Image(systemName: "cart")
                        }
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.trailing, 5)
                }
            }
        }
        .sheet(isPresented: $isPressed) {
            ShoppingCartView(items: items)
        }
        .alert("Success", isPresented: $showScanSuccess) {
            Button("Ok") { }
        } message: {
            Text("\(details)")
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        showScanSuccess = true
        switch result {
        case .success(let result):
            details = result.string
            guard details.count > 0 else { return }
            
            if !items.isEmpty {
                for i in 0...(items.count - 1){
                    if items[i].barCode == details {
                        items[i].itemCount += 1
                        return
                    }
                }
            }
            
            let newItem = Item(barCode: details)
            items.append(newItem)
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
