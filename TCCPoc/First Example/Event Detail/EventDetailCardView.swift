//
//  EventDetailCardView.swift
//  TCCPoc
//
//  Created by Elias Paulino on 18/02/21.
//

import UIKit
import SnapKit

class EventDetailCardView: UIView {
    private lazy var titleLabel = UILabel().set {
        $0.text = title
        $0.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    private lazy var descriptionLabel = UITextView().set {
        $0.text = cardDescription
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
        $0.textColor = .black
        $0.isScrollEnabled = false
        $0.isEditable = false
        $0.textContainer.lineFragmentPadding = 0
        $0.textDragInteraction?.isEnabled = false
    }
    private lazy var linkButton = UIButton().set {
        $0.setTitle(link, for: .normal)
        $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        $0.titleLabel?.textAlignment = .left
        $0.titleLabel?.numberOfLines = 0
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(handleLinkTap), for: .touchUpInside)
    }
    private lazy var itemsStackView = UIStackView(titleLabel, descriptionLabel, linkButton).set {
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    private let title: String
    private let cardDescription: String
    private let link: String
    private let onOpenLinkCompletion: () -> Void
    
    init(title: String, description: String, link: String, onOpenLinkCompletion: @escaping () -> Void) {
        self.title = title
        self.cardDescription = description
        self.link = link
        self.onOpenLinkCompletion = onOpenLinkCompletion
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleLinkTap() -> Bool {
        onOpenLinkCompletion()
        return true
    }
}

extension EventDetailCardView: ViewCodable {
    func buildHierarchy() {
        addSubview(itemsStackView)
    }
    func setupConstraints() {
        itemsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    func applyAddtionalChanges() {
        backgroundColor = .white
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
    }
    func setupAccessibility() {
        itemsStackView.isAccessibilityElement = true
        itemsStackView.accessibilityLabel = "\(title). \(cardDescription)"
        itemsStackView.accessibilityTraits = .staticText
        
        itemsStackView.accessibilityCustomActions = [
            UIAccessibilityCustomAction(name: link, target: self, selector: #selector(handleLinkTap))
        ]
    }
}
