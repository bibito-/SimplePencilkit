//
//  ContentView.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/28.
//

import SwiftUI
import CoreData
import PencilKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSeet = false
    @State var pkcanvasView: PKCanvasView = PKCanvasView()
    @FetchRequest(entity: Drawing.entity(), sortDescriptors: []) var drawings: FetchedResults<Drawing>
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(drawings) {drawing in
                        NavigationLink(
                            destination: DrawingView(id: drawing.id, data: drawing.canvasData, title: drawing.title),
                            label: {Text(drawing.title ?? "Untitled") })
                    }
                    .onDelete(perform: deleteItem(at:))
                    Button(action: {
                        self.showSeet.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Canvas")
                        }
                    })
                }
                .navigationTitle("Drawing")
                .toolbar {
                    EditButton()
                }
                
                
            }
            .sheet(isPresented: $showSeet, content: {
                AddNewCanvasView().environment(\.managedObjectContext, viewContext)
            })
            VStack {
                Image(systemName: "scribble.variable")
                Text("No Canvas has been selected")
                    .font(.title)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle()) // VStuck 二つ作ったら勝手にカラム分けしてくるのか？
    }
    
    func deleteItem(at offset: IndexSet) {
        for index in offset {
            let itemToDelete = drawings[index]
            viewContext.delete(itemToDelete)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}


#Preview {
    ContentView()
}
