//
//  RequestsViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 23.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase

class RequestsViewController: UIViewController {
    
    // MARK: - IBOtlets
    @IBOutlet weak var requestsCollectionView: UICollectionView!
    
    // MARK: - Private properties
    private var handle: AuthStateDidChangeListenerHandle?
    private var nullView: UIView!
    private var requestsArray: [GuideRequest] = [] {
        didSet {
            if requestsArray.count == 0 {
                changeNullView(show: true)
            } else {
                changeNullView(show: false)
            }
            requestsCollectionView.reloadData()
        }
    }

    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else { return }
            AuthManager.shared.updateCurrentUser(with: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Private Methods
    private func setup() {
        GuideRequestFirestoreManager.shared.get { err, requests in
            if let err = err {
                self.showErrorAlert(message: err.localizedDescription)
            } else if let requestArray = requests {
                self.requestsArray = requestArray
            }
        }
        self.navigationController!.navigationBar
            .largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont.getOswald(.bold, size: 34)]
        setupNullView()
    }
    
    private func setLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize.width = self.view.frame.size.width - 30
        layout.itemSize.height = 120
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        requestsCollectionView.collectionViewLayout = layout
    }
    
    private func setupNullView() {
        guard let nullView = Bundle.main.loadNibNamed(
            "NoExcursionsView",
            owner: self,
            options: nil)?.first as? NoExcursionsView else { return }
        guard let height = navigationController?.navigationBar.frame.maxY else { return }
        nullView.frame = view.frame
        nullView.frame.size.height = view.frame.size.height - height
        nullView.frame.origin.y = height
        self.nullView = nullView
        nullView.delegate = self
        view.addSubview(self.nullView)
        view.bringSubview(toFront: self.nullView)
    }

    private func changeNullView(show: Bool) {
        nullView.isHidden = !show
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension RequestsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRequest = requestsArray[indexPath.row]
//        ExcursionManager.shared.createExcursion(request: selectedRequest) { err in
//            if let err = err {
//                self.showErrorAlert(message: err.localizedDescription)
//            }
//        }
    }
    
    func loadImage(from photoURLString: String?, completion: @escaping (Error?, UIImage?) -> Void) {
        guard let string = photoURLString else {
            completion(BaseError.invalidData, nil)
            return
        }
        let createdUrl = URL(string: string)
        guard let url = createdUrl else {
            completion(BaseError.invalidData, nil)
            return
            
        }
        self.getData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(error, nil)
                return
            }
            let image = UIImage(data: data)
            completion(nil, image)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

// MARK: - UICollectionViewDataSource
extension RequestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        requestsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = requestsCollectionView.dequeueReusableCell(withReuseIdentifier: "requestCell",
                                                                    for: indexPath) as? ExcursionCollectionViewCell else {
            return UICollectionViewCell()
        }
//        let request = requestsArray[indexPath.row]
//        cell.excursionDateLabel.text = request.date
//        cell.excursionPriceLabel.text = "\(request.price)"
//        cell.museumNameLabel.text = "    " + request.museum.name
//        cell.museumImageView.image = nil
//        self.loadImage(from: request.museum.photoURL) { err, photo in
//            if err != nil {
//            } else {
//                if let photo = photo {
//                    DispatchQueue.main.async {
//                        cell.museumImageView.image = photo
//                    }
//                }
//            }
//        }
        
        return cell
        
    }
    
}

// MARK: - NoExcursionsViewDelegate
extension RequestsViewController: NoExcursionsViewDelegate {
    func userPressedCreationButton() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        appDel.openCreationScene(open: true)
    }
}

// MARK: - Error Handling
extension RequestsViewController {
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
