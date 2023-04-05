//
//  CardsCollectionViewLayout.swift
//  Pouch
//
//  Created by Raman choudhary on 07/03/23.
//
import UIKit

protocol CardsCollectionViewLayoutDelegate{
    func frontCellIndex(index:Int)
}

open class CardsCollectionViewLayout: UICollectionViewLayout {

  // MARK: - Layout configuration

  public var itemSize: CGSize = CGSize(width: 200, height: 300) {
    didSet{
      invalidateLayout()
    }
  }
    var delegate:CardsCollectionViewLayoutDelegate?

  public var spacing: CGFloat = 10.0 {
    didSet{
      invalidateLayout()
    }
  }

  public var maximumVisibleItems: Int = 3 {
    didSet{
      invalidateLayout()
    }
  }
    
    init(item_size:CGSize,delegate:CardsCollectionViewLayoutDelegate?) {
        super.init()
        self.delegate = delegate
        self.itemSize = item_size
        self.itemSize.height = item_size.height - (CGFloat(maximumVisibleItems) * spacing)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  // MARK: UICollectionViewLayout

  override open var collectionView: UICollectionView {
    return super.collectionView!
  }

  override open var collectionViewContentSize: CGSize {
    let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
    return CGSize(width: collectionView.bounds.width * itemsCount,
                  height: collectionView.bounds.height)
  }

  override open func prepare() {
    super.prepare()
    assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
  }

  override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let totalItemsCount = collectionView.numberOfItems(inSection: 0)

    let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
    let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)

    let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)

    let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)

    let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width

    let visibleIndices = stride(from: minVisibleIndex, to: maxVisibleIndex, by: 1)

    let attributes: [UICollectionViewLayoutAttributes] = visibleIndices.map { index in
      let indexPath = IndexPath(item: index, section: 0)
      return computeLayoutAttributesForItem(indexPath: indexPath,
                                     minVisibleIndex: minVisibleIndex,
                                     contentCenterX: contentCenterX,
                                     deltaOffset: CGFloat(deltaOffset),
                                     percentageDeltaOffset: percentageDeltaOffset)
    }

    return attributes
  }

  override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      print("itemIndex:\(indexPath.row)")
    let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
    let minVisibleIndex = Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width)
    let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
    let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
    return computeLayoutAttributesForItem(indexPath: indexPath,
                                   minVisibleIndex: minVisibleIndex,
                                   contentCenterX: contentCenterX,
                                   deltaOffset: CGFloat(deltaOffset),
                                   percentageDeltaOffset: percentageDeltaOffset)
  }

  override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}


// MARK: - Layout computations

fileprivate extension CardsCollectionViewLayout {

  private func scale(at index: Int) -> CGFloat {
    let translatedCoefficient = CGFloat(index) - CGFloat(self.maximumVisibleItems) / 2
    return CGFloat(pow(0.95, translatedCoefficient))
  }

  private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
    var rawScale = visibleIndex < maximumVisibleItems ? scale(at: visibleIndex) : 1.0

    if visibleIndex != 0 {
      let previousScale = scale(at: visibleIndex - 1)
      let delta = (previousScale - rawScale) * percentageOffset
      rawScale += delta
    }
    return CGAffineTransform(scaleX: rawScale, y: rawScale)
  }

    func computeLayoutAttributesForItem(indexPath: IndexPath,
                                       minVisibleIndex: Int,
                                       contentCenterX: CGFloat,
                                       deltaOffset: CGFloat,
                                       percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
      
    let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
    let visibleIndex = indexPath.row - minVisibleIndex
      attributes.size = CGSize(width: itemSize.width - 2*spacing * CGFloat(visibleIndex), height: itemSize.height)
    let midY = self.collectionView.bounds.midY
    attributes.center =  CGPoint(x: contentCenterX ,
                                 y: midY + spacing * CGFloat(visibleIndex))//CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                //y: midY + spacing * CGFloat(visibleIndex))
    attributes.zIndex = maximumVisibleItems - visibleIndex
      
    //attributes.transform = transform(atCurrentVisibleIndex: visibleIndex,
                              //            percentageOffset: percentageDeltaOffset)
    switch visibleIndex {
    case 0:
      attributes.center.x -= deltaOffset
        attributes.alpha = 1
      break
    case 1..<maximumVisibleItems:
//      attributes.center.x -= spacing * percentageDeltaOffset
      attributes.center.y -= spacing * percentageDeltaOffset
        attributes.size.width += 2*spacing * percentageDeltaOffset
        
//      if visibleIndex == maximumVisibleItems - 1 {
//        attributes.alpha = percentageDeltaOffset
//      }else{
          attributes.alpha = 1 - CGFloat(visibleIndex) / CGFloat(maximumVisibleItems)
//      }
      break
    default:
      attributes.alpha = 0
      break
    }
        self.delegate?.frontCellIndex(index: minVisibleIndex)
//        print("index::\(indexPath)")
//        print("visibleindex::\(visibleIndex)")
//        print("minvisibleindex::\(minVisibleIndex)")
//        print("layout percent delta:\(percentageDeltaOffset)")
//        print("layout delta:\(deltaOffset)")
    return attributes
  }
}
