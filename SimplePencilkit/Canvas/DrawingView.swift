//
//  DrawingView.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/29.
//

import SwiftUI

struct DrawingView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var id: UUID?
    @State var data: Data?
    @State var title: String?
    
    var body: some View {
        VStack {
            DrawingCanvasView(data: data ?? Data(), id: id ?? UUID())
                .environment(\.managedObjectContext, viewContext)
                .navigationBarTitle(title ?? "Untitled", displayMode: .inline)
        }
    }
}
