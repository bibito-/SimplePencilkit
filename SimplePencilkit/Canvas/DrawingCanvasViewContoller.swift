//
//  DrawingCanvasViewContoller.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/29.
//

import SwiftUI
import PencilKit

class DrawingCanvasViewContoller: UIViewController {
    lazy var canvas: PKCanvasView = {
        let view = PKCanvasView()
        view.drawingPolicy = .anyInput
        view.minimumZoomScale = 1
        view.maximumZoomScale = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()
    
    var drawingData = Data()
    // 描画内容が変わった際のデリゲート処理 extensionで呼び出されてる
    var drawingChanged: (Data) -> Void = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        // 描画範囲の四隅？
        NSLayoutConstraint.activate([canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     canvas.topAnchor.constraint(equalTo: view.topAnchor),
                                     canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        if let drawing = try? PKDrawing(data: drawingData) {
            canvas.drawing = drawing
        }
    }
}

extension DrawingCanvasViewContoller: PKToolPickerObserver, PKCanvasViewDelegate {
    /// Called after the drawing on the canvas did change.
    ///
    /// This may be called some time after the `canvasViewDidEndUsingTool:` delegate method.
    /// For example, when using the Apple Pencil, pressure data is delayed from touch data, this
    /// means that the user can stop drawing (`canvasViewDidEndUsingTool:` is called), but the
    /// canvas view is still waiting for final pressure values; only when the final pressure values
    /// are received is the drawing updated and this delegate method called.
    ///
    /// It is also possible that this method is not called, if the drawing interaction is cancelled.
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        debugPrint("canvasViewDrawingDidChange() called")
        drawingChanged(canvasView.drawing.dataRepresentation())
    }
}
