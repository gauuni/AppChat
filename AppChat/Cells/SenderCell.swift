//
//  SenderCell.swift
//  AppChat
//
//  Created by Nguyên Nguyễn Khôi on 03/06/2024.
//

import UIKit

class BaseMessageCell: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblText.numberOfLines = 0
        viewBg.backgroundColor = .clear
    }
    
    func binding(data: Message) {
        lblText.text = data.content
    }
}

class SenderCell: BaseMessageCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
