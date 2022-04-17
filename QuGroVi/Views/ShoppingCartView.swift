//
//  ShoppingCartView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/3/22.
//

import SwiftUI

struct RectangleDivider: View {
    let height: CGFloat
    let backgroundColor: Color
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(backgroundColor)
            .padding(.top)
    }
}

struct ProductsInShoppingCartView: View {
    @State var product: Product
    @State var deleteItem: (_ product: Product) -> Void
    @State private var isDeleted = false
    
    var body: some View {
        HStack {
            if !isDeleted || product.itemCount > 0 {
                Text(product.barCode ?? "Deleted")
                
                Spacer()
                
                Button {
                    withAnimation {
                        deleteItem(product)
                        isDeleted = true
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.subheadline)
                }
                
                Stepper("Count: \(product.itemCount)", value: $product.itemCount, in: 0...500)
            } else {
                Text("Deleted")
                Spacer()
            }
        }
        .padding(.vertical, 4.5)
    }
}

struct ShoppingCartView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var isDoneShopping = false
    @State var products: FetchedResults<Product>
    
    @State private var barcodeViewChoice: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Shopping Cart")
                        .font(.largeTitle)
                        .padding(.vertical)
                    
                    Spacer()
                    
                    Button("Close") {
                        dismiss()
                    }
                    .font(.subheadline)
                }
                
                RectangleDivider(height: 2, backgroundColor: Color(white: 0.9))
                
                ForEach(products, id: \.barCode) { product in
                    ProductsInShoppingCartView(product: product, deleteItem: deleteItem)
                    
                    RectangleDivider(height: 2, backgroundColor: Color(white: 0.9411))
                }
            }
            .padding()
            
            HStack {
                Button("Finish Shopping(QR Code)") {
                    isDoneShopping = true
                    barcodeViewChoice = false
                }
                    .padding()
                    .font(.caption)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                
                Button("Finish Shopping(Barcode)") {
                    isDoneShopping = true
                    barcodeViewChoice = true
                }
                    .padding()
                    .font(.caption)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .sheet(isPresented: $isDoneShopping) {
            if barcodeViewChoice {
                BarcodeView(products: products)
            } else {
                QRCodeView(products: products)
            }
        }
    }
    
    func deleteItem(product: Product) {
        self.moc.delete(product)
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
}
