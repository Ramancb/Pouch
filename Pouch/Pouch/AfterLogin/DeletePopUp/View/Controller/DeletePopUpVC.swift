//
//  DeletePopUpVC.swift
//  Pouch
//
//  Created by Prince on 07/02/23.
//

import UIKit

class DeletePopUpVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var deleteMessageLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        information()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform.identity
        }
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
        self.dismissController()
    }
    
    func information() {
        let attributedString = NSMutableAttributedString(string: "Are you sure you want to delete /n the membership.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        deleteMessageLabel.attributedText = attributedString
    }
}
