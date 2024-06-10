//
//  ReceiverCell.swift
//  AppChat
//
//  Created by Nguyên Nguyễn Khôi on 03/06/2024.
//

import UIKit

class ReceiverCell: BaseMessageCell {
    @IBOutlet private weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.borderWidth = 1.0
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor.blue.cgColor
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        
        viewBg.layer.masksToBounds = false
        viewBg.layer.cornerRadius = 8
        viewBg.clipsToBounds = true
        
        viewBg.backgroundColor = UIColor.systemBlue
    }
    
    override func binding(data: Message) {
        super.binding(data: data)
        if let avatar = data.sender.avatar {
            imgView.image = UIImage(named: avatar)
        }
    }

}
