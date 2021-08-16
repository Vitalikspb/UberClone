//
//  LocationCell.swift
//  UberClone
//
//  Created by VITALIY SVIRIDOV on 11.08.2021.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "LocationCell"
    
    var placeMark: MKPlacemark? {
        didSet {
            titleLabel.text = placeMark?.name
            addressLabel.text = placeMark?.address
        }
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let addressLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
