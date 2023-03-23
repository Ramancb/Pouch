//
//  SwipeableView.swift
//  Pouch
//
//  Created by Raman choudhary on 23/03/23.
//

import Foundation
import UIKit

protocol SwipeableViewDelegate{
    func dismissView()
}

class SwipeableView:UIView{
    
    private var transitionHeight: CGFloat = 150
    var delegate:SwipeableViewDelegate?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        self.transform = CGAffineTransform.identity
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    public func setInitialAnimation(delegate:SwipeableViewDelegate?){
        self.delegate = delegate
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    @objc func handleDismiss(sender : UIPanGestureRecognizer){
        let transfromY = sender.translation(in: self.superview).y
        switch sender.state {
        case .changed:
            if transfromY > 0 {
                self.transform = CGAffineTransform(translationX: 0, y: transfromY)
            } else {
                self.transform = .identity
            }
        case .ended:
            if transfromY < transitionHeight {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.transform = .identity
                })
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
                } completion: { isSucceed in
                    self.delegate?.dismissView()
                }
            }
        default:
            break
        }
    }
    
}
