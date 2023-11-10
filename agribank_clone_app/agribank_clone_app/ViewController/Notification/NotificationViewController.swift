import UIKit

class NotificationViewController: BaseViewController {
    
    @IBOutlet weak var searchNotificationTextField: UITextField!
    @IBOutlet weak var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setupNavigationBar(title: String) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .init(rgb: 0xffDC8630)
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            
        } else {
            self.navigationController?.navigationBar.backgroundColor = .init(rgb: 0xffDC8630)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.subviews.forEach({$0.removeFromSuperview()})
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.additionalSafeAreaInsets = .init(top: 50, left: 0, bottom: 20, right: 0)
        
        let back = UIImageView(image: .init(named: "ic_24px_back_Normal"))
        back.isUserInteractionEnabled = true
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        navigationController?.navigationBar.addSubview(back)
        let backButtonItem = UIBarButtonItem(customView: back)
        navigationController?.navigationItem.leftBarButtonItem = backButtonItem

        let segment = SegmentedControl(cornerRadius: 17)
        segment.insertSegment(withTitle: "Biến động SD", at: 0, animated: true)
        segment.insertSegment(withTitle: "Khuyến mãi", at: 1, animated: true)
        segment.insertSegment(withTitle: "Tin khác", at: 2, animated: true)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .init(rgb: 0xffE9AE60)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0xffDC8630)], for: .selected)
        segment.selectedSegmentTintColor = .white
        segment.isUserInteractionEnabled = true
        segment.layer.cornerRadius = 20
        segment.layer.masksToBounds = true
        segment.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(segment)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(titleLabel)
        
        if let navigationBar = navigationController?.navigationBar {
            [
                segment.heightAnchor.constraint(equalToConstant: 40),
                segment.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
                segment.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -20),
                segment.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
                
                back.widthAnchor.constraint(equalToConstant: 30),
                back.heightAnchor.constraint(equalToConstant: 30),
                back.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 20),
                
                titleLabel.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: segment.topAnchor, constant: -12),
                back.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            ].forEach({$0.isActive = true})
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(title: "Thông tin agribank".uppercased())
    }
    
    
}

final class SegmentedControl: UISegmentedControl {
    private var newCornerRadius: CGFloat
    
    init(cornerRadius: CGFloat) {
        self.newCornerRadius = cornerRadius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = newCornerRadius
        
        guard let selectedSegment = subviews[numberOfSegments] as? UIImageView else {
            return
        }
        
        selectedSegment.layer.removeAnimation(forKey: "SelectionBounds")
        selectedSegment.layer.masksToBounds = true
        selectedSegment.layer.cornerRadius = newCornerRadius - layer.borderWidth
        
        selectedSegment.bounds = CGRect(origin: .zero, size: CGSize(
            width: bounds.width / 3 - layer.borderWidth - 6,
            height: bounds.height - layer.borderWidth * 2 - 6
        ))
        
        if let selectedSegmentTintColor = selectedSegmentTintColor {
            selectedSegment.image = UIImage(
                colorFill: selectedSegmentTintColor,
                size: selectedSegment.bounds.size
            )
        }
    }
}

