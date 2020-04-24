//
//  webViewController.swift
//  HimerakiProject
//
//  Created by Mauro Canhao on 12/03/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    var closeButton = UIButton()
    var whiteBlockForButtons = UIView()
    var bottomBorder = UIView()
    var openInSafariButton = UIButton()
    var dragBar = UIView()
    
    let webView : WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsLinkPreview = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton = createCloseButton()
        openInSafariButton = createOpenInSafariButton()
//        bottomBorder = createBottomBorder()
        dragBar = createDragBar()
        whiteBlockForButtons = createWhiteBlock()
        
        setupConstraints()

        
        UrlRequest(URL: urlForWebView ?? URL(string: "www.google.com")!)

        
    }

    func setupConstraints (){
        view.addSubview(whiteBlockForButtons)
        whiteBlockForButtons.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 72))
        
        whiteBlockForButtons.addSubview(closeButton)
             closeButton.anchor(top: whiteBlockForButtons.topAnchor, leading: nil, bottom: nil, trailing: whiteBlockForButtons.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 20), size: CGSize(width: 32, height: 32))
        
        whiteBlockForButtons.addSubview(openInSafariButton)
        openInSafariButton.anchor(top: whiteBlockForButtons.topAnchor, leading: whiteBlockForButtons.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 0))
        
//        whiteBlockForButtons.addSubview(bottomBorder)
//            bottomBorder.anchor(top: whiteBlockForButtons.bottomAnchor, leading: whiteBlockForButtons.leadingAnchor, bottom: nil, trailing: whiteBlockForButtons.trailingAnchor, size: CGSize(width: 0, height: 1))
        
        whiteBlockForButtons.addSubview(dragBar)
        dragBar.anchor(top: whiteBlockForButtons.topAnchor, leading: whiteBlockForButtons.leadingAnchor, bottom: nil, trailing: whiteBlockForButtons.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 100, bottom: 0, right: 100), size: CGSize(width: 100, height: 5))
        
        webViewConstraint()
    }
    
    func webViewConstraint(){
        view.addSubview(webView)
        webView.anchor(top: whiteBlockForButtons.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    func UrlRequest(URL: URL){
        let websiteRequest = URLRequest(url: URL)
        
        webView.load(websiteRequest)
    }
    
    func createCloseButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 32, height: 32))
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named:"x"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }
    
    func createOpenInSafariButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.contentMode = .center
        button.setTitleColor(UIColor.init(red: 123, green: 43, blue: 74), for: .normal)
        button.setTitle("Open in Safari", for: .normal)
        button.addTarget(self, action: #selector(openInSafariButtonPressed), for: .touchUpInside)
        return button
    }
    
    func createWhiteBlock() -> UIView {
        let block = UIView()
        block.translatesAutoresizingMaskIntoConstraints = false
        block.clipsToBounds = false
        block.backgroundColor = .white
        return block
    }
    
    func createBottomBorder() -> UIView {
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = .lightGray
        return bottomBorder
    }
    
    func createDragBar() -> UIView {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.layer.cornerRadius = 3
        bar.backgroundColor = .lightGray
        bar.alpha = 0.5
        return bar
    }
    
    @objc func closeButtonPressed() {
        print("close button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func openInSafariButtonPressed() {
        guard let url = urlForWebView else { return }
        UIApplication.shared.open(url)
    }
    
}
