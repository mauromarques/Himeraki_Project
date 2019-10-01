//
//  kkkkkViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 29/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import UIKit

class fullArticleViewController: StatusBarAnimatableViewController, UITextViewDelegate {

    struct Constants {
        static let headerHeight: CGFloat = 404
    }
    
    var new: News?
    
    // MARK: - Properties
    var linkUrl = String()
    
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    
    var headerImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    var bottomContainer: UIView!
    var categoryLabel: UILabel!
    var titleLabel: UILabel!
    var textView: UITextView!
    var linkTextView: UITextView!
    var shadowContainer: UIView!
    var whiteGradientImageView: UIImageView!
    var estimatedSize: CGSize!
    var closeButton: UIButton!
    var weirdTriangle: UIImageView!
    
    let theText = "Park Bom (born March 24, 1984), previously known mononymously as Bom, is a South Korean singer. She is best known as a member of the South Korean girl group 2NE1. \n\nPark began her musical career in 2006, featuring on singles released by labelmates Big Bang, Lexy, and Masta Wu. In 2009, she made her debut as a member of 2NE1 as the main vocalist. Park has released two solo singles, You and I and Don't Cry, which reached number one on the Gaon Digital Chart, the national music chart of South Korea.[1] She was awarded Best Digital Single at the 2010 Mnet Asian Music Awards. \n\nFollowing 2NE1's disbandment in 2016, Park left her group's agency, YG Entertainment, in November 2016. In July 2018, she signed with D-Nation Entertainment and released her comeback single, Spring, in March 2019. "
    
    var viewModel: NewsViewModel?
    
    // MARK: - Drag to dismiss
    
    var draggingDownToDismiss = false
    
    final class DismissalPanGesture: UIPanGestureRecognizer {}
    final class DismissalScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer {}
    
    private lazy var dismissalPanGesture: DismissalPanGesture = {
        let pan = DismissalPanGesture()
        pan.maximumNumberOfTouches = 1
        return pan
    }()
    
