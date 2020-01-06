//
//  ViewController.swift
//  SUITabView
//
//  Created by Canopas on 06/01/20.
//  Copyright © 2020 Canopas Inc. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    private var sTabBar: SUITabBar!
       
    override var selectedIndex: Int {
        didSet {
            sTabBar?.selectedItem = selectedIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupLuxeTabBar()
        setViewControllers([Controller1(), Controller2(), Controller3(), Controller4()], animated: false)
    }

    private func setupLuxeTabBar() {
        let tabBar = SUITabBar.create(delegate: self)
        self.sTabBar = tabBar
        sTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sTabBar)
        view.setSameDimensionConstrains(anotherView: sTabBar)
    }
    
    func showTabBar(animated:Bool = true) {
        sTabBar.showTabBar(animated: animated)
    }
    
    func hideTabBar(animated:Bool = true) {
        sTabBar.hideTabBar(animated: animated)
    }
}

extension ViewController: LXTabBarDelegate {
    var defaultSelectedIndex: Int {
        return 0
    }
    
    func tabBarView(_ tabBar: SUITabBar, didSelectItem index: Int) {
        selectedIndex = index
    }
}

extension UIView {
    func setSameDimensionConstrains(anotherView: UIView) {
        bottomAnchor.constraint(equalTo: anotherView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: anotherView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: anotherView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: anotherView.topAnchor).isActive = true
    }
}


extension UIViewController {
    var homeViewController: ViewController? {
        tabBarController as? ViewController
    }
}


class Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.panGestureRecognizer.addTarget(self, action: #selector(onDrage(_:)))
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image = .actions
        return cell
    }
    
    
    @objc
       func onDrage(_ sender:UIPanGestureRecognizer) {
           let t = sender.translation(in: view)
           let v = sender.velocity(in: view)
           
           switch sender.state {
           case .changed:
               if t.y < -66 {
                   homeViewController?.hideTabBar()
               } else if t.y > 0 {
                   homeViewController?.showTabBar()
               }
           case .ended:
               if v.y < -250 {
                   homeViewController?.hideTabBar()
               } else if t.y > -66 {
                   homeViewController?.showTabBar()
               }
           default:break
           }
       }
}


class Controller1: Controller {
   override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}

class Controller2: Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class Controller3: Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

class Controller4: Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}
