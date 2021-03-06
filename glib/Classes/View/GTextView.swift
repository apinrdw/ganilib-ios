import UIKit

open class GTextView: UITextView {
    private var helper: ViewHelper!
//    private var padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    public init() {
        super.init(frame: .zero, textContainer: nil)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        if let textColor = text {
            self.textColor = textColor
        }
        return self
    }

    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
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

    public func specs(_ specs: GTextViewSpec...) -> Self {
        for spec in specs {
            spec.decorate(self)
        }
        return self
    }

    public func secure(_ secure: Bool) -> Self {
        isSecureTextEntry = secure
        return self
    }

    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
}

public class GTextViewSpec {
    private var decorator: ((GTextView) -> Void)

    public init(_ decorator: @escaping ((GTextView) -> Void)) {
        self.decorator = decorator
    }

    func decorate(_ view: GTextView) {
        decorator(view)
    }
}
