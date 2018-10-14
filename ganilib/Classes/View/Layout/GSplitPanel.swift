
import UIKit

open class GSplitPanel : UIView, IView {
    private var helper : ViewHelper!
    private var event : EventHelper<GSplitPanel>!
//    private var previousViewElement : UIView!
//    private var previousConstraint : NSLayoutConstraint!
    
    public var size: CGSize {
        get {
            return helper!.size
        }
    }
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        self.event = EventHelper(self)
        
        _ = paddings(t: 0, l: 0, b: 0, r: 0)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    private func decreaseResistance(view: UIView) {
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        for subview in view.subviews {
            decreaseResistance(view: subview)
        }
    }
    
    public func withViews(left: UIView, right: UIView) -> Self {
        // A label with empty string will occupy the remaining space thus ensuring the right view's
        // width to be as small as it requires to be.
        return withViews(left, GLabel().text(""), right)
    }
    
    public func withViews(_ left: UIView, _ center: UIView, _ right: UIView) -> Self {
        // The hope is this makes things more predictable
        left.translatesAutoresizingMaskIntoConstraints = false
        center.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false
        
        decreaseResistance(view: center)
        
        addSubview(left)
        addSubview(center)
        addSubview(right)
        
        left.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.left.equalTo(self.snp.leftMargin)
            
//            make.right.greaterThanOrEqualTo(right.snp.left)
//            make.right.lessThanOrEqualTo(right.snp.left)
        }
        center.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            
            make.left.equalTo(left.snp.right)
            make.right.equalTo(right.snp.left)
//            make.width.equalTo(self)
        }
        right.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.right.equalTo(self.snp.rightMargin)
        }
        
        self.snp.makeConstraints { make in
//            make.bottomMargin.equalTo(left.snp.bottom)
//            make.bottomMargin.equalTo(center.snp.bottom)
//            make.bottomMargin.equalTo(right.snp.bottom)
            
            make.bottomMargin.greaterThanOrEqualTo(left.snp.bottom)
            make.bottomMargin.greaterThanOrEqualTo(center.snp.bottom)
            make.bottomMargin.greaterThanOrEqualTo(right.snp.bottom)
        }
        
        return self
    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
    
    public func onClick(_ command: @escaping (GSplitPanel) -> Void) -> Self {
        event.onClick(command)
        return self
    }
    
    public func interaction(_ enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
}
