import Foundation
import  UIKit
fileprivate var activityIndicatorViewAssociativeKey = "activityIndicatorViewAssociativeKey"

public class RCLoadingView:UIActivityIndicatorView {
    
}

public extension UIView {
    var activityIndicatorView: RCLoadingView {
        get {
            if let activityIndicatorView = objc_getAssociatedObject(self,&activityIndicatorViewAssociativeKey) as? RCLoadingView {
                bringSubviewToFront(activityIndicatorView)
                return activityIndicatorView
            } else {
                let activityIndicatorView:RCLoadingView = RCLoadingView()
                activityIndicatorView.layer.cornerRadius = 5
                activityIndicatorView.backgroundColor = .init(white: 0, alpha: 0.5)
                activityIndicatorView.style = .large
                activityIndicatorView.color = .white
                activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(activityIndicatorView)
                bringSubviewToFront(activityIndicatorView)
                NSLayoutConstraint.activate([
                    activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
                    activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                    activityIndicatorView.widthAnchor.constraint(equalToConstant: 80),
                    activityIndicatorView.widthAnchor.constraint(equalTo: activityIndicatorView.heightAnchor, multiplier: 1,constant: 0)
                    
                ])
                
                objc_setAssociatedObject(self, &activityIndicatorViewAssociativeKey,activityIndicatorView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }
        
        set {
            addSubview(newValue)
            bringSubviewToFront(activityIndicatorView)
            objc_setAssociatedObject(self, &activityIndicatorViewAssociativeKey,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {    // 3
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        view.frame = bounds
        self.addSubViewWithConstraints(subView:view)
        return view
    }
    
    func addSubViewWithConstraints(subView:UIView, padding: CGFloat = 0, topOffset:CGFloat? = 0) {
        if subView.superview == nil {
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
            self.bringSubviewToFront(subView)
            // add constraint
            NSLayoutConstraint.activate([
                subView.topAnchor.constraint(equalTo: self.topAnchor,constant: topOffset ?? padding),
                subView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: padding),
                subView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
                subView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: padding)
            ])
        }
    }
    
    func hideWithAnimationAddEvent(animatedView: UIView,time: TimeInterval = 0.25 , callback: (() -> Void)? = nil) {
        animatedView.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            animatedView.alpha = 0
            animatedView.transform = CGAffineTransform.init(translationX: animatedView.frame.width - 75, y: animatedView.frame.height - 75)
            
        }, completion: { status in
            if status {
                self.removeFromSuperview()
                callback?()
            }
        })
    }
   
    func hideWithAnimationTop(animatedView: UIView , callback: (() -> Void)? = nil) {
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(5.0),
                       options: [.curveEaseIn],
                       animations: {
            animatedView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }, completion: { status in
            if status {
                self.isHidden = true
                self.removeFromSuperview()
                callback?()
            }
        })
    }
    func hideWithAnimationToBottom(animatedView: UIView , callback: (() -> Void)? = nil) {
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(5.0),
                       options: [.curveEaseIn],
                       animations: {
            animatedView.transform = CGAffineTransform.init(translationX: 0, y: animatedView.frame.height)
            
        }, completion: { status in
            if status {
                self.isHidden = true
                self.removeFromSuperview()
                callback?()
            }
        })
    }
    
    func hideWithAnimation(animatedView: UIView,time: TimeInterval = 0.25 , callback: (() -> Void)? = nil) {
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [],
                       animations: {
            animatedView.alpha = 0
            animatedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { status in
            if status {
                self.removeFromSuperview()
                callback?()
            }
        })
    }
    func showWithAnimationFromBottom(animatedView: UIView, in view: UIView?, callback: (() -> Void)? = nil) {
        if view != nil {
            self.frame = view!.bounds
            view?.addSubViewWithConstraints(subView: self)
            view?.bringSubviewToFront(self)
        } else {
            APP_DELEGATE?.topWindow?.addSubViewWithConstraints(subView: self)
            self.backgroundColor = .black.withAlphaComponent(0.4)
            APP_DELEGATE?.topWindow?.bringSubviewToFront(self)
        }
        animatedView.transform = CGAffineTransform.init(translationX: 0, y: animatedView.frame.height)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn],
                       animations: {
            animatedView.transform = CGAffineTransform.identity
        }, completion: {[weak self] status in
            if status {
                callback?()
            }
        })

        self.isHidden = false
    }
    func showWithAnimationFromTop(animatedView:UIView, in view:UIView?, callback: (() -> Void)? = nil) {
        if view != nil {
            self.frame = view!.bounds
            view?.addSubViewWithConstraints(subView: self)
            view?.bringSubviewToFront(self)
        } else {
            APP_DELEGATE?.topWindow?.addSubViewWithConstraints(subView: self)
            APP_DELEGATE?.topWindow?.bringSubviewToFront(self)
        }
        animatedView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [.curveEaseIn],
                       animations: {
            animatedView.transform = CGAffineTransform.identity
        }, completion: { status in
            if status {
                callback?()
            }
        })

        self.isHidden = false
    }
    
    /** This is the function to get subViews of a view of a particular type
     */
    func subViews<T : UIView>(type : T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }
    
    /** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
extension UIView {
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}


extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}
extension UIView {
    func drawCustomShape(cornerRadius: CGFloat = 35) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        //create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.red.cgColor
        self.layer.addSublayer(shapeLayer)
        
        //create path
        let path = UIBezierPath()
        
        //top left point
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        //bottom right point
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        //bottom right corner
        path.addQuadCurve(to: CGPoint(x: self.frame.size.width - cornerRadius, y: self.frame.size.height - cornerRadius),
                          controlPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height - cornerRadius))
        
        //bottom left
        path.addLine(to: CGPoint(x: 0 + cornerRadius, y: self.frame.size.height - cornerRadius))
//        //bottom left corner
        path.addQuadCurve(to: CGPoint(x: 0, y: self.frame.size.height - cornerRadius - cornerRadius),
                          controlPoint: CGPoint(x: 0, y: self.frame.size.height - cornerRadius))
        
        path.close()
        
        shapeLayer.path = path.cgPath
    }
}
extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}

extension AppDelegate {
    var topWindow:UIWindow? {
        return UIApplication.shared.connectedScenes
        //                .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}
