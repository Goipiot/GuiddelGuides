//
//  BottomMenuViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import FloatingPanel

protocol BottomMenuViewControllerDelegate: class {
    func stateChanged(to state: ChildVCState)
}

class BottomMenuViewController: UIViewController {
    
    // MARK:- Private properties
    private var museumRequestNameVC: SearchTableViewController!
    private var museumRequestVC: RequestTableViewController!
    private var museumNewsVC: NewsViewController!
    
    // MARK:- Public properties
    weak var delegate: BottomMenuViewControllerDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStackView: UIStackView!
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Public Methods
    @objc public func museumRequestChanged(_ notification: Notification) {
        guard let name = notification.object as? String else {
            return
        }
        changeState(to: .creation)
    }
    
    // MARK: - Private Methods
    private func setup() {
        guard let newsVC = storyboard?.instantiateViewController(withIdentifier: "newsVC") as? NewsViewController else {return}
        guard let requestNameVC = storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchTableViewController else {return}
        guard let requestVC = storyboard?.instantiateViewController(withIdentifier: "requestVC") as? RequestTableViewController else {return}
        museumNewsVC = newsVC
        requestNameVC.delegate = self
        museumRequestNameVC = requestNameVC
        museumRequestVC = requestVC
        addMenuChild(for: .news)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(museumRequestChanged(_:)),
                                               name: .didChangedMuseumRequestName,
                                               object: nil)
    }

}

// MARK: - Work with children

extension BottomMenuViewController {
    
    private func addMenuChild(for state: ChildVCState) {
        switch state {
        case .creation:
            self.addChildViewController(museumRequestVC)
            containerStackView.addArrangedSubview(museumRequestVC.view)
            museumRequestVC.didMove(toParentViewController: self)
        case .name:
            self.addChildViewController(museumRequestNameVC)
            containerStackView.addArrangedSubview(museumRequestNameVC.view)
            museumRequestNameVC.didMove(toParentViewController: self)
        case .news:
            self.addChildViewController(museumNewsVC)
            containerStackView.addArrangedSubview(museumNewsVC.view)
            museumNewsVC.didMove(toParentViewController: self)
        }
    }
    
    private func removeChild() {
        guard let childVC = self.childViewControllers.first else {return}
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }
    
    public func changeState(to child: ChildVCState) {
        removeChild()
        addMenuChild(for: child)
    }
}

//MARK: - SearchTableViewControllerDelegate
extension BottomMenuViewController: SearchTableViewControllerDelegate {
    func museumPicked(museum: MuseumViewModel) {
        MuseumRequestManager.shared.museumRequest.museumId = museum.name
        
        changeState(to: .creation)
    }
}
