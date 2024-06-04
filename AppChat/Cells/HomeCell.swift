//
//  HomeCell.swift
//  AppChat
//
//  Created by Nguyên Nguyễn Khôi on 03/06/2024.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var imgViewAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblName.numberOfLines = 0
        
        imgViewAvatar.layer.borderWidth = 1.0
        imgViewAvatar.layer.masksToBounds = false
        imgViewAvatar.layer.borderColor = UIColor.blue.cgColor
        imgViewAvatar.layer.cornerRadius = 20
        imgViewAvatar.clipsToBounds = true
        imgViewAvatar.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binding(people: People) {
        imgViewAvatar.image = UIImage(named: people.avatar)
        lblName.text = people.name
        
    }
}
