//
//  ExcursionPreviewViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 16.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionPreviewViewController: ExcursionInfoViewController {
    
    private let excursionRequestManager = ExcursionRequestManager.self
    
    fileprivate var viewModel: ExcursionViewModel? {
        didSet {
            if viewModel != nil {
                excursionTableView?.dataSource = viewModel
                excursionTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excursionImageView.image = ExcursionBuilder.shared.getImage()
    }
    
    @IBAction func createButtonPressed(_ sender: RoundCornersButton) {
        guard let vm = viewModel else { return }
        excursionRequestManager.updateExcursionInfo(excursion: vm.excursion,
                                                    image: ExcursionBuilder.shared.getImage() ) { err in
            if let err = err {
                self.showErrorAlert(message: err.localizedDescription)
            } else {
                guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                appDel.openCreationScene(open: false)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vm = ExcursionViewModel(excursion: ExcursionBuilder.shared.build())
        viewModel = vm
        viewModel!.excursion.museum.name = "Музей имени А.C. Пушкина"
    }
    
}
