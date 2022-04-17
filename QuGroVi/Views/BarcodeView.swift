//
//  BarcodeView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/9/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct BarcodeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var products: FetchedResults<Product>
    
    let context = CIContext()
    var filter = CIFilter.code128BarcodeGenerator()
    var changeFilter = true
    
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
            
            ScrollView(.horizontal, showsIndicators: true) {
                // Display QR Code
                HStack {
                    let newArr = putIntoArray(from: products)
                    
                    // Gives undefined results if there is more than one of the same item, i.e. product.itemCount = 2
                    ForEach(newArr, id: \.self) { product in
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(.clear)
                                    
                                UPCA(barCode: product.barCode ?? "00000000000")
                                    .stroke(.black)
                                    .scaleEffect(x: 1.5, y: 1, anchor: .leading)
                            }
                            .frame(width: 190, height: 128, alignment: .center)
                            .padding(.leading, 47.5)
                            
                            Text(product.barCode ?? "Unkown Barcode")
                        }
                        .padding(.vertical)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(white: 0.9411), lineWidth: 2)
                        )
                    }
                    .padding()
                }
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
    
//    func generateBarcode(from string: String) -> UIImage {
////        let newArray = putIntoArray(from: products)
//
//        // puts the array of all the data into a message all formatted to UTF8
//        filter.message = Data(string.utf8)
//
//        // check ofor errors
//        if let outputImage = filter.outputImage {
//            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgimg)
//            }
//        }
//        return UIImage(systemName: "xmark.circle") ?? UIImage()
//    }
    
    // Culprit for putting all the outputs in the QR Code as "["0093966000337", "0093966000337"]"
    func putIntoArray(from products: FetchedResults<Product>) -> [Product] {
        var newArr = [Product]()
        
        for product in products {
            if product.itemCount != 0 {
                for _ in 0...(product.itemCount - 1) {
                    newArr.append(product)
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
