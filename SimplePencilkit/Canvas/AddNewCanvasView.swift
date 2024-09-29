//
//  NewCanvasView.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/28.
//

import SwiftUI

struct AddNewCanvasView: View {
    // content view がCoreData(DB)にアクセスする為のおまじない
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var canvasTitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Canvas Title", text:$canvasTitle)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle(Text("Add New Canvas"))
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {Image(systemName: "xmark")}),
                trailing: Button(action: {
                    if !canvasTitle.isEmpty {
                        let drawing = Drawing(context: viewContext)
                        drawing.title = canvasTitle
                        drawing.id = UUID()
                        // これだけで保存されるのか？
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {Text("Save")})
            )
        }
    }
}

#Preview {
    AddNewCanvasView()
}
