class JsonView_Panels_VerticalV1: JsonView {
    private let panel: GVerticalPanel
    
    required convenience init(_ spec: Json, _ screen: GScreen) {
        self.init(GVerticalPanel(), spec, screen)
    }
    
    init(_ view: GVerticalPanel, _ spec: Json, _ screen: GScreen) {
        self.panel = view
        super.init(spec, screen)
    }
    
    override func initView() -> UIView {
        for viewSpec in spec["subviews"].arrayValue {
            GLog.t("SPEC1: \(viewSpec)")
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                panel.addView(jsonView.createView())
            }
        }
        return panel
    }
}