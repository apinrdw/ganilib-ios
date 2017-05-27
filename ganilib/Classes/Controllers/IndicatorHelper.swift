
import UIKit
import MessageUI

open class IndicatorHelper {
    // NOTE: Not sure if we need to set this to weak. We tried unowned but got "bad access".
    private let screen : UIViewController
    lazy var indicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    public init(_ screen : UIViewController) {
        self.screen = screen
    }
    
    public func showView() {
        //[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        indicator.center = screen.view.center
        indicator.backgroundColor = .white
        //indicator.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        
        indicator.layer.borderWidth = 1
        indicator.layer.cornerRadius = 6
        indicator.layer.borderColor = UIColor.lightGray.cgColor
        
        screen.view.addSubview(indicator)
        indicator.bringSubview(toFront: screen.view)
        
        indicator.startAnimating()
    }
    
    public func hideView() {
        indicator.stopAnimating()
    }
    
}