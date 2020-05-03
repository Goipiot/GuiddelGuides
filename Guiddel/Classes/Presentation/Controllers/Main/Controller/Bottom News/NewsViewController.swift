//
//  NewsViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 02.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
    // MARK: - Private Methods
    private func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize.width = (newsCollectionView.frame.width - 40)/2
        layout.itemSize.height = (newsCollectionView.frame.width - 40)/2
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        print(newsCollectionView)
        newsCollectionView.collectionViewLayout = layout
    }
    
    
}
// MARK: UICollectionViewDataSource
extension NewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        
        cell.museumImageView.image = #imageLiteral(resourceName: "british-museum-london-exterior")
        
        return cell
    }
    
    
}

// MARK: UICollectionViewDelegate

extension NewsViewController: UICollectionViewDelegate {
    
    
}
