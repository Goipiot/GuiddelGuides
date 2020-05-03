//
//  MainViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 30.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase
import FloatingPanel

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    private var handle: AuthStateDidChangeListenerHandle?
    private var fpc: FloatingPanelController!
    private var bottomMenuVC: BottomMenuViewController!
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            AuthManager.shared.updateCurrentUser(with: user)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomMenuVC.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    // MARK: - Public Methods
    @objc public func museumRequestChanged(_ notification: Notification) {
        guard let name = notification.object as? String else {
            return
        }
        
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupBottomMenu()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(museumRequestChanged(_:)),
                                               name: .didChangedMuseumRequestName,
                                               object: nil)
        
    }

}

// MARK: - FloatingPanelControllerDelegate
extension MainViewController: FloatingPanelControllerDelegate {
    
    func setupBottomMenu() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        if #available(iOS 11, *) {
            fpc.surfaceView.cornerRadius = 9.0
        } else {
            fpc.surfaceView.cornerRadius = 0.0
        }
        fpc.surfaceView.shadowHidden = false
        

        // Initialize FloatingPanelController and add the view
        fpc.surfaceView.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        fpc.surfaceView.cornerRadius = 24.0
        fpc.surfaceView.shadowHidden = true
        fpc.surfaceView.borderWidth = 1.0 / traitCollection.displayScale
        fpc.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.2)
        fpc.surfaceView.shadowRadius = 2.0
        
        bottomMenuVC = storyboard?.instantiateViewController(withIdentifier: "BottomView") as? BottomMenuViewController
        
        // Set a content view controller
        fpc.set(contentViewController: bottomMenuVC)
        fpc.track(scrollView: bottomMenuVC.scrollView)
        
        fpc.addPanel(toParent: self, animated: true)
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return BottomMenuLayout()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return BottomMenuBehavior()
    }

    func floatingPanelDidMove(_ vc: FloatingPanelController) {
//        let y = vc.surfaceView.frame.origin.y
//        let tipY = vc.originYOfSurface(for: .half)
//        if y > tipY - 44.0 {
//            let progress = max(0.0, min((tipY  - y) / 44.0, 1.0))
//            self.bottomMenuVC.tableView.alpha = progress
//        }
        debugPrint("NearbyPosition : ",vc.nearbyPosition)
    }
    
    func floatingPanelShouldBeginDragging(_ vc: FloatingPanelController) -> Bool {
        return true
    }

    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            bottomMenuVC.searchBar.showsCancelButton = false
            bottomMenuVC.searchBar.resignFirstResponder()
        }
    }
    func floatingPanelDidChangePosition(_ vc: FloatingPanelController) {
        if vc.position == .half {
            bottomMenuVC.changeState(to: .news)
        } 
    }

//    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
//        if targetPosition != .full {
//            bottomMenuVC.searchTableVC.hideHeader()
//        }
//
//        UIView.animate(withDuration: 0.25,
//                       delay: 0.0,
//                       options: .allowUserInteraction,
//                       animations: {
//                        if targetPosition == .half {
//                            self.bottomMenuVC.searchTableVC.tableView.alpha = 0.0
//                        } else {
//                            self.bottomMenuVC.searchTableVC.tableView.alpha = 1.0
//                        }
//        }, completion: nil)
//    }
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
//        bottomMenuVC.searchTableVC.hideHeader()
        fpc.move(to: .half, animated: true)
//        bottomMenuVC.changeState(to: .news)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
//        bottomMenuVC.searchTableVC.showHeader()
//        bottomMenuVC.searchTableVC.tableView.alpha = 1.0
        fpc.move(to: .full, animated: true)
        bottomMenuVC.changeState(to: .name)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


