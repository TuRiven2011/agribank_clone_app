import UIKit

class ContentNotificationViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    
    var type: NotificationTypeEnum = .balance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        // Do any additional setup after loading the view.
    }

    private func setup() {
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.register(.init(nibName: "OtherNotificationTableViewCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "OtherNotificationTableViewCell")
        contentTableView.register(.init(nibName: "DealNotificationTableViewCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "DealNotificationTableViewCell")
        contentTableView.register(.init(nibName: "BalanceNotificationTableViewCell",
                                        bundle: nil),
                                  forCellReuseIdentifier: "BalanceNotificationTableViewCell")
    }
}

extension ContentNotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceNotificationTableViewCell", for: indexPath) as? BalanceNotificationTableViewCell else {return .init()}
        
        return cell
    }
    
    
}
