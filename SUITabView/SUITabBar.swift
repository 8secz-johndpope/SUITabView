//
//  LXTabBarLite.swift
//  LuxeRadio
//
//  Created by Satish Vekariya on 19/07/18.
//  Copyright © 2018 Canopas. All rights reserved.
//

import UIKit


protocol LXTabBarDelegate: class {
    var defaultSelectedIndex:Int { get }
    func tabBarView(_ tabBar: SUITabBar, didSelectItem index:Int)
}


class SUITabBar: UIView {
    private static let selectedColor = UIColor.red
    private static let normalColor = UIColor.systemOrange
    
    @IBOutlet weak var itemContainerView: UIView!
    @IBOutlet var barItems: [UIButton]!
    
    
    class func create(delegate: LXTabBarDelegate?) -> SUITabBar {
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as! SUITabBar
        view.delegate = delegate
        view.selectedItem = delegate?.defaultSelectedIndex
        return view
    }
    
    var selectedItem: Int? { // setting nil will deselect all item
        set {
            barItems.forEach { (button) in
                let isSelected = button.tag == newValue
                button.isSelected = isSelected
                button.tintColor = isSelected ? SUITabBar.selectedColor : SUITabBar.normalColor
            }
        }
        get {
            return barItems.first(where: {$0.isSelected})?.tag
        }
    }
    
    weak var delegate: LXTabBarDelegate?    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemContainerView.layer.cornerRadius = itemContainerView.frame.height/2
        itemContainerView.clipsToBounds = true
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return itemContainerView.frame.contains(point)
    }
    

    @IBAction func onItemClick(_ sender: UIButton) {
        selectedItem = sender.tag
        delegate?.tabBarView(self, didSelectItem: sender.tag)
    }
    
   
}

extension SUITabBar {
    func hideTabBar(animated:Bool = true) {
        let tx = CGAffineTransform(translationX: 0, y: self.itemContainerView.frame.height + 12 + self.safeAreaInsets.bottom)
        guard self.itemContainerView.transform != tx else { return }
        let task = {
            self.itemContainerView.transform = tx
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                task()
            }
        } else {
            task()
        }
    }
    
    func showTabBar(animated:Bool = true) {
        let tx = CGAffineTransform(translationX: 0, y: 0)
        guard self.itemContainerView.transform != tx else { return }
        let task = {
            self.itemContainerView.transform = tx
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                task()
            }
        } else {
            task()
        }
    }
}
