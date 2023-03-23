//
//  MembershipVC.swift
//  Pouch
//
//  Created by Prince on 06/02/23.
//

import UIKit

class CardDetailVC: UIViewController {
    

    @IBOutlet weak var card_View: CardView!
    
    var card_data:CardsData?
    
    init(cardData:CardsData?) {
        super.init(nibName: nil, bundle: nil)
        self.card_data = cardData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.card_View.isOpen = true
        self.card_View.delegate = self
        self.card_View.setCardViewData(data: self.card_data)
    }
}

extension CardDetailVC: CardViewDelegate{
    func closeCard() {
        self.popViewController(false)
    }
    
    func deleteCard(cardData: CardsData?) {
        self.present(DeletePopUpVC(delegate: self), false)
    }
}

extension CardDetailVC: DeletePopUpVCDelegate{
    func yesAction() {
        guard let card_id = self.card_data?.id else{return}
        ApiHandler.call(apiName: API.Name.get_cards, id: card_id, httpMethod: .DELETE) { (data:MessageResponse?, error) in
            DatabaseManager.shared.deleteDocFromDb(document_id: card_id, dbName: DatabaseManager.kDBName) { succeed in
                if succeed {
                    DispatchQueue.main.async {
                        self.popVC()
                    }
                }
            }
        }
    }
}
