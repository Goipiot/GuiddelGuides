//
//  BottomMenuViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import FloatingPanel

class BottomMenuViewController: UIViewController {

    private var museumRequestNameVC = SearchTableViewController()
    private var museumRequestVC = BottomTableViewController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStackView: UIStackView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuChild(for: .name)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Work with children

extension BottomMenuViewController {
    
    func addMenuChild(for state: Child) {
        switch state {
        case .creation:
            self.addChildViewController(museumRequestVC)
            containerStackView.addArrangedSubview(museumRequestVC.view)
            museumRequestVC.didMove(toParentViewController: self)
        case .name:
            self.addChildViewController(museumRequestNameVC)
            containerStackView.addArrangedSubview(museumRequestNameVC.view)
            museumRequestNameVC.didMove(toParentViewController: self)
        }
    }
}

