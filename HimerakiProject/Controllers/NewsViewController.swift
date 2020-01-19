//
//  NewsViewController.swift
//  HimerakiProject
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

enum CellIdentifierMode {
    case cellType
    case cellHeight
}

class NewsViewController: StatusBarAnimatableViewController, UICollectionViewDelegateFlowLayout, AddNewDataDelegate {
    
    let viewModel = NewsViewModel()
    
    let refreshControl = UIRefreshControl()
    
    var collectionView: UICollectionView!
    
    var isFirstLaunchForThisController = true
        
    lazy var secretButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(#imageLiteral(resourceName: "+"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.constrainHeight(constant: 30)
        button.constrainWidth(constant: 30)
        button.addTarget(self, action: #selector(presentSecretController), for: .touchUpInside)
        return button
    }()
    
    private var transition: CardTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstLaunchForThisController {
            shouldCurrentlyHideStatusBar = false
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        // Make it responds to highlight state faster
        collectionView.delaysContentTouches = false
        
        collectionView.clipsToBounds = false
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = viewModel
        collectionView.delegate = self
        
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: ChallengeCell.identifier)
        collectionView.register(FeaturedArtistCell.self, forCellWithReuseIdentifier: FeaturedArtistCell.identifier)
        collectionView.register(SupplyReviewCell.self, forCellWithReuseIdentifier: SupplyReviewCell.identifier)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.register(TipsAndTricksCell.self, forCellWithReuseIdentifier: TipsAndTricksCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        self.viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(title: "Error", message: String(describing: error), dismissButtonTitle: "Ok")
            self.refreshControl.endRefreshing()
        }
        
        self.viewModel.onChange = {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self.viewModel, action: #selector(NewsViewModel.refresh), for: .valueChanged)
        
        self.viewModel.refresh()
        
        if UserDefaults.standard.bool(forKey: "isAuthor") {
            navigationController?.navigationBar.tintColor = .purple
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: secretButton)
        }
    }
    
    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
        return StatusBarAnimatableConfig(prefersHidden: false,
                                         animation: .slide)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = viewModel.items[indexPath.section]
        
        var cell: BaseNewsCell
        
        // Get tapped cell location
//        switch item.type {
//        case .challenge:
//            cell = collectionView.cellForItem(at: indexPath) as! ChallengeCell
//        case .featuredArtist:
//            cell = collectionView.cellForItem(at: indexPath) as! FeaturedArtistCell
//        case .supplyReview:
//            cell = collectionView.cellForItem(at: indexPath) as! SupplyReviewCell
//        case .article:
//            cell = collectionView.cellForItem(at: indexPath) as! ArticleCell
//        case .tipsAndTricks:
//            cell = collectionView.cellForItem(at: indexPath) as! TipsAndTricksCell
//        }
        
        cell = identifyCellType(basedOn: item, forMode: .cellType, indexPath: indexPath)
        
        // Freeze highlighted state (or else it will bounce back)
        cell.freezeAnimations()
        
        // Get current frame on screen
        let currentCellFrame = cell.layer.presentation()!.frame
        
        // Convert current frame to screen's coordinates
        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)
        
        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()
        
        let vc = fullArticleViewController()
        vc.new = item.new
        
        guard let imageLoaded = cell.imageView.image else { return }
        vc.headerImageView.image = resizeImage(imageLoaded)
        
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell)
        transition = CardTransition(params: params)
        vc.transitioningDelegate = transition
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: { [unowned cell] in
            // Unfreeze
            cell.unfreezeAnimations()
        })
    }
    
    func resizeImage(_ image: UIImage) -> UIImage {
        let scaledImage = image.resize(toWidth: image.size.width * GlobalConstants.cardHighlightedFactor)
        return scaledImage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = viewModel.items[indexPath.section]
        var size: CGSize
//        var size = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
//
//        switch item.type {
//        case .challenge:
//            size.height = 187
//            return size
//        case .featuredArtist:
//            size.height = 412
//            return size
//        case .supplyReview:
//            size.height = 326
//            return size
//        case .article:
//            size.height = 380
//            return size
//        case .tipsAndTricks:
//            size.height = 206
//            return size
//        }
        size = identifyCellType(basedOn: item, forMode: .cellHeight, indexPath: indexPath)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = true
    }
    
    func identifyCellType<T>(basedOn item: NewsViewModelItem, forMode mode: CellIdentifierMode, indexPath: IndexPath) -> T {
        
        var cell: BaseNewsCell?
        var size = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)

        var onCellMode = false
        if mode == .cellType {
            onCellMode = true
        }
        
        switch item.type {
        case .challenge:
            cell = onCellMode ? collectionView.cellForItem(at: indexPath) as? ChallengeCell : nil
            size.height = 187
        case .featuredArtist:
            cell = onCellMode ? collectionView.cellForItem(at: indexPath) as? FeaturedArtistCell : nil
            size.height = 412
        case .supplyReview:
            cell = onCellMode ? collectionView.cellForItem(at: indexPath) as? SupplyReviewCell : nil
            size.height = 326
        case .article:
            cell = onCellMode ? collectionView.cellForItem(at: indexPath) as? ArticleCell : nil
            size.height = 380
        case .tipsAndTricks:
            cell = onCellMode ? collectionView.cellForItem(at: indexPath) as? TipsAndTricksCell : nil
            size.height = 206
        }
        
        if mode == .cellType {
            return cell as! T
        } else {
            return size as! T
        }
    }
    
    @objc func presentSecretController() {
        let secretController = SecretController()
        secretController.newDataDelegate = self
        secretController.modalPresentationStyle = .fullScreen
        self.present(secretController, animated: true)
    }
    
    // MARK: - Secret Controller Delegate
    
    func prepareForDatabase(with object: News?) {
        guard let newType = object else {
            self.showAlert(title: "Ops", message: "An error occurred, please try again", dismissButtonTitle: "Okay")
            return
        }
        self.viewModel.delete(deletedNew: newType)
        self.viewModel.addNews(addedNew: newType)
    }
}

