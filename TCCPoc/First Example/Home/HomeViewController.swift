//
//  HomeViewController.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var datasource = UITableViewDiffableDataSource<Int, CardListViewModel>(
        tableView: tableView,
        cellProvider: { [weak self] tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
            if let eventCell = cell as? EventListView {
                viewModel.viewable = eventCell
                eventCell.formatWith(viewModel: viewModel)
                eventCell.onSelectItemCompletion = self?.handleItemSelection
                eventCell.onShareItemCompletion = self?.handleItemShare
            }
            return cell
        }
    )
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).set {
        $0.register(EventListView.self, forCellReuseIdentifier: "listCell")
        $0.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "listHeader")
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionHeaderHeight = UITableView.automaticDimension
        $0.estimatedSectionHeaderHeight = 44;
        $0.estimatedRowHeight = 44;
        $0.delegate = self
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }
    private let viewModel: HomeViewModelling
    
    init(viewModel: HomeViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getLists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIAccessibility.post(notification: .layoutChanged, argument: navigationController?.navigationBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handleItemSelection(position: Int, cell: EventListView) {
        navigationController?.pushViewController(EventDetailViewController(), animated: true)
    }
    
    private func handleItemShare(position: Int, cell: EventListView) {
        present(
            UIActivityViewController(activityItems: ["mock share"], applicationActivities: nil),
            animated: true,
            completion: nil
        )
    }
}

extension HomeViewController: ViewCodable {
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func applyAddtionalChanges() {
        title = "Eventos"
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        HeaderView(reuseIdentifier: nil).set {
            $0.title = datasource.snapshot().itemIdentifiers(inSection: section).first?.title
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension HomeViewController: HomeViewable {
    func formatWith(lists: [CardListViewModel]) {
        var dataSnapshot = datasource.snapshot()
        
        dataSnapshot.appendSections(Array((0..<lists.count)))
        
        lists.enumerated().forEach { item in
            dataSnapshot.appendItems([item.element], toSection: item.offset)
        }

        datasource.apply(dataSnapshot, animatingDifferences: false)
    }
}
