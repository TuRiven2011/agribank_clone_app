//
//  OptionsTableViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 11/10/2023.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let data : [FinanceEntity] = [.init(title: "Chuyển khoản", image: "ic48PxChuyenkhoan_Normal"), .init(title: "Nạp tiền điện thoại", image: "ic48PxDanhbanaptien_Normal"), .init(title: "Thanh toán hoá đơn", image: "ic48PxThanhtoanhoadon_Normal"), .init(title: "Mã thẻ/Data", image: "ic48PxMuamathe_Normal"), .init(title: "Tiền gửi trực tuyến", image: "ic48PxTienguitructuyen_Normal"), .init(title: "Chứng khoán", image: "ic48PxNaptienchungkhoan_Normal"), .init(title: "Nạp tiền dịch vụ", image: "ic48PxNaptiendichvu_Normal"), .init(title: "Lì xì", image: "ic48PxLixiTet_Normal"), .init(title: "Nhận tiền kiều hối", image: "ic48PxNhantienkieuhoi_Normal"), .init(title: "Trả nợ tiền vay", image: "ic48PxTranotienvay_Normal"), .init(title: "Bạn bè", image: "ic48PxBanbe_Normal"), .init(title: "Bảo hiểm Agribank Abic", image: "ic48PxMuabaohiemabic_Normal")]

    @IBOutlet weak var financeCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    func configCollectionView() {
        financeCollectionView.register(.init(nibName: "HomeCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCollectionViewCell")
        
        financeCollectionView.delegate = self
        financeCollectionView.dataSource = self
    }

    
}

extension OptionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCustomCollectionViewCell", for: indexPath) as? HomeCustomCollectionViewCell else {return UICollectionViewCell()}

        cell.binding(data[indexPath.row].title, image: data[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3
        return CGSize(width: size, height: size - 20)
    }
    
    
    
}
