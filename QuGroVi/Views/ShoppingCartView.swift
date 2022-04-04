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

struct ShoppingCartView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var items: [Item]
    
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
                
                ForEach(items, id: \.barCode) { item in
                    HStack {
                        Text(item.barCode)
                        
                        Spacer()
                        
                        Text("Count: \(item.itemCount)")
                            
                    }
                    .padding(.vertical, 4.5)
                    
                    RectangleDivider(height: 2, backgroundColor: Color(white: 0.9))
                    
                }
//                .onDelete(perform: deleteItem)
            }
            .padding()
            
            Button("Pay") { }
        }
    }
    
//    func deleteBook(at offsets: IndexSet) {
//        for offset in offsets {
//            let book = books[offset]
//            moc.delete(book)
//        }
//
////        try? moc.save()
//    }
    
//    mutating func deleteItem(at offsets: IndexSet) {
//        items.remove(atOffsets: offsets)
//    }
    
}
