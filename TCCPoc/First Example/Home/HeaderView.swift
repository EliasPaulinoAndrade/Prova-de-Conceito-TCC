//
//  HeaderView.swift
//  TCCPoc
//
//  Created by Elias Paulino on 15/02/21.
//

import UIKit
import SnapKit

class HeaderView: UITableViewHeaderFooterView {
    private let headerTitleLabel = UILabel().set {
        $0.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        $0.textColor = .black
        $0.adjustsFontForContentSizeCategory = true
        $0.numberOfLines = 0
        $0.setContentHuggingPriority(.required, for: .vertical)
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    var title: String? {
        get {
            return headerTitleLabel.text
        } set {
            headerTitleLabel.text = newValue
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView: ViewCodable {
    func buildHierarchy() {
        contentView.addSubview(headerTitleLabel)
    }
    
    func setupConstraints() {
        headerTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
