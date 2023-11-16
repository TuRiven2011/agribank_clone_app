import UIKit

class NotificationViewController: BaseViewController {
    
    @IBOutlet weak var searchNotificationTextField: UITextField!
    
    var pageViewController: UIPageViewController?
    var currentIndex = 0
    let balanceVC = ContentNotificationViewController()
    let dealVC = ContentNotificationViewController()
    let otherVC = ContentNotificationViewController()
    let segment = SegmentedControl(cornerRadius: 17)
    var backCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(title: "Thông tin agribank".uppercased())
        setupPageVC()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    

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
        back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackToMain)))
        navigationController?.navigationBar.addSubview(back)
//        let backButtonItem = UIBarButtonItem(customView: back)
//        navigationController?.navigationItem.leftBarButtonItem = backButtonItem
        segment.insertSegment(withTitle: NotificationTypeEnum.balance.title, at: 0, animated: true)
        segment.insertSegment(withTitle: NotificationTypeEnum.deal.title, at: 1, animated: true)
        segment.insertSegment(withTitle: NotificationTypeEnum.other.title, at: 2, animated: true)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .init(rgb: 0xffE9AE60)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0xffDC8630)], for: .selected)
        segment.selectedSegmentTintColor = .white
        segment.isUserInteractionEnabled = true
        segment.layer.cornerRadius = 20
        segment.layer.masksToBounds = true
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_ :)), for: .valueChanged)
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
        
        back.bringSubviewToFront(self.view)
    }
    
    private func setupLayout() {
        
    }
    
    private func setupPageVC() {
        
        pageViewController = .init(transitionStyle: .scroll,
                                   navigationOrientation: .horizontal,
                                   options: nil)
        guard let pageViewController = pageViewController else {return}
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let viewControllers = [balanceVC]
        pageViewController.setViewControllers(viewControllers,
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        self.view.addSubview(pageViewController.view)
        self.addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        [
            pageViewController.view.topAnchor.constraint(equalTo: searchNotificationTextField.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach({$0.isActive = true})
    }
    
    
}

extension NotificationViewController {
    
    @objc func handleBackToMain() {
        print("Handle")
//        APP_DELEGATE?.appNavigator?.switchToMain()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        backCompletion?()
        if sender.selectedSegmentIndex == 0 {
            pageViewController?.setViewControllers([balanceVC],
                                                   direction: .reverse,
                                                   animated: true)
        } else if sender.selectedSegmentIndex == 1 {
            if sender.selectedSegmentIndex < currentIndex {
                pageViewController?.setViewControllers([dealVC],
                                                       direction: .reverse,
                                                       animated: true)
            } else {
                pageViewController?.setViewControllers([dealVC],
                                                       direction: .forward,
                                                       animated: true)
            }
        } else if sender.selectedSegmentIndex == 2 {
            pageViewController?.setViewControllers([otherVC],
                                                   direction: .forward,
                                                   animated: true)
        }
        currentIndex = sender.selectedSegmentIndex
    }
}

extension NotificationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == dealVC {
            return balanceVC
        } else if viewController == otherVC {
            return dealVC
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?  {
        if viewController == balanceVC {
            return dealVC
        } else if viewController == dealVC {
            return otherVC
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = previousViewControllers.first else {return}
        if completed {
            switch vc {
            case balanceVC:
                segment.selectedSegmentIndex = 1
            case dealVC:
                if pageViewController.viewControllers?.first == otherVC {
                    segment.selectedSegmentIndex = 2
                } else {
                    segment.selectedSegmentIndex = 0
                }
            case otherVC:
                segment.selectedSegmentIndex = 1
            default:
                break
            }
            
            currentIndex = segment.selectedSegmentIndex
        }
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

