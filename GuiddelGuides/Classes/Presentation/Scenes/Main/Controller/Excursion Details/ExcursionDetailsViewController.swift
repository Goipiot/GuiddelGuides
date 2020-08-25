//
//  ExcursionDetailsViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 21.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionDetailsViewController: ExcursionInfoViewController {
    
    fileprivate var viewModel: ExcursionViewModel?
    private var excursionImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        if viewModel != nil {
            excursionTableView?.dataSource = viewModel
            excursionTableView.reloadData()
        }
        if let excursionImage = excursionImage {
            excursionImageView.image = excursionImage
        }
    }
    
    // MARK: - Public Methods
    public func setData(excursionVM: ExcursionViewModel, image: UIImage?) {
        excursionImage = image
        viewModel = excursionVM
    }
}
