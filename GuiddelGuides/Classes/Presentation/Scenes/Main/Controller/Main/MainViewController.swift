//
//  MainViewController.swift
//  Guiddel
//
//  Created by Anton Danilov on 30.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 20
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

class MainViewController: UIViewController {
    
    // MARK: - IBOtlets
    @IBOutlet weak var excursionsTableView: UITableView!
    
    // MARK: - Private properties
    private var handle: AuthStateDidChangeListenerHandle?
    private var nullView: UIView!
    private let rightButton = UIButton()
    private var excursionsArray: [Excursion] = [] {
        didSet {
            if excursionsArray.count == 0 {
                changeNullView(show: true)
            } else {
                changeNullView(show: false)
            }
            excursionsTableView.reloadData()
        }
    }
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else { return }
            AuthManager.shared.updateCurrentUser(with: user)
        }
        setupCreationBarButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
        removeCreationBarButton()
        
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let excursionDetailesVC = segue.destination as? ExcursionDetailsViewController,
            let index = excursionsTableView.indexPathForSelectedRow,
            let cell = excursionsTableView.cellForRow(at: index) as? OpenExcursionTableViewCell {
            let excursionVM = ExcursionViewModel(excursion: excursionsArray[index.row])
                let image = cell.excursionImageView.image
                excursionDetailesVC.setData(excursionVM: excursionVM, image: image)
            
        } else if let sideMenuNavigationController = segue.destination as? SideMenuNavigationController {
            sideMenuNavigationController.settings = setupSideMenu()
            sideMenuNavigationController.navigationBar.prefersLargeTitles = true
        }
    }
    
    // MARK: Public Methods
    @IBAction func rightButtonTapped(_ sender: UIBarButtonItem) {
        openCreationScene()
    }
    
    // MARK: - Private Methods
    private func setup() {
        excursionsTableView.register(
            UINib(nibName: "OpenExcursionTableViewCell", bundle: nil),
            forCellReuseIdentifier: "excursionCell")
        ExcursionFirestoreManager.shared.get { err, excursions in
            if let err = err {
                self.showErrorAlert(message: err.localizedDescription)
            } else if let excursionsArray = excursions {
                self.excursionsArray = excursionsArray
            }
        }
        self.navigationController!.navigationBar
            .largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont.getOswald(.regular, size: 34)]
        setupNullView()
    }
    //
    //    private func setLayout() {
    //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //        layout.itemSize.width = self.view.frame.size.width - 30
    //        layout.itemSize.height = 250
    //        layout.minimumInteritemSpacing = 10
    //        layout.scrollDirection = .vertical
    //        layout.minimumLineSpacing = 20
    //        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    //        excursionsTableView.collectionViewLayout = layout
    //    }
    
    
    // MARK: Null View Setup
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
    
    // MARK: Side Menu Setup
    private func setupSideMenu() -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.viewSlideOutMenuPartialIn
        presentationStyle.presentingEndAlpha = 0.9
        //        presentationStyle.onTopShadowOpacity = 0.5
        //        presentationStyle.onTopShadowRadius = 5
        //        presentationStyle.onTopShadowColor = .black
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = view.frame.width * 0.5
        settings.statusBarEndAlpha = 0
        
        return settings
    }
    
    private func initialiseSideMenu() {
        let menuLeftNavigationController = storyboard?
            .instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    // MARK: Bar Button Setup
    private func setupCreationBarButton() {
        let rightButton = RoundCornersButton()
        //        rightButton.setTitle("", for: .normal)
        rightButton.setTitleColor(.white, for: .normal)
        if let image = UIImage(systemName: "plus") {
            rightButton.setImage(image, for: .normal)
            rightButton.tintColor = .white
        }
        rightButton.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.2352941185, blue: 1, alpha: 1)
        rightButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
        rightButton.tag = 1
        rightButton.showsTouchWhenHighlighted = false
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(rightButton)
        rightButton.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        rightButton.clipsToBounds = true
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                               constant: -Const.ImageRightMargin),
            rightButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                constant: -Const.ImageBottomMarginForLargeState),
            rightButton.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor)
        ])
        
    }
    

    
    private func moveAndResizeCreationButton(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        rightButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    private func removeCreationBarButton() {
        guard let subviews = self.navigationController?.navigationBar.subviews else { return }
        for view in subviews
            where view.tag == 1 {
                view.removeFromSuperview()
        }
    }
    
    private func openCreationScene() {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        appDel.openCreationScene(open: true)
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excursionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = excursionsTableView
            .dequeueReusableCell(withIdentifier: "excursionCell", for: indexPath) as? OpenExcursionTableViewCell else {
                return UITableViewCell()
        }
        cell.selectionStyle = .none
        let excursion = excursionsArray[indexPath.row]
        cell.setData(excursionVM: OpenExcursionViewModel(excursion: excursion))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showExcursionSetailsVC", sender: self)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        80
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeCreationButton(for: height)
    }
    

}

// MARK: - NoExcursionsViewDelegate
extension MainViewController: NoExcursionsViewDelegate {
    func userPressedCreationButton() {
        openCreationScene()
    }
}

// MARK: - Error Handling
extension MainViewController {
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
