//
//  CardDemoViewController.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit
import SnapKit

class EventListView: UITableViewCell {
    private lazy var collectionLayout = UICollectionViewFlowLayout().set {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 15
    }
    private lazy var eventsDatasource = UICollectionViewDiffableDataSource<SingleSection, EventViewModel>(
        collectionView: eventsCollectionView,
        cellProvider: { [weak self] collectionView, indexPath, viewModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            guard let self = self else { return cell }
            if let eventCell = cell as? EventCell {
                eventCell.formatWith(viewModel: viewModel)
                eventCell.onUserSelectFavorite = { _ in
                    eventCell.isFavorited.toggle()
                    let message = eventCell.isFavorited ? "Você Favoritou O Item" : "Você Removeu o item dos favoritos"
                    UIAccessibility.post(notification: .announcement, argument: message)
                }
                eventCell.onUserSelectShare = { _ in
                    self.onShareItemCompletion?(indexPath.row, self)
                }
            }
            return cell
            
        }
    )
    private lazy var eventsCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionLayout
    ).set {
        $0.register(EventCell.self, forCellWithReuseIdentifier: "cell")
        $0.delegate = self
        $0.backgroundColor = .white
        $0.contentInset = .init(top: 0, left: 15, bottom: 0, right: 0)
    }
    
    private var collectionHeightConstraint: Constraint?
    private var viewModel: CardListViewModelling?
    var onSelectItemCompletion: ((Int, EventListView) -> Void)?
    var onShareItemCompletion: ((Int, EventListView) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func preferredContentSizeChanged(_ notification: Notification) {
        guard let contentSizeCategoryRawValue = notification.userInfo?["UIContentSizeCategoryNewValueKey"] as? String else {
            return reactToContentSize(.unspecified)
        }
        
        reactToContentSize(UIContentSizeCategory(rawValue: contentSizeCategoryRawValue))
    }

    private func reactToContentSize(_ contentSizeCategory: UIContentSizeCategory) {
        collectionHeightConstraint?.deactivate()
        
        eventsCollectionView.snp.makeConstraints {
            collectionHeightConstraint = $0.height.equalTo(200 + (contentSizeCategory.index * 25)).constraint
        }
        
        eventsCollectionView.layoutIfNeeded()
        eventsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepareForReuse() {
        var dataSnapshot = eventsDatasource.snapshot()
        dataSnapshot.deleteAllItems()
        eventsDatasource.apply(dataSnapshot)
    }
}

extension EventListView: ViewCodable {
    func buildHierarchy() {
        contentView.addSubview(eventsCollectionView)
    }
    func setupConstraints() {
        eventsCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.medium)
        }
        reactToContentSize(UIApplication.shared.preferredContentSizeCategory)
    }
    func applyAddtionalChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged), name: UIContentSizeCategory.didChangeNotification, object: nil)
        backgroundColor = .white
    }
    func setupAccessibility() {
        eventsCollectionView.isAccessibilityElement = false
        accessibilityElements = [eventsCollectionView]
    }
}

extension EventListView: EventListViewable {
    func formatWith(viewModel: CardListViewModelling) {
        self.viewModel = viewModel
        viewModel.getEvents()
    }
    
    func formatWith(events: [EventViewModel]) {
        var dataSnapshot = eventsDatasource.snapshot()
        dataSnapshot.appendSections([.main])
        dataSnapshot.appendItems(events, toSection: .main)
        eventsDatasource.apply(dataSnapshot, animatingDifferences: true)
    }
}

extension EventListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectItemCompletion?(indexPath.row, self)
    }
}
