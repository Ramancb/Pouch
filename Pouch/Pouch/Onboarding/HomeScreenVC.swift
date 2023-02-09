//
//  HomeScreenVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 06/02/23.
//

import UIKit

class HomeScreenVC: UIViewController {

    var item:[String] = ["Memberships","Vouchers","Coupons","BoardingPasses","Tickets"]

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var selectedIndex:Int = 0
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0,1])
        self.setCollectionView()
    }

    func setCollectionView(){
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "HomeCollectionCell"), forCellWithReuseIdentifier: "HomeCollectionCell")
    }
    @IBAction func moreAction(_ sender: Any) {
        let vc = SideMenuVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeScreenVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.itemLabel.text = item[indexPath.row]
        if self.selectedIndex == indexPath.row{
            cell.contentHighlightView.isHidden = false
        }else{
            cell.contentHighlightView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatedFrame = item[indexPath.row].widthWithConstrainedHeight(height: 50, font: UIFont.setCustom(.latoSemibold, 14))
        return CGSize(width: calculatedFrame.width + 40, height: 50)
    }
    
}

extension HomeScreenVC: HomeViewProtocol{
    
}
