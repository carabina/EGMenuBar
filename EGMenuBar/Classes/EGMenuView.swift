//
//  EGMenuView.swift
//  EGMenuViewExample
//
//  Created by Emil Gräs on 21/10/2016.
//  Copyright © 2016 Emil Gräs. All rights reserved.
//

import UIKit

protocol EGMenuViewDatasource: class {
    func numberOfItems() -> Int
    func itemImages() -> [UIImage]
    func itemTitles() -> [String]
}

protocol EGMenuViewDelegate: class {
    func didSelectItemAtIndex(menuView: EGMenuView, index: Int)
    func interItemSpacing(menuView: EGMenuView) -> Double // TODO: Make this optional
    func itemHeight(menuView: EGMenuView) -> Double
}

class EGMenuView: UIView {
    
    // MARK: - Public Properties
    var itemHeight: CGFloat = 30
    var interItemSpacing: CGFloat = 10
    var menuHeight: CGFloat!
    var menuWidth: CGFloat!
    var menuBackgroundColor: UIColor = .whiteColor() // TODO: Should be read/write
    
    // MARK: - Public Methods
    func show() {
        UIView.animateWithDuration(0.4) {
            self.alpha = 1
            self.transform = CGAffineTransformIdentity
        }
        
        
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[0]
            let constraint = self.itemCenterYConstraints[0]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransformIdentity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[1]
            let constraint = self.itemCenterYConstraints[1]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransformIdentity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[2]
            let constraint = self.itemCenterYConstraints[2]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransformIdentity
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[3]
            let constraint = self.itemCenterYConstraints[3]
            constraint.constant = 0
            item?.alpha = 1
            item?.transform = CGAffineTransformIdentity
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    func hide() {
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: .CurveEaseInOut, animations: {
            self.alpha = 0
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
            let scale = CGAffineTransformMakeScale(0.9, 0.9)
            let transform = CGAffineTransformTranslate(scale, 0, 15)
            self.transform = transform
            }, completion: nil)
        
        
        
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[3]
            let constraint = self.itemCenterYConstraints[3]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[2]
            let constraint = self.itemCenterYConstraints[2]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[1]
            let constraint = self.itemCenterYConstraints[1]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.15, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let item = self.items[0]
            let constraint = self.itemCenterYConstraints[0]
            constraint.constant = 100
            item?.alpha = 0
            item?.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    /// not used yet
    func itemSelected(completion: (finished: Bool) -> Void) {
        
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations: {
            self.alpha = 0
            }, completion: nil)

        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .CurveEaseInOut, animations: {
            let scale = CGAffineTransformMakeScale(0.9, 0.9)
            let transform = CGAffineTransformTranslate(scale, 0, 100)
            self.transform = transform
            
            for (index, item) in self.items {
                let constraint = self.itemCenterYConstraints[index]
                constraint.constant = 100
                item.alpha = 0
                item.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.layoutIfNeeded()
            }

            }, completion: {(finsihed) in
                completion(finished: true)
            })

    }

    
    
    // MARK: - Datasource & Delegate
    weak var datasource: EGMenuViewDatasource? {
        didSet {
            
        }
    }
    weak var delegate: EGMenuViewDelegate? {
        didSet {
            setupMenuView()
            setupMenuItems()
            setupMenuItemImages()
            setupMenuItemTitles()
        }
    }

    // MARK: - Private
    private var items: [Int: EGMenuViewItem] = [:]
    private var itemCenterYConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
    }
    
    // MARK: - Helper Methods
    
    private func setupMenuView() {
        print("setup")
        if let height = delegate?.itemHeight(self) {
            print("height: \(height)")
            itemHeight = CGFloat(height)
        }
        if let spacing = delegate?.interItemSpacing(self) {
            print("spacing: \(spacing)")
            interItemSpacing = CGFloat(spacing)
        }
        if let numberOfItems = datasource?.numberOfItems() {
            menuHeight =  itemHeight + (interItemSpacing * 2)
            menuWidth = (CGFloat(numberOfItems) * itemHeight) + ((CGFloat(numberOfItems) + 1) * interItemSpacing)
            frame = CGRectMake(0, 0, menuWidth, menuHeight)
        }
        
        alpha = 0
        backgroundColor = menuBackgroundColor
        layer.cornerRadius = menuHeight / 2
        layer.shadowOffset = CGSizeMake(0, 0)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.borderWidth = 0.4
        layer.borderColor = UIColor.darkGrayColor().CGColor

        let scale = CGAffineTransformMakeScale(1, 1) // CGAffineTransformMakeScale(1, 1)
        let transform = CGAffineTransformTranslate(scale, 0, 10)
        self.transform = transform
    }
    
    private func setupMenuItems() {
        if let numberOfItems = datasource?.numberOfItems() {
            var previosItem: EGMenuViewItem? = nil
            for index in 0...numberOfItems-1 {
                let item = EGMenuViewItem()
                item.translatesAutoresizingMaskIntoConstraints = false
                item.delegate = self
                item.layer.cornerRadius = itemHeight / 2
                item.layer.masksToBounds = true
                item.alpha = 0
                item.index = index
                items[index] = item
                addSubview(item)
                setupContraintForItem(item, withIndex: index, previousItem: previosItem, lastItem: index == numberOfItems - 1 ? true : false)
                previosItem = item
                setupInitialTransformForItem(item)
            }
        }
    }
    
    private func setupContraintForItem(item: EGMenuViewItem, withIndex index: Int, previousItem prevItem: EGMenuViewItem?, lastItem: Bool) {
        if let prevItem = prevItem where !lastItem {
            // middle items
            item.leadingAnchor.constraintEqualToAnchor(prevItem.trailingAnchor, constant: interItemSpacing).active = true
            let centerYConstraint = item.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.active = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraintEqualToConstant(itemHeight).active = true
            item.heightAnchor.constraintEqualToConstant(itemHeight).active = true
        } else if let prevItem = prevItem where lastItem {
            // last item
            item.leadingAnchor.constraintEqualToAnchor(prevItem.trailingAnchor, constant: interItemSpacing).active = true
            item.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -interItemSpacing).active = true
            let centerYConstraint = item.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.active = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraintEqualToConstant(itemHeight).active = true
            item.heightAnchor.constraintEqualToConstant(itemHeight).active = true
        } else {
            // first item
            item.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: interItemSpacing).active = true
            let centerYConstraint = item.centerYAnchor.constraintEqualToAnchor(centerYAnchor)
            centerYConstraint.constant = 100
            centerYConstraint.active = true
            self.itemCenterYConstraints.append(centerYConstraint)
            item.widthAnchor.constraintEqualToConstant(itemHeight).active = true
            item.heightAnchor.constraintEqualToConstant(itemHeight).active = true
        }
        
    }
    
    private func setupInitialTransformForItem(item: EGMenuViewItem) {
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        item.transform = scale
    }
 
    private func setupMenuItemImages() {
        if let images = datasource?.itemImages() {
            for (index, image) in images.enumerate() {
                items[index]?.image = image
            }
        }
    }
    
    private func setupMenuItemTitles() {
        if let titles = datasource?.itemTitles() {
            for (index, title) in titles.enumerate() {
                items[index]?.title = title
            }
        }
    }

}



extension EGMenuView: EGMenuViewItemDelegate {
    func didSelectItemAtIndex(index: Int) {
        delegate?.didSelectItemAtIndex(self, index: index)
    }
}





