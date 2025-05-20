import UIKit

class EnumSelector<E: SelectableEnum>: UIView {
    
    // MARK: - Estado
    var selectedValue: E? {
        didSet {
            let title = selectedValue?.displayName ?? placeholder
            button.setTitle(title, for: .normal)
        }
    }
    
    // placeholder inicial (ex: “Select”)
    private let placeholder: String
    
    // MARK: - Actions
    private var actions: [UIAction] {
        E.allCases
          .sorted { $0.rawValue < $1.rawValue }
          .map { value in
            UIAction(title: value.displayName) { [weak self] _ in
              self?.selectedValue = value
            }
          }
    }
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
      let l = UILabel()
      l.translatesAutoresizingMaskIntoConstraints = false
      l.font = UIFont.bodyRegular
      l.textColor = .Label.primary
      NSLayoutConstraint.activate([
        l.widthAnchor.constraint(equalToConstant: 100),
        l.heightAnchor.constraint(equalToConstant: 22)
      ])
      return l
    }()
    
    private lazy var button: UIButton = {
      var config = UIButton.Configuration.plain()
      config.title = placeholder
      config.indicator = .popup
      let b = UIButton(configuration: config)
      b.translatesAutoresizingMaskIntoConstraints = false
      b.menu = UIMenu(title: menuTitle, options: .singleSelection, children: actions)
      b.showsMenuAsPrimaryAction = true
      b.tintColor = .Label.secondary
      b.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      return b
    }()
    
    private lazy var stack: UIStackView = {
      let s = UIStackView(arrangedSubviews: [titleLabel, button])
      s.translatesAutoresizingMaskIntoConstraints = false
      s.axis = .horizontal
      s.alignment = .center
      s.distribution = .equalSpacing
      s.isLayoutMarginsRelativeArrangement = true
      return s
    }()
    
    // MARK: - Init
    private let menuTitle: String
    init(enumTypeName: String,
         placeholder: String = "Select",
         menuTitle: String? = nil) {
      self.placeholder = placeholder
      self.menuTitle = menuTitle ?? enumTypeName
      super.init(frame: .zero)
      titleLabel.text = enumTypeName
      commonInit()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) não implementado")
    }
    
    private func commonInit() {
      addSubview(stack)
      setupConstraints()
      setupBorder()
    }
    
    // MARK: – Layout & Border
    private let bottomBorder = CALayer()
    private func setupBorder() {
      bottomBorder.backgroundColor = UIColor.Separator.primary.cgColor
      layer.addSublayer(bottomBorder)
    }
    override func layoutSubviews() {
      super.layoutSubviews()
      let h: CGFloat = 0.33
      bottomBorder.frame = CGRect(x: 0,
                                  y: bounds.height - h,
                                  width: bounds.width,
                                  height: h)
    }
    private func setupConstraints() {
      NSLayoutConstraint.activate([
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        stack.topAnchor.constraint(equalTo: topAnchor),
        stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        stack.leadingAnchor.constraint(equalTo: leadingAnchor),
        stack.trailingAnchor.constraint(equalTo: trailingAnchor),
        stack.heightAnchor.constraint(equalToConstant: 44)
      ])
    }
}
