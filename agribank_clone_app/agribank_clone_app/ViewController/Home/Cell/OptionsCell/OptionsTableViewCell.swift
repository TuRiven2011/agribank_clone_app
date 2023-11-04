//
//  OptionsTableViewCell.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 11/10/2023.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let financeData : [FinanceEntity] = [.init(title: "Chuyển khoản", image: "ic48PxChuyenkhoan_Normal"), .init(title: "Nạp tiền điện thoại", image: "ic48PxDanhbanaptien_Normal"), .init(title: "Thanh toán hoá đơn", image: "ic48PxThanhtoanhoadon_Normal"), .init(title: "Mã thẻ/Data", image: "ic48PxMuamathe_Normal"), .init(title: "Tiền gửi trực tuyến", image: "ic48PxTienguitructuyen_Normal"), .init(title: "Chứng khoán", image: "ic48PxNaptienchungkhoan_Normal"), .init(title: "Nạp tiền dịch vụ", image: "ic48PxNaptiendichvu_Normal"), .init(title: "Lì xì", image: "ic48PxLixiTet_Normal"), .init(title: "Nhận tiền kiều hối", image: "ic48PxNhantienkieuhoi_Normal"), .init(title: "Trả nợ tiền vay", image: "ic48PxTranotienvay_Normal"), .init(title: "Bạn bè", image: "ic48PxBanbe_Normal"), .init(title: "Bảo hiểm Agribank Abic", image: "ic48PxMuabaohiemabic_Normal")]
    
    let shoppingData : [FinanceEntity] = [.init(title: "Vé máy bay", image: "ic48PxVemaybay_Normal"), .init(title: "Mua sắm VnShop", image: "ic48PxMuasamtructuyen_Normal"), .init(title: "Gọi Taxi", image: "ic48PxTaxi_Normal"), .init(title: "Vé tàu hoả", image: "ic48Datvetau_Normal"), .init(title: "Vé xe", image: "ic48PxDatvexe_Normal"), .init(title: "Vé xem phim", image: "ic48PxVexemphim_Normal"), .init(title: "Đặt hoa", image: "ic48PxDathoa_Normal"), .init(title: "Đặt phòng khách sạn", image: "ic48PxDatphongkhachsan_Normal"), .init(title: "Đặt sân Golf", image: "ic48PxGolf_Normal"), .init(title: "Giao hàng", image: "ic48PxGiaohang_Normal")]
    
    let utilitiesData : [FinanceEntity] = [.init(title: "Cài đặt Soft OTP", image: "ic48PxSoftotp_Normal"), .init(title: "Cài đặt Face ID", image: "ic24PxFaceid_Normal"), .init(title: "Cài đặt hạn mức", image: "ic48PxCaidathanmuc_Normal"), .init(title: "Nhận tin biến động số dư", image: "ic48PxBdsd_Normal"), .init(title: "Cài đặt tài khoản", image: "ic48PxCaidattaikhoan_Normal"), .init(title: "Cài đặt mật khẩu", image: "ic48PxDoimatkhau_Normal"), .init(title: "Quản lý danh bạ", image: "ic48PxQuanlydanhba_Normal"), .init(title: "Thông tin ứng dụng", image: "ic48PxThongtinungdung_Normal"), .init(title: "Tra cứu thông tin", image: "ic48PxThongtinungdung_Normal"), .init(title: "Tìm kiếm địa điểm", image: "ic48PxSes_Normal")]
    
    var tapTransferCompletion: (() -> Void)?

    @IBOutlet weak var financeCollectionView: UICollectionView!
    
    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    
    @IBOutlet weak var utilitiesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    func configCollectionView() {
        financeCollectionView.register(.init(nibName: "HomeCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCollectionViewCell")
        
        shoppingCollectionView.register(.init(nibName: "HomeCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCollectionViewCell")
        
        utilitiesCollectionView.register(.init(nibName: "HomeCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCustomCollectionViewCell")
        
        financeCollectionView.delegate = self
        financeCollectionView.dataSource = self
        
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        
        utilitiesCollectionView.delegate = self
        utilitiesCollectionView.dataSource = self
    }

    
}

extension OptionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == financeCollectionView {
           return financeData.count
        }
        
        if collectionView == shoppingCollectionView {
            return shoppingData.count
        }
        
        return utilitiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCustomCollectionViewCell", for: indexPath) as? HomeCustomCollectionViewCell else {return UICollectionViewCell()}
        if collectionView == financeCollectionView {
            cell.binding(financeData[indexPath.row].title, image: financeData[indexPath.row].image)
        } else if collectionView == shoppingCollectionView {
            cell.binding(shoppingData[indexPath.row].title, image: shoppingData[indexPath.row].image)
        } else {
            cell.binding(utilitiesData[indexPath.row].title, image: utilitiesData[indexPath.row].image)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3
        return CGSize(width: size, height: size - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == financeCollectionView {
            if indexPath.row == 0 {
                tapTransferCompletion?()
            }
        }
    }
    
    
    
}
