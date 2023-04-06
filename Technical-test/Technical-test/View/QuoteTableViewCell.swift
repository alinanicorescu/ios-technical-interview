//
//  QuoteCell.swift
//  Technical-test
//
//  Created by Alina Nicorescu on 06.04.2023.
//

import Foundation
import UIKit

protocol QuoteTableViewCellDelegate: class {
    
    func didTapFavorite(_ cell: QuoteTableViewCell)
}

class QuoteTableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let lastLabel = UILabel()
    let currencyLabel = UILabel()
    let readableLastChangePercentLabel = UILabel()
   
    let stackView: UIStackView = UIStackView()
    let favoriteButton = UIButton()
    weak var delegate: QuoteTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupAutoLayout()
    }
    
    func configure(quote: Quote) {
        self.nameLabel.text = quote.name
        self.nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        self.lastLabel.text = quote.last
        self.currencyLabel.text = quote.currency
        self.readableLastChangePercentLabel.text = quote.readableLastChangePercent
        if let variationColor = quote.variationColor
        {
            if #available(iOS 11.0, *) {
                if let color = UIColor(named: variationColor) {
                    self.readableLastChangePercentLabel.textColor = color
                }
            } else {
                //use dictionary of colors for other ios versions
            }
        }
        
        favoriteButton.setImage(quote.favorite ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "no-favorite") , for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        stackView.axis = .vertical
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(lastLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(readableLastChangePercentLabel)
        contentView.addSubview(stackView)
        
        favoriteButton.setImage(#imageLiteral(resourceName: "no-favorite") , for: .normal)
        favoriteButton.frame = CGRect(x: 0 , y: 0 , width: 50, height: 50)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        accessoryView = favoriteButton
        
    }
  
    private func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func toggleFavorite() {
        toggleFavoriteButtonImage()
        delegate?.didTapFavorite(self)
    }
    
    private func toggleFavoriteButtonImage() {
        if favoriteButton.image(for: .normal) == #imageLiteral(resourceName: "favorite") {
            favoriteButton.setImage(#imageLiteral(resourceName: "no-favorite") , for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }
    }
   
}
