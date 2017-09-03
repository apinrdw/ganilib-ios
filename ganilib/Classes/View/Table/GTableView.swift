
import UIKit

open class GTableView: UITableView {
    private var helper: ViewHelper!
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initialize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func source(_ source: UITableViewDataSource) -> Self {
        self.dataSource = source
        return self
    }
    
    public func register(_ type: GTableViewCell.Type) -> Self {
        register(type.nib(), forCellReuseIdentifier: type.reuseIdentifier())
        return self
    }
    
    public func reload() -> Self {
        reloadData()
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
    
    public func autoRowHeight(estimate: Float) -> Self {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = CGFloat(estimate)
        return self
    }
    
    public func autoHeaderHeight(estimate: Float) -> Self {
        self.sectionHeaderHeight = UITableViewAutomaticDimension
        self.estimatedSectionHeaderHeight = CGFloat(estimate)
        return self
    }
    
    public func cellInstance<T: GTableViewCell>(of type: T.Type, style: UITableViewCellStyle = .default) -> T {
        if let cell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier()) as? T {
            return cell
        }
        return T.init(style: style)
    }
    
    public func end() {
        // Ends chaining
    }
}

open class GTableViewCell: UITableViewCell {
    private let container = GVerticalPanel()
    private let paddings = ViewPaddings()
    
    public convenience init() {
        self.init(style: .default)
    }
    
    public required init(style: UITableViewCellStyle) {
        super.init(style: style, reuseIdentifier: type(of: self).nibName())
        
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    public func initialize() {
        self.contentView.addSubview(container)
    }
    
    open override func didMoveToSuperview() {
        container.snp.makeConstraints { (make) -> Void in
            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
            make.top.equalTo(self.contentView).offset(paddings.top)
            make.bottom.equalTo(self.contentView).offset(-paddings.bottom)
            
            make.left.equalTo(self.contentView).offset(paddings.left)
            make.right.equalTo(self.contentView).offset(-paddings.right)
        }
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        container.addView(view, top: top)
    }
    
    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
//        _ = container.paddings(t: top, l: left, b: bottom, r: right)
        paddings.update(t: top, l: left, b: bottom, r: right)
        return self
    }

    static func nibName() -> String {
        return String(describing: self)
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: nil)
    }

}
