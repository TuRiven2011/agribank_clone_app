//
//  SettingsViewController.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 13/10/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsCollectionView: UICollectionView!
    
    let data: [SettingsEntity] = [.init(title: "Cài đặt Soft OTP", image: "ic24PxSoftotp_Normal"), .init(title: "Nhận tin biến động số dư", image: "ic24PxCaidatbdsd_Normal"), .init(title: "Cài đặt Face ID", image: "ic24PxSoftotp_Normal"), .init(title: "Cài đặt hạn mức", image: "ic24PxHanmuc_Normal"), .init(title: "Cài đặt ngôn ngữ", image: "ic24PxLanguage_Normal"), .init(title: "Cài đặt mật khẩu", image: "ic24PxPassword_Normal"), .init(title: "Cấp/Đổi mã PIN", image: "ic24PxKey_Normal"), .init(title: "Quản lý danh bạ", image: "ic24PxContact_Normal"), .init(title: "Thông tin ứng dụng", image: "ic24PxInfo_Normal"), .init(title: "Đóng tài khoản", image: "ic24PxDongtaikhoan_Normal"), .init(title: "Hỏi và đáp", image: "ic24PxSoftotp_Normal"), .init(title: "Điều khoản riêng tư", image: "ic24PxsDkrt_Normal")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        // Do any additional setup after loading the view.
    }

    func configCollectionView() {
        settingsCollectionView.register(.init(nibName: "SettingsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SettingsCollectionViewCell")
        
        settingsCollectionView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
    }

}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCollectionViewCell", for: indexPath) as? SettingsCollectionViewCell else {return UICollectionViewCell()}
        
        cell.biding(data[indexPath.row].title, image: data[indexPath.row].image)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
    
}
