//
//  CustomAlertView.swift
//  TCCPoc
//
//  Created by Elias Paulino on 15/02/21.
//

import UIKit
import SnapKit

class CustomAlertView: UIView {
    private let backgroundView = UIView().set {
        $0.backgroundColor = UIColor(named: "mockDark")
        $0.layer.cornerRadius = 16
    }
    
    private let titleLabel = UILabel().set {
        $0.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.adjustsFontForContentSizeCategory = true
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    private let descriptionLabel = UILabel().set {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textColor = .white
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
    }
    
    private lazy var okButton = UIButton(type: .system).set {
        $0.addTarget(self, action: #selector(handleActionTap), for: .touchUpInside)
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.titleLabel?.font = .preferredFont(forTextStyle: .body)
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    private lazy var itemsStackView = UIStackView(titleLabel, descriptionLabel, okButton).set {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let scrollView = UIScrollView()
    
    private var actionCompletion: (() -> Void)?
    
    init(title: String, description: String, actionTitle: String, action: (() -> Void)?) {
        titleLabel.text = title
        descriptionLabel.text = description
        super.init(frame: .zero)
        okButton.setTitle(actionTitle, for: .normal)
        actionCompletion = action ?? execDefaultAction
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func execDefaultAction() {
        removeFromSuperview()
    }
    
    @objc
    private func handleActionTap() {
        actionCompletion?()
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        UIAccessibility.post(notification: .layoutChanged, argument: self)
    }
}

extension CustomAlertView: ViewCodable {
    func buildHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(itemsStackView)
    }
    func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.height.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-16)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        itemsStackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview().inset(16)
            $0.height.equalToSuperview().offset(-32).priority(.medium)
        }
    }
    func applyAddtionalChanges() {
        backgroundColor = UIAccessibility.buttonShapesEnabled ? UIColor(named: "mockDark2") : UIColor.black.withAlphaComponent(0.7)
    }
    func setupAccessibility() {
        accessibilityViewIsModal = true
        titleLabel.accessibilityLabel = "Alerta. \(titleLabel.text ?? "")"
    }
}

extension UIView {
    func presentCustomAlert(title: String, description: String, actionTitle: String, action: (() -> Void)? = nil) {
        let customAlertView = CustomAlertView(
            title: title,
            description: description,
            actionTitle: actionTitle,
            action: action
        )
        addSubview(customAlertView)
        customAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
