//
//  HomeScreenVC.swift
//  Pouch

import UIKit
import CouchbaseLiteSwift

class HomeScreenVC: UIViewController {
    
    /// ViewController IBoutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    /// ViewController global variables
    var selectedIndex:Int = 0
    var presenter: HomePresenterProtocol?
    var categories:[CategoryData]?
    var cardsData:[CardsData]?
    
    /// ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTapOnNameView()
        self.presenter?.getCardsCategories()
        self.view.applyGradient(colours: [UIColor(hexString: "#161a1a"), UIColor(hexString: "#000000") ], locations: [0,0.7])
        self.setCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.apiCallTOGetCardsData()
        self.presenter?.getUserProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeCollectionView.isPagingEnabled = true
        homeCollectionView.showsHorizontalScrollIndicator = false
        homeCollectionView.delaysContentTouches = false
        let itemSize = CGSize(width: homeCollectionView.frame.width - 20, height: (homeCollectionView.frame.height))
        homeCollectionView.collectionViewLayout = CardsCollectionViewLayout(item_size: itemSize)
    }
    
    /// Method to set collections delegate and data source
    func setCollectionView(){
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.register(cellClass: HomeCollectionCell.self)
        homeCollectionView.register(cellClass: BoardingPassCardCell.self)
        itemCollectionView.register(cellClass: ItemsCollectionCell.self)
    }
    
    ///  Handling tap on name
    func setTapOnNameView(){
        self.nameView.isUserInteractionEnabled = true
        self.nameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.editNameAction)))
    }
    
    @objc func editNameAction(){
        let controller = EditProfilePresenter.CreateEditProfileModule(delegate: self)
        self.present(controller, false)
    }
    
    /// ViewController  IBActions
    @IBAction func moreAction(_ sender: Any) {
        let controller = SettingsPresenter.createSettingsModule()
        self.pushViewController(controller, true)
    }
}

extension HomeScreenVC: EditProfileVCDelegate{
    
    /// Edit profile delegate method to show updated user profile data
    func editProfileSuccess() {
        self.presenter?.getUserProfile()
    }
}

extension HomeScreenVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    /// CollectionView delegate datasource methods
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == itemCollectionView ? (categories?.count ?? 0)  : (self.cardsData?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeCollectionView{
            if cardsData?[indexPath.item].type == CardType.boardingPass.rawValue{
                let cell = collectionView.dequeue(cellClass: BoardingPassCardCell.self, forIndexPath: indexPath)
                cell.setBoardingPassCard(card: cardsData?[indexPath.item])
                return cell
            }else{
                let cell = collectionView.dequeue(cellClass: HomeCollectionCell.self, forIndexPath: indexPath)
                cell.setCellData(cardData: self.cardsData?[indexPath.item])
                return cell
            }
            
        }else{
            let cell = collectionView.dequeue(cellClass: ItemsCollectionCell.self, forIndexPath: indexPath)
            cell.setCellData(data: self.categories?[indexPath.item], isSelected: self.selectedIndex == indexPath.row)
            return cell
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.homeCollectionView else{return}
        guard let cell = homeCollectionView.visibleCells.first else{ return}
        if let indexPath = homeCollectionView.indexPath(for: cell){
            if let index = self.categories?.firstIndex(where: {$0.name?.lowercased() == self.cardsData?[indexPath.item].type?.lowercased()}){
                self.selectedIndex = index
                self.itemCollectionView.reloadData()
                self.itemCollectionView.scrollToItem(at: IndexPath(item: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView{
            self.selectedIndex = indexPath.row
            if let data = self.cardsData {
                if let index = data.firstIndex(where: {$0.type == self.categories?[indexPath.item].name?.uppercased()}) {
                    self.homeCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
            collectionView.reloadData()
        }else{
            if cardsData?[indexPath.item].type == CardType.boardingPass.rawValue{
                
            }else{
                self.pushViewController(CardDetailVC(cardData: self.cardsData?[indexPath.item]), false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemCollectionView{
            let calculatedFrame = categories?[indexPath.row].displayName?.widthWithConstrainedHeight(height: 50, font: UIFont.setCustom(.latoSemibold, 14))
            return CGSize(width: (calculatedFrame?.width ?? 0) + 40, height: 50)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
}

extension HomeScreenVC: HomeViewProtocol{
    /// Method to update name city with api response
    func configureUserName() {
        DispatchQueue.main.async {
            self.nameLabel.text = "\(UserDefaultsCustom.getUserData()?.firstName ?? "") \(UserDefaultsCustom.getUserData()?.lastName ?? "")"
            self.cityLabel.text = UserDefaultsCustom.getUserData()?.city
        }
    }
    
    /// Method to update category list with api response
    func updateCategoryCollection(categories: [CategoryData]?) {
        DispatchQueue.main.async {
            self.categories = categories
            self.itemCollectionView.reloadData()
        }
    }
    
    ///  Method to update cards list with api response
    func updateCardsCollection(data: [CardsData]?) {
        DispatchQueue.main.async {
            self.cardsData = data
            self.homeCollectionView.reloadData()
        }
    }
}



