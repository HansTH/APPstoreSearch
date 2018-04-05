//
//  AppDetailInfoCell.swift
//  APPstoreSearch
//
//  Created by Hans ter Horst on 04-04-18.
//  Copyright © 2018 Hans ter Horst. All rights reserved.
//

import UIKit

class AppDetailInfoCell: UICollectionViewCell {
    
    //MARK: - Properties
    var info: SearchResult? {
        didSet {
            guard let info = info else {return}
            let information: [String] = [info.seller!, info.genre!, info.lastUpdate, info.version!, info.appSize, info.rating!]
            let labels = createLabels(named: information, fontSize: 14, weight: .regular, textColor: .black)
            labels.forEach({infoLabelStackView.addArrangedSubview($0)})
        }
    }
    
    
    //MARK: - AppDetailInfoCell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviewsAndConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func setupSubviewsAndConstraints() {
        
        let titleNameLabels = ["Seller","Category","Updated","Version","Size","Rating"]
        let labels = createLabels(named: titleNameLabels, fontSize: 14, weight: .regular, textColor: .gray)
        labels.forEach( { titleLabelStackView.addArrangedSubview($0)} )
        
        let views = [titleLabel, titleLabelStackView, infoLabelStackView, dividerLineView]
        views.forEach({addSubview($0)})
        
        titleLabel.setupConstraintsTo(top: topAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor,
                                      margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        titleLabelStackView.setupConstraintsTo(top: titleLabel.bottomAnchor, bottom: nil,
                                               left: leadingAnchor, right: nil,
                                               margin: .init(top: 8, left: 16, bottom: 0, right: 0))
        titleLabelStackView.sizeConstraints(size: .init(width: 80, height: 0))
        
        infoLabelStackView.setupConstraintsTo(top: titleLabelStackView.topAnchor, bottom: nil,
                                              left: titleLabelStackView.trailingAnchor, right: trailingAnchor,
                                              margin: .init(top: 0, left: 8, bottom: 0, right: 16))
        
        dividerLineView.setupConstraintsTo(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor,
                                           margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        dividerLineView.sizeConstraints(size: .init(width: 0, height: 0.5))
        
    }
    
    private func createLabels(named: [String], fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) -> [UILabel] {
        
        return named.map { name in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = name
            label.textColor = textColor
            label.numberOfLines = 1
            label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
            return label
        }
    }
    
    
    //MARK: - View onjects
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    let titleLabelStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    let infoLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let dividerLineView: UIView = {
        let view  = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
}
