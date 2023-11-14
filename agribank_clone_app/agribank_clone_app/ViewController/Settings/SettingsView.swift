//
//  SettingsView.swift
//  agribank_clone_app
//
//  Created by Đặng An Hưng on 01/11/2023.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didSelectAtIndex(_ index: Int)
}

class SettingsView: UIView {

    @IBOutlet weak var settingsCollectionView: UICollectionView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var dismissBtnView: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var userImageBeforLogin: UIImageView!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var userImageAfterLogin: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var idLbl: UILabel!
    
    
    @IBAction func signOutAction(_ sender: Any) {
        signOutCompletion?()
    }
    
    var signOutCompletion: (() -> Void)?
    
    let data: [SettingsEntity] = [.init(title: "Cài đặt Soft OTP", image: "ic24PxSoftotp_Normal"), .init(title: "Nhận tin biến động số dư", image: "ic24PxCaidatbdsd_Normal"), .init(title: "Cài đặt Face ID", image: "ic24PxSoftotp_Normal"), .init(title: "Cài đặt hạn mức", image: "ic24PxHanmuc_Normal"), .init(title: "Cài đặt ngôn ngữ", image: "ic24PxLanguage_Normal"), .init(title: "Cài đặt mật khẩu", image: "ic24PxPassword_Normal"), .init(title: "Cấp/Đổi mã PIN", image: "ic24PxKey_Normal"), .init(title: "Quản lý danh bạ", image: "ic24PxContact_Normal"), .init(title: "Thông tin ứng dụng", image: "ic24PxInfo_Normal"), .init(title: "Đóng tài khoản", image: "ic24PxDongtaikhoan_Normal"), .init(title: "Hỏi và đáp", image: "ic24PxSoftotp_Normal"), .init(title: "Điều khoản riêng tư", image: "ic24PxsDkrt_Normal")]
    
    weak var delegate: SettingsViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        guard let settingsView = UINib(nibName: "SettingsView", bundle: nil).instantiate(withOwner: self).first as? UIView else {return}
        
        addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .clear
        layoutSubviews()
        
        if AppData.isLogin == true {
            loginBtn.alpha = 0
            userImageBeforLogin.alpha = 0
            usernameLbl.text = AppData.account?.userName
            idLbl.text = AppData.account?.numberAccount
        } else {
            logoutBtn.alpha = 0
            userImageAfterLogin.alpha = 0
            usernameLbl.alpha = 0
            idLbl.alpha = 0
        }
        
        
        mainView.transform = .init(translationX: 350, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.mainView.transform = .identity
        }
        
        settingsView.backgroundColor = .clear
        dismissBtnView.isUserInteractionEnabled = true
        dismissBtnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(_:))))
        configCollectionView()
    }
    
    func configCollectionView() {
        settingsCollectionView.register(.init(nibName: "SettingsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SettingsCollectionViewCell")
        
        settingsCollectionView.contentInset = .init(top: 30, left: 0, bottom: 0, right: 0)
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
    }
    
    @objc func dismiss(_ g: UITapGestureRecognizer) {
        close()
        
    }
    
    func close() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.backgroundColor = .clear
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.mainView.transform = .init(translationX: 350, y: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeFromSuperview()
        }
    }
    
}

extension SettingsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCollectionViewCell", for: indexPath) as? SettingsCollectionViewCell else {return UICollectionViewCell()}
        
        cell.biding(data[indexPath.row].title, image: data[indexPath.row].image)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 57.15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        close()
        delegate?.didSelectAtIndex(indexPath.row)
    }
    
}

extension SettingsView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if !mainView.frame.contains(point) {
            close()
        }
        return super.point(inside: point, with: event)
    }
}

