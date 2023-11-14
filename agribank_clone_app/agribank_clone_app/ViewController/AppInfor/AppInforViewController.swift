

import UIKit

class AppInforViewController: BaseViewController {

    @IBOutlet weak var appInforTableView: UITableView!
    
    let data: [AppInfor] = [.init(title: "Nhà phát triển", infor: "Sản phẩm hợp tác của Agribank và VNPAY"), .init(title: "Hạng mục", infor: "Tài chính - ngân hàng"), .init(title: "Cập nhật", infor: "11/09/2023"), .init(title: "Phiên bản", infor: "3.6.8"), .init(title: "Dung lượng", infor: "160 MB"), .init(title: "Ngôn ngữ", infor: "Tiếng Việt")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "Thông tin ứng dụng")
    }

    func configTableView() {
        appInforTableView.register(.init(nibName: "AppInforTableViewCell", bundle: nil), forCellReuseIdentifier: "AppInforTableViewCell")
        appInforTableView.delegate = self
        appInforTableView.dataSource = self
    }


}

extension AppInforViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppInforTableViewCell") as? AppInforTableViewCell else {return UITableViewCell()}
        
        cell.binding(data[indexPath.row].title, infor: data[indexPath.row].infor, index: indexPath.row)
        
        return cell
    }
    
    
}
