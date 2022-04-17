//
//  QRCodeView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/4/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct QRCodeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var products: FetchedResults<Product>
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Cancel") { dismiss() }
                    .font(.subheadline)
                    .padding([.top, .trailing])
            }
            
            
            Spacer()
            Text("Done Shopping")
                .font(.largeTitle)
            Spacer()
            
            ZStack {
                // Display QR Code
                Image(uiImage: generateQRCode())
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            Spacer()
            
            Button("Empty Cart \(Image(systemName: "trash"))") {
                emptyCart()
                dismiss()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            Spacer()
        }
    }
    
    func generateQRCode() -> UIImage {
        let newArray = putIntoArray(from: products)
        
        // puts the array of all the data into a message all formatted to UTF8
        filter.message = Data(newArray.description.utf8)
        
        // check ofor errors
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    // Culprit for putting all the outputs in the QR Code as "["0093966000337", "0093966000337"]"
    func putIntoArray(from products: FetchedResults<Product>) -> [String] {
        var newArr = [String]()
        
        for product in products {
            if product.itemCount != 0 {
                for _ in 0...(product.itemCount - 1) {
                    newArr.append(product.barCode ?? "Error")
                }
            }
        }
        
        return newArr
    }
    
    func emptyCart() {
        for product in products {
            moc.delete(product)
        }
        
        // There is a moc.undo method, that will be useful for accidental deletions
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
}
