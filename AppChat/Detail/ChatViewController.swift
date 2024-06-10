//
//  ChatViewController.swift
//  AppChat
//
//  Created by Nguyên Nguyễn Khôi on 03/06/2024.
//

import UIKit
import UIColor_Hex_Swift
import GrowingTextView

struct Person {
    let avatar: String?
    let name: String
}

struct Message {
    let content: String
    let sender: Person
    let receiver: Person
    let createdDate: Date
    
    //image
}

fileprivate let senderCellIdentifier = "SenderCell"
fileprivate let receiverCellIdentifier = "ReceiverCell"

class ChatViewController: UIViewController {
    @IBOutlet private weak var textView: GrowingTextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var text = ["Lorem Ipsum is simply",
                "dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,",
                "and more recently with desktop publishing software",
                "like Aldus PageMaker including versions of Lorem Ipsum."]
    var messages: [Message] = []
    var person: Person!
     
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = nil
        textView.backgroundColor = UIColor("#f2f2f2")
        textView.layer.masksToBounds = false
        textView.layer.cornerRadius = 20
        textView.clipsToBounds = true
        textView.maxHeight = 80
        
        collectionView.backgroundColor = UIColor("#f2f2f2")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: senderCellIdentifier, bundle: nil), forCellWithReuseIdentifier: senderCellIdentifier)
        collectionView.register(UINib(nibName: receiverCellIdentifier, bundle: nil), forCellWithReuseIdentifier: receiverCellIdentifier)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        self.title = person.name
        

        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    private func handleTimer() {
        let index = Int(arc4random_uniform(UInt32(self.text.count)))
        let content = self.text[index]
        
        let me = Person(avatar: nil, name: "me")
        let message = Message(content: content, sender: self.person, receiver: me, createdDate: Date())
        self.messages.append(message)
        self.collectionView.reloadData()
        let indexPath = IndexPath(row: messages.count-1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction private func sendPressed() {
        let me = Person(avatar: nil, name: "me")
        let message = Message(content: textView.text, sender: me, receiver: self.person, createdDate: Date())
        self.messages.append(message)
        self.collectionView.reloadData()
        let indexPath = IndexPath(row: messages.count-1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        textView.text = nil
    }

}

extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let item = messages[row]

        if item.sender.name == "me"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: senderCellIdentifier, for: indexPath) as! SenderCell
            cell.binding(data: item)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: receiverCellIdentifier, for: indexPath) as! ReceiverCell
        cell.binding(data: item)
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegate {
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        let item = messages[row]
        let text = item.content
        let width = UIScreen.main.bounds.width
        let labelWidth: CGFloat
        if item.sender.name == "me"{
            labelWidth = width
        } else {
            labelWidth = width - (16 + 40 + 16 + 8)
        }
        
        let constraintRect = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil)

        let height = ceil(boundingBox.height) + 16 + 8
        return CGSize(width: width, height: height)
    }
     
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }

 
}