    private lazy var dismissalScreenEdgePanGesture: DismissalScreenEdgePanGesture = {
        let pan = DismissalScreenEdgePanGesture()
        pan.edges = .left
        return pan
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let new = new else { return }
        
        weirdTriangle = createWeirdTriangle()
        closeButton = createCloseButton()
        linkTextView = createLinkTextView()
        whiteGradientImageView = createWhiteGradient()
        shadowContainer = createShadowContainer()
        textView = createTextView(textReceived: new.articleText ?? "Teste")
        categoryLabel = createCategoryLabel()
        titleLabel = createTitleLabel()
        bottomContainer = createBottomContainer()
        scrollView = createScrollView()
        headerContainerView = createHeaderContainerView()
        
        headerContainerView.addSubview(headerImageView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(shadowContainer)
        scrollView.addSubview(weirdTriangle)
        scrollView.addSubview(bottomContainer)
        bottomContainer.addSubview(categoryLabel)
        bottomContainer.addSubview(titleLabel)
        bottomContainer.addSubview(textView)
        bottomContainer.addSubview(linkTextView)
        view.addSubview(scrollView)
        view.addSubview(whiteGradientImageView)
        view.addSubview(closeButton)
        
        scrollView.layer.cornerRadius = 15
        
        arrangeConstraints()
        
        dismissalPanGesture.addTarget(self, action: #selector(handleDismissalPan(gesture:)))
        dismissalPanGesture.delegate = self
        
        dismissalScreenEdgePanGesture.addTarget(self, action: #selector(handleDismissalPan(gesture:)))
        dismissalScreenEdgePanGesture.delegate = self
        
        // Make drag down/scroll pan gesture waits til screen edge pan to fail first to begin
        dismissalPanGesture.require(toFail: dismissalScreenEdgePanGesture)
        scrollView.panGestureRecognizer.require(toFail: dismissalScreenEdgePanGesture)
        
        loadViewIfNeeded()
        view.addGestureRecognizer(dismissalPanGesture)
        view.addGestureRecognizer(dismissalScreenEdgePanGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let new = new else { return }
        
        titleLabel.text = new.title
        categoryLabel.text = new.topTitle

    }
    
    @objc func closeButtonPressed() {
        
        didSuccessfullyDragDownToDismiss()
    }
    
    func didSuccessfullyDragDownToDismiss() {
        dismiss(animated: true)
    }
    
    func userWillCancelDissmissalByDraggingToTop(velocityY: CGFloat) {}
    
    func didCancelDismissalTransition() {
        // Clean up
        interactiveStartingPoint = nil
        dismissalAnimator = nil
        draggingDownToDismiss = false
    }
    
    var interactiveStartingPoint: CGPoint?
    var dismissalAnimator: UIViewPropertyAnimator?
    
    // This handles both screen edge and dragdown pan. As screen edge pan is a subclass of pan gesture, this input param works.
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        
        let isScreenEdgePan = gesture.isKind(of: DismissalScreenEdgePanGesture.self)
        let canStartDragDownToDismissPan = !isScreenEdgePan && !draggingDownToDismiss
        
        // Don't do anything when it's not in the drag down mode
        if canStartDragDownToDismissPan { return }
        
        let targetAnimatedView = gesture.view!
        let startingPoint: CGPoint
        
        if let p = interactiveStartingPoint {
            startingPoint = p
        } else {
            // Initial location
            startingPoint = gesture.location(in: nil)
            interactiveStartingPoint = startingPoint
        }
        
        let currentLocation = gesture.location(in: nil)
        let progress = isScreenEdgePan ? (gesture.translation(in: targetAnimatedView).x / 100) : (currentLocation.y - startingPoint.y) / 100
        let targetShrinkScale: CGFloat = 0.86
        let targetCornerRadius: CGFloat = GlobalConstants.cardCornerRadius
        
        func createInteractiveDismissalAnimatorIfNeeded() -> UIViewPropertyAnimator {
            if let animator = dismissalAnimator {
                return animator
            } else {
                let animator = UIViewPropertyAnimator(duration: 0, curve: .linear, animations: {
                    targetAnimatedView.transform = .init(scaleX: targetShrinkScale, y: targetShrinkScale)
                    targetAnimatedView.layer.cornerRadius = targetCornerRadius
                })
                animator.isReversed = false
                animator.pauseAnimation()
                animator.fractionComplete = progress
                return animator
            }
        }
        
        switch gesture.state {
        case .began:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()
            
        case .changed:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()
            
            let actualProgress = progress
            let isDismissalSuccess = actualProgress >= 1.0
            
            dismissalAnimator!.fractionComplete = actualProgress
            
            if isDismissalSuccess {
                dismissalAnimator!.stopAnimation(false)
                dismissalAnimator!.addCompletion { [unowned self] (pos) in
                    switch pos {
                    case .end:
                        self.didSuccessfullyDragDownToDismiss()
                    default:
                        fatalError("Must finish dismissal at end!")
                    }
                }
                dismissalAnimator!.finishAnimation(at: .end)
            }
            
        case .ended, .cancelled:
            if dismissalAnimator == nil {
                // Gesture's too quick that it doesn't have dismissalAnimator!
                print("Too quick there's no animator!")
                didCancelDismissalTransition()
                return
            }
            // NOTE:
            // If user lift fingers -> ended
            // If gesture.isEnabled -> cancelled
            
            // Ended, Animate back to start
            dismissalAnimator!.pauseAnimation()
            dismissalAnimator!.isReversed = true
            
            // Disable gesture until reverse closing animation finishes.
            gesture.isEnabled = false
            dismissalAnimator!.addCompletion { [unowned self] (pos) in
                self.didCancelDismissalTransition()
                gesture.isEnabled = true
            }
            dismissalAnimator!.startAnimation()
        default:
            fatalError("Impossible gesture state? \(gesture.state.rawValue)")
        }
    }
}

extension fullArticleViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension fullArticleViewController {
    
    internal func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL.absoluteString == linkUrl) {
            UIApplication.shared.open(URL)
        }
        return false
    }
    
}

extension fullArticleViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < 0.0 {
//            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
//        } else {
//            let parallaxFactor: CGFloat = 0.25
//            let offsetY = scrollView.contentOffset.y * parallaxFactor
//            let minOffsetY: CGFloat = 8.0
//            let availableOffset = min(offsetY, minOffsetY)
//            let contentRectOffsetY = availableOffset / Constants.headerHeight
//            headerTopConstraint?.constant = view.frame.origin.y
//            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
//            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if draggingDownToDismiss || (scrollView.isTracking && scrollView.contentOffset.y < 0) {
            draggingDownToDismiss = true
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            scrollView.contentOffset = .zero
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
        
        scrollView.showsVerticalScrollIndicator = !draggingDownToDismiss
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Without this, when user drag down and lift the finger fast at the top, there'll be some scrolling going on.
        // This check prevents that.
        if velocity.y > 0 && scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = .zero
        }
    }
}

