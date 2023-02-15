//
//  HomeScreenVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 06/02/23.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    var item:[String] = ["Memberships","Vouchers","Coupons","BoardingPasses","Tickets,"]
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var selectedIndex:Int = 0
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.isPagingEnabled = true
        homeCollectionView.showsHorizontalScrollIndicator = false
        homeCollectionView.delaysContentTouches = false
        self.view.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0,1])
        self.setCollectionView()
    }
    
                                                                                                             
    func setCollectionView(){
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.register(cellClass: HomeCollectionCell.self)
        itemCollectionView.register(cellClass: ItemsCollectionCell.self)
    }
    
    @IBAction func moreAction(_ sender: Any) {
        let vc = SideMenuVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeScreenVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == itemCollectionView ? item.count : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeCollectionView{
            let cell = collectionView.dequeue(cellClass: HomeCollectionCell.self, forIndexPath: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeue(cellClass: ItemsCollectionCell.self, forIndexPath: indexPath)
            cell.itemLabel.text = item[indexPath.row]
            if self.selectedIndex == indexPath.row{
                cell.contentHighlightView.isHidden = false
                cell.itemLabel.textColor = UIColor.appColor(.themeWhite)
            }else{
                cell.contentHighlightView.isHidden = true
                cell.itemLabel.textColor = UIColor.appColor(.lightGray)
            }
            return cell
        }
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView{
            self.selectedIndex = indexPath.row
            collectionView.reloadData()
        }else{
            self.pushViewController(MembershipVC(), true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemCollectionView{
            let calculatedFrame = item[indexPath.row].widthWithConstrainedHeight(height: 50, font: UIFont.setCustom(.latoSemibold, 14))
            return CGSize(width: calculatedFrame.width + 40, height: 50)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
}

extension HomeScreenVC: HomeViewProtocol{
    
}

                                                                

