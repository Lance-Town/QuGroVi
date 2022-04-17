//
//  ProductDemoVideoView.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/6/22.
//

import SwiftUI

struct ProductsInDemoVideoShoppingCartView: View {
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

struct ProductDemoVideoView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var isDoneShopping = false
    @State var products: FetchedResults<Product>
    
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
                    ProductsInDemoVideoShoppingCartView(product: product, deleteItem: deleteItem)
                    
                    RectangleDivider(height: 2, backgroundColor: Color(white: 0.9))
                }
            }
            .padding()
            
            
            
            Button("Finish Shopping") { isDoneShopping = true }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .sheet(isPresented: $isDoneShopping) {
            QRCodeView(products: products)
        }
        .onAppear {
            loadDemo()
        }
    }
    
    func deleteItem(product: Product) {
        self.moc.delete(product)
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    func loadDemo() {
        let juniorMint = Product(context: moc)
        juniorMint.barCode = "Peppermint Gum"
        juniorMint.itemCount = 1
        
        let oliveOil = Product(context: moc)
        oliveOil.barCode = "Olive Oil"
        oliveOil.itemCount = 1
        
        let crackers = Product(context: moc)
        crackers.barCode = "Graham Crackers"
        crackers.itemCount = 2
        
        let oatMeal = Product(context: moc)
        oatMeal.barCode = "Oatmeal"
        oatMeal.itemCount = 1
        
        let popcorn = Product(context: moc)
        popcorn.barCode = "Popcorn"
        popcorn.itemCount = 1
        
        let vanilla = Product(context: moc)
        vanilla.barCode = "Vanilla Extract"
        vanilla.itemCount = 1
    }
}
