import UIKit
import Combine

class PickTimeView: UIView {
    static let shared = PickTimeView()
    var completion: ((Date) -> Void)?
    var subscriptions: Set<AnyCancellable> = []
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pickerTime: UIDatePicker!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
        setTaps()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
        setTaps()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self {
            self.backgroundColor = .clear
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.8),
                           initialSpringVelocity: CGFloat(5.0),
                           options: [.curveEaseIn],
                           animations: {[weak self] in
                guard let self = self else { return }
                self.completion?(self.pickerTime.date)
                self.contentView.transform = CGAffineTransform.init(translationX: 0, y: self.contentView.frame.height)
            }) {_ in
                self.isHidden = true
                self.removeFromSuperview()
            }
            
        }
    }
    
    private func setTaps() {
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
    }
    
    private func initXib() {
        fromNib()
        
    }
    
    func hide() {
        self.backgroundColor = .clear
        self.hideWithAnimationToBottom(animatedView: self.contentView, callback: nil)
    }
    
    func show(time: Date, completion: ((Date) -> Void)? = nil) {
        time.format(partern: "hh:mm dd/MM/yyyy")
        pickerTime.date = time
        self.completion = completion
        self.showWithAnimationFromBottom(animatedView: self.contentView, in: nil)
    }
}

extension PickTimeView {
    @objc func handleDone() {
        self.completion?(self.pickerTime.date)
        self.hide()
    }
    
    @objc func handleCancel() {
        self.hide()
    }
}
