//
//  DeletePopUpVC.swift
//  Pouch
//
//  Created by Prince on 07/02/23.
//

import UIKit

protocol DeletePopUpVCDelegate{
    func yesAction()
}

class DeletePopUpVC: UIViewController {
    
    
    @IBOutlet weak var contentView: SwipeableView!
    @IBOutlet weak var deleteMessageLabel: UILabel!
    
    var delegate:DeletePopUpVCDelegate?
    var transitionHeight: CGFloat = 150
    
    init(delegate:DeletePopUpVCDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesctext()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.contentView.setInitialAnimation(delegate: self)
    }
    
    func dismissController(){
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        self.dismissController()
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        self.delegate?.yesAction()
        self.dismissController()
    }
    
    func setDesctext() {
        let attributedString = NSMutableAttributedString(string: "Are you sure you want to delete the membership.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        deleteMessageLabel.attributedText = attributedString
    }
}

extension DeletePopUpVC: SwipeableViewDelegate{
    func dismissView() {
        self.dismiss(animated: false)
    }
}
