

import UIKit

class CardServiceViewController: BaseViewController {
    
    @IBOutlet weak var cardServiceCollectionView: UICollectionView!
    
    let data: [TransferEntity] = [.init(title: "Truy vấn thông tin thẻ", image: "ic48PxTruyvanthe_Normal"), .init(title: "CK liên NH qua số tài khoản", image: "ic48PxCKlienNHquaStk_Normal"), .init(title: "CK liên NH qua số thẻ", image: "ic48PxCKlienNHquasothe_Normal"), .init(title: "Phát hành thẻ vật lý", image: "ic48PxPhathanhthemoi_Normal"), .init(title: "Phát hành thẻ phi vật lý", image: "ic48PxThephivatly_Normal"), .init(title: "Thanh toán thẻ tín dụng", image: "ic48PxThanhtoanthetindung_Normal"), .init(title: "Kích hoạt thẻ", image: "ic48PxKichhoatthe_Normal"), .init(title: "Cấp/Đổi mã PIN", image: "ic48PxSoftotp_Normal"), .init(title: "Khoá/Mở khoá thẻ", image: "ic48PxKhoathe_Normal"), .init(title: "Chuyển đổi sang thẻ chip", image: "ic48PxChuyendoithechip_Normal"), .init(title: "Định danh thẻ", image: "ic48PxDinhdanhthe_Normal")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Dịch vụ thẻ")
    }
    
    func configCollectionView() {
        cardServiceCollectionView.register(.init(nibName: "TransferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransferCollectionViewCell")
        cardServiceCollectionView.delegate = self
        cardServiceCollectionView.dataSource = self
        
    }
}

extension CardServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransferCollectionViewCell", for: indexPath) as? TransferCollectionViewCell else {return UICollectionViewCell()}
        cell.titleLbl.font = UIFont.systemFont(ofSize: 13.5)
        cell.binding(data[indexPath.row].title, data[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 16)/3
        return CGSize(width: size, height: size)
    }
    
}
