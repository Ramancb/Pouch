//
//  GradientView.swift
//  Pouch
//
//  Created by Raman choudhary on 05/04/23.
//

import UIKit

@IBDesignable
final class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = .clear { didSet { updateView() } }
    @IBInspectable var secondColor: UIColor = .clear { didSet { updateView() } }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { updateView() } }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1) { didSet { updateView() } }

    override class var layerClass: AnyClass { get { CAGradientLayer.self } }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
        layer.frame = bounds
    }

    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
//        layer.startPoint = startPoint
//        layer.endPoint = endPoint
        layer.locations = [0,1]
    }
}



@IBDesignable
final class DottedLineView: UIView {

    @IBInspectable var color: UIColor = .clear { didSet { updateView() } }
    @IBInspectable var lineWidth: CGFloat = 1.0 { didSet { updateView() } }

    override class var layerClass: AnyClass { get { CAShapeLayer.self } }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
        layer.frame = bounds
    }

    private func updateView() {
        let layer = self.layer as! CAShapeLayer
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        layer.lineDashPattern = [5,5]
        let path = CGMutablePath()
        let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        path.addLines(between: [p0,p1])
        layer.path = path
    }
}
