import Foundation

protocol ViewCodeProtocol {
    func addSubviews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
}
