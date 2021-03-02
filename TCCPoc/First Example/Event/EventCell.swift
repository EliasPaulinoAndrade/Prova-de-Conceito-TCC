//
//  EventCell.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit
import SnapKit

class EventCell: UICollectionViewCell {
    private let containerView = UIView()
    private let eventImageView = UIImageView().set {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .gray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let dateLabel = UILabel().set {
        $0.font = .preferredFont(forTextStyle: .caption2)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 1
        $0.textColor = .red
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    private let eventTitleLabel = UILabel().set {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        $0.adjustsFontForContentSizeCategory = true
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.setContentHuggingPriority(.required, for: .vertical)
        $0.numberOfLines = 2
        $0.textColor = .black
    }
    private let authorLabel = UILabel().set {
        $0.font = .preferredFont(forTextStyle: .caption2)
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 2
        $0.textColor = .gray
        $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    private lazy var favoriteActionButton = UIButton().set {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
        $0.addTarget(self, action: #selector(handleUserTapOnFavoriteButton), for: .touchUpInside)
    }
    private lazy var shareActionButton = UIButton(type: .system).set {
        $0.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
        $0.addTarget(self, action: #selector(handleUserTapOnShareButton), for: .touchUpInside)
    }
    private lazy var actionsStackView = UIStackView(favoriteActionButton, shareActionButton).set {
        $0.spacing = 10
        $0.isUserInteractionEnabled = !UIAccessibility.isVoiceOverRunning
    }
    private lazy var containerStackView = UIStackView(eventImageView, dateLabel, eventTitleLabel, authorLabel).set {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
    }
    var isFavorited: Bool {
        get {
            favoriteActionButton.isSelected
        } set {
            favoriteActionButton.isSelected = newValue
        }
    }
    
    var onUserSelectShare: ((EventCell) -> Void)?
    var onUserSelectFavorite: ((EventCell) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleUserTapOnShareButton() -> Bool {
        onUserSelectShare?(self)
        return true
    }
    
    @objc
    private func handleUserTapOnFavoriteButton() -> Bool {
        onUserSelectFavorite?(self)
        return true
    }
}

extension EventCell: ViewCodable {
    func buildHierarchy() {
        contentView.addSubviews(containerStackView, containerView, actionsStackView)
    }
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        eventImageView.snp.makeConstraints {
            $0.height.equalTo(snp.height).multipliedBy(0.6)
        }
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        actionsStackView.snp.makeConstraints {
            $0.bottom.trailing.equalTo(eventImageView).offset(-5)
            $0.leading.greaterThanOrEqualTo(eventImageView.snp.leading)
            $0.height.equalTo(32)
        }
        actionsStackView.arrangedSubviews.forEach { actionView in
            actionView.snp.makeConstraints {
                $0.width.equalTo(actionView.snp.height)
            }
        }
        containerStackView.setCustomSpacing(5, after: eventImageView)
    }
    func setupAccessibility() {
        containerView.accessibilityTraits = .button
        containerView.isAccessibilityElement = true
        containerView.accessibilityViewIsModal = true
        
        containerView.accessibilityCustomActions = [
            UIAccessibilityCustomAction(
                name: "Favoritar",
                target: self,
                selector: #selector(handleUserTapOnFavoriteButton)
            ),
            UIAccessibilityCustomAction(
                name: "Compartilhar",
                target: self,
                selector: #selector(handleUserTapOnShareButton)
            )
        ]
    }
}

extension EventCell: EventCellViewable {
    func formatWith(viewModel: EventViewModel) {
        dateLabel.text = viewModel.formattedDate
        eventTitleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        eventImageView.image = UIImage(data: viewModel.imageData)
        containerView.accessibilityLabel = "\(viewModel.title). \(viewModel.author). \(viewModel.expandedFormatedDate)"
    }
}
