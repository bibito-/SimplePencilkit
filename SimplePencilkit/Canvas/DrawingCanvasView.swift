//
//  DrawingCanvasView.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/29.
//

import SwiftUI
import CoreData
import PencilKit

// 一枚のCanvas View
struct DrawingCanvasView: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewContoller, context: Context) {
        uiViewController.drawingData = data
    }
    
    typealias UIViewControllerType = DrawingCanvasViewContoller
    
    var data:Data
    var id: UUID
    
    // view appeared?
    func makeUIViewController(context: Context) -> DrawingCanvasViewContoller {
        let viewController = DrawingCanvasViewContoller()
        viewController.drawingData = data
        // 呼ばれるタイミングはcanvasViewDrawingDidChange()
        // 描画、　一旦描画が終えた = 画面からpenを離したタイミングで
        viewController.drawingChanged = { data in
            let request: NSFetchRequest<Drawing> = Drawing.fetchRequest()
            let predicate = NSPredicate(format: "id = %@", id as CVarArg)
            request.predicate = predicate
            do {
                let result = try viewContext.fetch(request)
                let obj = result.first
                obj?.setValue(data, forKey: "canvasData")
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }
        return viewController
    }
}

