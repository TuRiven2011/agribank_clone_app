//
//  SearchFeatureViewController.swift
//  agribank_clone_app
//
//  Created by Phạm Bá Tú on 09/11/2023.
//

import UIKit

class SearchFeatureViewController: UIViewController {
    
    @IBOutlet weak var suggestCollectionView: UICollectionView!
    
    weak var header: SuggestHeader?
    
    var suggestData = ["Chuyển khoản", "Thanh toán hoá đơn", "Nhận tin biến động số dư", "Cài đặt Soft OTP"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        suggestCollectionView.collectionViewLayout = generateLayout()
        suggestCollectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    private func setup() {
        
        suggestCollectionView.register(.init(nibName: "SearchFeatureCollectionViewCell",
                                             bundle: nil), forCellWithReuseIdentifier: "SearchFeatureCollectionViewCell")
        suggestCollectionView.register(.init(nibName: "SuggestHeader",
                                             bundle: nil),
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                       withReuseIdentifier: "SuggestHeader")
        suggestCollectionView.register(.init(nibName: "SuggestFooter",
                                             bundle: nil),
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                       withReuseIdentifier: "SuggestFooter")
        suggestCollectionView.dataSource = self
        suggestCollectionView.delegate = self
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 18
        layout.headerReferenceSize = .init(width: view.bounds.width, height: 70)
        layout.footerReferenceSize = .init(width: view.bounds.width, height: 70)
        return layout
    }
    
    private func setupNavigationBar() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .white
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            
        } else {
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.subviews.forEach({$0.removeFromSuperview()})
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UILabel()
        back.text = "Đóng"
        back.textColor = .init(rgb: 0xffDC8630)
        back.isUserInteractionEnabled = true
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(textField)
        
        navigationController?.navigationBar.addSubview(back)
        if let navigationBar = navigationController?.navigationBar {
            [
                back.widthAnchor.constraint(equalToConstant: 50),
                back.heightAnchor.constraint(equalToConstant: 30),
                back.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -10),
                back.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            ].forEach({$0.isActive = true})
        }
        
        let backButtonItem = UIBarButtonItem(customView: back)
        navigationController?.navigationItem.rightBarButtonItem = backButtonItem
        
        if let navigationBar = navigationController?.navigationBar {
            [
                textField.heightAnchor.constraint(equalToConstant: 36),
                textField.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
                textField.trailingAnchor.constraint(equalTo: back.leadingAnchor, constant: -10),
                textField.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            ].forEach({$0.isActive = true})
        }
        textField.layer.cornerRadius = 18
        textField.layer.masksToBounds = true
        let leftButton = UIBarButtonItem(customView: textField)
        navigationController?.navigationItem.leftBarButtonItem = leftButton
    }
    
}

extension SearchFeatureViewController {
    @objc func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchFeatureViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFeatureCollectionViewCell", for: indexPath) as? SearchFeatureCollectionViewCell else {return .init()}
        cell.binding(suggest: suggestData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: .zero)
        label.text = suggestData[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.bounds.width + 20, height: label.frame.height + 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SuggestHeader", for: indexPath)
            // Configure header view .....
            return headerView
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SuggestFooter", for: indexPath)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing + 20
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
