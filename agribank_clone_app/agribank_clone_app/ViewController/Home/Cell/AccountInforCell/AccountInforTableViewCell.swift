import UIKit

class AccountInforTableViewCell: UITableViewCell {

    @IBOutlet weak var accountInforView: UIView!
    @IBOutlet weak var cardServiceView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var tapCardServiceCompletion: (() -> Void)?
    var accountInforCompletion: (() -> Void)?
    
    let data: [String] = ["HienDai2_Normal", "group17878_Normal", "group6243_Normal" , "HienDai3_Normal", "HienDai4_Normal"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configGesture()
        configCollectionView()
        configPageControl()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configGesture() {
        cardServiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardService)))
        accountInforView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAccountInfor)))
    }
    
    func configCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(.init(nibName: "PageControlCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageControlCollectionViewCell")
    }
    
    func configPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = data.count
    }
    
}

extension AccountInforTableViewCell {
    @objc func handleCardService() {
        tapCardServiceCompletion?()
    }
    
    @objc func handleAccountInfor() {
        accountInforCompletion?()
    }
}

extension AccountInforTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageControlCollectionViewCell", for: indexPath) as? PageControlCollectionViewCell else {return UICollectionViewCell()}
        if let image = UIImage(named: data[indexPath.row]) {
            cell.binding(image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
}
