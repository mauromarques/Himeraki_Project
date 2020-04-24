//
//  SecretController.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 19/01/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

protocol AddNewDataDelegate: class {
    func prepareForDatabase(with object: News?)
}

class SecretController: UIViewController {

    weak var newDataDelegate: AddNewDataDelegate?
    
    let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.backgroundColor = .white
        return sView
    }()
    
    private let unselectedType = "Select Type"
    
    private lazy var newsTypes = [NewsViewModelItemType.article.description,
                     NewsViewModelItemType.supplyReview.description,
                     unselectedType,
                     NewsViewModelItemType.tipsAndTricks.description,
                     NewsViewModelItemType.challenge.description,
                     NewsViewModelItemType.featuredArtist.description]
    
    var selectedType = String()
    var indexForOrder = Int()
    
    lazy var newTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    let orderText = UITextView()
    let topTitleText = UITextView()
    let mainTitleText = UITextView()
    let subTitleText = UITextView()
    let articleText = UITextView()
    let pictureLink = UITextView()
    let artistName = UITextView()
    let instaLink = UITextView()
    let photographerText = UITextView()
    let publisherText = UITextView()
    
    var inputFields = [UIView]()
    var inputTitles = [String]()
    var verticalStack: VerticalStackView!
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.backgroundColor = .mediumPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: UIFont.Weight.bold)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .mediumPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: UIFont.Weight.bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKey()

        inputFields = [orderText, topTitleText, mainTitleText, subTitleText, articleText, publisherText, pictureLink, photographerText, artistName, instaLink]
        inputTitles = ["Order - 0 to 4", "Top Title", "Main Title", "Subtitle", "Article Text", "Publisher", "Picture Link", "Photographer", "Artist Name", "Insta Link"]
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .lightPink
        scrollView.fillSuperview()
        
        scrollView.addSubview(exitButton)
        exitButton.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 50))
        exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        
        scrollView.addSubview(newTypePicker)
        newTypePicker.selectRow(2, inComponent: 0, animated: false)
        newTypePicker.anchor(top: exitButton.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        createInputSubviews(in: scrollView, withFields: inputFields)
        
        scrollView.addSubview(doneButton)
        doneButton.anchor(top: verticalStack.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 30, right: 16), size: CGSize(width: 0, height: 50))
        doneButton.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.scrollView.contentSize = self.scrollView.subviews.reduce(CGRect.zero, {
            return $0.union($1.frame)
        }).size
        
        self.scrollView.contentSize.height = self.scrollView.contentSize.height + 300
    }
    
    @objc func didTapDone() {
        
        var addedNew = News()
        
        let orderString = orderText.text
        addedNew.order = orderString ?? "0"
        addedNew.topTitle = topTitleText.text
        addedNew.title = mainTitleText.text
        addedNew.subtitle = subTitleText.text
        addedNew.articleText = articleText.text
        addedNew.pictureUrl = pictureLink.text
        addedNew.instaLink = instaLink.text
        addedNew.artistName = artistName.text
        addedNew.publisher = publisherText.text
        addedNew.photoCredits = photographerText.text
        
        if selectedType.isEmpty || selectedType == unselectedType {
            // TODO Show error
        } else {
            addedNew.type = selectedType
            newDataDelegate?.prepareForDatabase(with: addedNew)
            self.dismiss(animated: true)
        }
        
    }
    
    @objc func didTapExit() {
        self.dismiss(animated: true)
    }
    
    func createInputSubviews(in view: UIView, withFields fields: [UIView]) {
        
        let width = UIScreen.main.bounds.width - 32
        verticalStack = VerticalStackView(arrangedSubviews: [], spacing: 15)
        
        for i in 0...fields.count - 1 {
            let label = UILabel()
            label.textColor = UIColor.init(red: 234, green: 97, blue: 149)
            label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFont.Weight.bold)
            label.constrainHeight(constant: 40)
            label.text = inputTitles[i]
            
            verticalStack.addArrangedSubview(label)
            verticalStack.addArrangedSubview(inputFields[i])
        }
        
        [topTitleText, mainTitleText, subTitleText].forEach({
            $0.constrainHeight(constant: 80)
            $0.constrainWidth(constant: width)
            $0.layer.cornerRadius = 10
        })
        
        articleText.constrainWidth(constant: width)
        articleText.constrainHeight(constant: 320)
        articleText.layer.cornerRadius = 10
        
        [orderText ,pictureLink, artistName, instaLink, photographerText, publisherText].forEach({
            $0.constrainHeight(constant: 60)
            $0.constrainWidth(constant: width)
            $0.layer.cornerRadius = 10
        })
        
        
        view.addSubview(verticalStack)
        verticalStack.anchor(top: newTypePicker.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: -40, left: 16, bottom: 0, right: 16))
    }
}

extension SecretController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newsTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return newsTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = newsTypes[row]
    }
}

