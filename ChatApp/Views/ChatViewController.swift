//
//  ChatViewController.swift
//  123
//
//  Created by Gorkopenko Sergey on 02.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SVProgressHUD
import Photos
import Kingfisher

class ChatViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    
    private let db = Firestore.firestore()
    private var firstLoad = true
    private var pendingImage: Data?
    
    private var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension

        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        sendButtonOutlet.isEnabled = false
        
        loadMessages()
    }
    
    @IBAction func cameraButtonDidPress(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Источник", message: .none, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion:  nil)
            } else {
                let alert = UIAlertController(title: "Ошибка!", message: "Камера недоступна", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Фото/Видео", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion:  nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }

    private func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener {
                (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print(e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        print("received: \(snapshotDocuments)")
                        let msgs = snapshotDocuments.compactMap { doc -> Message? in
                            let data = doc.data()
                            
                            guard let messageSender = data[K.FStore.senderField] as? String,
                                  let messageDate = data[K.FStore.dateField] as? TimeInterval else { return nil }
                            
                            let messageBody = data[K.FStore.bodyField] as? String
                            let imageUrl = data[K.FStore.imageUrl] as? String
                            
                            let date = Date(timeIntervalSince1970: messageDate)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMM d, h:mm a"
                            let dateString = dateFormatter.string(from: date)
                            
                            let newMessage = Message(sender: messageSender, body: messageBody, date: dateString, imageUrl: imageUrl)
                            
                            return newMessage
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.messages = msgs
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: self.firstLoad)
                            if self.firstLoad {
                                self.firstLoad = false
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let messageSender = Auth.auth().currentUser?.email else { return }
        
        if let imageData = self.pendingImage {
            StorageManager.shared.uploadProfilePicture(with: imageData, filename: UUID().uuidString + ".jpg") { result in
                switch result {
                case .success(let url):
                    self.saveMessage(
                        text: self.messageTextField.text,
                        imageUrl: url,
                        sender: messageSender
                    )
                case .failure(let error):
                    print(error)
                }
            }
        } else if let messageBody = messageTextField.text {
            self.saveMessage(text: messageBody, imageUrl: nil, sender: messageSender)
        }
    }
    
    private func saveMessage(text: String?, imageUrl: String?, sender: String) {
        var data: [String: Any] = [
            K.FStore.senderField: sender,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]
        
        if let messageBody = text {
            data[K.FStore.bodyField] = messageBody
        }
        if let imageData = imageUrl {
            data[K.FStore.imageUrl] = imageData
        }
        
        db.collection(K.FStore.collectionName).addDocument(data: data) { error in
            guard error == nil else { print(error!); return }
            
            DispatchQueue.main.async {
                self.messageTextField.text = ""
                self.sendButtonOutlet.isEnabled = false
                self.pendingImage = nil
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.label.text = messages[indexPath.row].body
        
        cell.userName.text = messages[indexPath.row].sender
        cell.userName2.text = messages[indexPath.row].date
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.userName.text = messages[indexPath.row].sender
            
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(r: 77, g: 88, b: 99)
            cell.label.textColor = UIColor(r: 44, g: 55, b: 66)
        } else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(r: 44, g: 55, b: 66)
            cell.label.textColor = UIColor(r: 11, g: 22, b: 33)
        }

        //Image displaying
        if let imageUrl = message.imageUrl, let url = URL(string: imageUrl) {
            cell.configure(imageUrl: url)
        } else {
            cell.configure(imageUrl: nil)
        }
        
        return cell
    }
    
}

extension ChatViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 0.75)
        else { return }
        self.pendingImage = imageData
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if text.count == 1, string.isEmpty {
                sendButtonOutlet.isEnabled = false
            } else {
                sendButtonOutlet.isEnabled = true
            }
        } else {
            sendButtonOutlet.isEnabled = !string.isEmpty
        }
        return true
    }
    
}
