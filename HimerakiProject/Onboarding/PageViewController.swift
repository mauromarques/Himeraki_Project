//
//  PageViewController.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 27/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

public class PageViewController: UIPageViewController {
    public typealias TransitionObserver = ((TransitionState) -> Void)
    
    public enum TransitionState {
        case began
        case completed
        case cancelled
    }
        
    private var pages: [UIViewController] = []
    private var pageControlIndex = 0
    
    public convenience init(pages: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.alpha = 0.0
        dataSource = self

        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.4) {
            self.view.alpha = 1.0
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.backgroundColor = .white
        for subView in view.subviews {
            // Extend scroll view bounds to get rid of black bar.
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
            // Change page control 'y' position
            if subView is UIPageControl {
                subView.frame.origin.y = self.view.frame.size.height - 155
                
                if let pageControl = subView as? UIPageControl {
                    pageControl.pageIndicatorTintColor = .gray
                    pageControl.currentPageIndicatorTintColor = .black
                }
            }
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }

        return pages[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return nil }

        return pages[nextIndex]
    }

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageControlIndex
    }
}

extension PageViewController: OnboardingChildViewControllerDelegate {
    
    func skipPresentation() {
        self.dismiss(animated: true)
    }
    
    func goToNextPage(controller: UIViewController) {
        guard let viewControllerIndex = pages.firstIndex(of: controller) else { return }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else {
            self.dismiss(animated: true)
            return
        }
        
        let nextController = pages[nextIndex]
        pageControlIndex = nextIndex
        setViewControllers([nextController], direction: .forward, animated: true)
    }
}
