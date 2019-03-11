//
//  PXResultSizeCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/29/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
protocol PXResultSizeCellDelegate: class {
    func didClickedOnRegularButton()
    func didUserChangeSize(index: Int)
}

class PXResultSizeCell: UITableViewCell {

    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var leftSlideButton: UIButton!
    @IBOutlet weak var rightSlideButton: UIButton!
    @IBOutlet weak var regularButton: UIButton!
    @IBOutlet weak var resultTitleLabel: UILabel!
    weak var delegate:PXResultSizeCellDelegate?
    
    @IBOutlet weak var closetLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var closetLabelTopMargin: NSLayoutConstraint!
    @IBOutlet weak var regularLabelTopMargin: NSLayoutConstraint!
    @IBOutlet weak var titleTopMargin: NSLayoutConstraint!
    let collectionTopInset: CGFloat = 0
    let collectionBottomInset: CGFloat = 0
    let collectionLeftInset: CGFloat = 0
    let collectionRightInset: CGFloat = 0
    var sizeArray = PXDataManager.sharedManager.resultModel?.resultArr
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: PXSizeTypeCell.className, bundle: Bundle.main)
        sizeCollectionView.register(nib, forCellWithReuseIdentifier: PXSizeTypeCell.className)
        if sizeArray!.count <= 1 {
            leftSlideButton.isHidden = true
            rightSlideButton.isHidden = true
        }
        regularButton.setTitle(PXDataManager.sharedManager.selectedFirPrefType.value, for: .normal)
        setUp()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp() {
        DispatchQueue.main.async {
            if let element = self.sizeArray,
                let local = element.first(where: {$0.recommended == 1}),
                let index = element.index(where: {$0.recommended == 1}) {
                let indexPath = IndexPath(item: index+1, section: 0)
                self.slide(position: [], indexPath: indexPath)
                self.setTitle(index: index)
                PXDataManager.sharedManager.setEntryPageTitleOnSelection(text: PXUtility.getConvertedSizeString(size: local.size ?? ""))
            }else {
                self.resultTitleLabel.text = "OUR SIZES MAY NOT BE A PERFECT FIT"
                PXDataManager.sharedManager.setEntryPageTitle(title: "CHECK YOUR FIT")
            }
        }

    }
    
    @IBAction func regularButtonClicked(_ sender: Any) {
        if let del = delegate {
            del.didClickedOnRegularButton()
        }
    }
    
    @IBAction func slideToRight(_ sender: UIButton) {
        let indexPath = sizeCollectionView.indexPathsForVisibleItems.first
        guard let index = indexPath, !isLastIndex(indexPath: index) else {
            return
        }
        slide(position: .right, indexPath: index)
    }
    
    @IBAction func slideToLeft(_ sender: UIButton) {
        let indexPath = sizeCollectionView.indexPathsForVisibleItems.first
        guard let index = indexPath, !isFirstIndex(indexPath: index) else {
            return
        }
        slide(position: .left, indexPath: index)
    }
    
    func slide(position: UICollectionView.ScrollPosition, indexPath: IndexPath) {
        let index  = position == .right ? (indexPath.item + 1) : (indexPath.item - 1)
        let newIndexPath = IndexPath(item: index, section: 0)
        sizeCollectionView.scrollToItem(at: newIndexPath, at: position, animated: false)
        delegate?.didUserChangeSize(index: index)
        setTitle(index: index)
        updateSliderButton(index)

        
    }
    
    func isFirstIndex(indexPath: IndexPath) -> Bool {
        return (indexPath.item == 0 ? true : false)
    }
    
    func isLastIndex(indexPath: IndexPath) -> Bool {
        return (indexPath.item == sizeArray!.count-1 ? true : false)
    }
    
    func setTitle(index: Int) {
        guard let selectedFys = sizeArray?[index] else {
            resultTitleLabel.text = "OUR SIZES MAY NOT BE A PERFECT FIT"
            return
        }
        if selectedFys.recommended == 0 {
            if let element = PXDataManager.sharedManager.resultModel,
                let local = element.resultArr.first(where: {$0.recommended == 1}) {
                let sizeString = PXUtility.getConvertedSizeString(size: local.size!)
                resultTitleLabel.text = "FOR THIS ITEM, WE WOULD RECOMMEND \(sizeString.uppercased())"
                setConstraint(isRecommended: true)
            }else {
                resultTitleLabel.text = "OUR SIZES MAY NOT BE A PERFECT FIT"
                setConstraint(isRecommended: false)
            }
        }else {
            resultTitleLabel.text = "FOR THIS ITEM, YOU’LL LOOK BEST IN"
            setConstraint(isRecommended: true)
        }
    }
    
    func setTitlTopMargin(isAvailable: Bool) {
        if isAvailable {
            titleTopMargin.constant = 40
        }else {
            titleTopMargin.constant = 30
        }
    }
    
    func setConstraint(isRecommended: Bool) {
        if isRecommended {
            closetLabelHeight.constant = 0
            closetLabelTopMargin.constant = 0
            regularLabelTopMargin.constant = 14
        }else {
            closetLabelHeight.constant = 12
            closetLabelTopMargin.constant = 20
            regularLabelTopMargin.constant = 52
        }
    }
    func updateSliderButton(_ index: Int) {
        if index == 0 {
            leftSlideButton.isHidden = true
            rightSlideButton.isHidden = false
        } else if index == (sizeArray?.count ?? 1) - 1 {
            rightSlideButton.isHidden = true
            leftSlideButton.isHidden = false
        } else{
            leftSlideButton.isHidden = false
            rightSlideButton.isHidden = false
        }
    }
}

extension PXResultSizeCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return sizeArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PXSizeTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: PXSizeTypeCell.className, for: indexPath) as? PXSizeTypeCell else {
            return UICollectionViewCell()
        }
        if let selectedFys = sizeArray?[indexPath.item] {
            cell.setUI(selectedVal: selectedFys)
        }
        return cell
    }
    
    // MARK: <UICollectionViewDelegate Flow Layout>
    
   
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionTopInset, left: collectionLeftInset, bottom: collectionBottomInset, right: collectionRightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 50
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
    
    // MARK: <UICollectionView Delegate>
    
    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        
    }
    
}

extension PXResultSizeCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        // Do whatever with currentPage.
        delegate?.didUserChangeSize(index: currentPage)
        setTitle(index: currentPage)
        updateSliderButton(currentPage)
    }
}
