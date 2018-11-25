//
//  ConsultationDetailsViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 9/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit
import MessageKit
import CoreData

class ConsultationDetailsViweController: MessagesViewController {
    
    
    var childId: Int32!
    
    let _currentSender = Sender(id: "\(app.account.user!.id)", displayName: "you".localized())
    var consultation: Consultation?
    
    var fetchedResultsController: NSFetchedResultsController<ConsultationReply>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if title == nil {
            title = consultation?.title
        }
        // setup
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.sendButton.tintColor = UIColor.tint
        
        iMessage()
        
        if let consultation = consultation {
            
            initializeFetchedResultsController(consultation: consultation)
            
            Lookup.shared.consultationReplies(context: app.handler.moc, consultationId: consultation.id, success: { (replies) in
                print("\(replies.count)")
                try? app.handler.moc.save()

                self.messagesCollectionView.scrollToBottom()
            }) { (error) in
                
            }
        }
    }
    
    func initializeFetchedResultsController(consultation: Consultation) {
        if self.consultation == nil {
            self.consultation = consultation
        }
        
        let request: NSFetchRequest<ConsultationReply> = ConsultationReply.fetchRequest()
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.predicate = NSPredicate(format: "consultationId == %i", consultation.id)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 25
        
        let moc = app.handler.moc
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func iMessage() {
        defaultStyle()
        messageInputBar.isTranslucent = false
        messageInputBar.backgroundView.backgroundColor = .white
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: true)
        messageInputBar.setStackViewItems([messageInputBar.sendButton], forStack: .right, animated: true)
        messageInputBar.sendButton.imageView?.backgroundColor = UIColor.tint
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: true)
        messageInputBar.sendButton.image = #imageLiteral(resourceName: "chatSend")
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
        messageInputBar.sendButton.backgroundColor = .clear
        messageInputBar.textViewPadding.right = -38
    }
    
    func defaultStyle() {
        let newMessageInputBar = MessageInputBar()
        newMessageInputBar.sendButton.tintColor = UIColor.tint
        newMessageInputBar.delegate = self
        messageInputBar = newMessageInputBar
        reloadInputViews()
    }
    
    func messageIndexPath(_ indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: indexPath.section, section: 0)
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let messagesToFetch = 10  //UserDefaults.standard.mockMessagesCount()
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            SampleData.shared.getMessages(count: messagesToFetch) { messages in
//                DispatchQueue.main.async {
//                    self.messageList = messages
//                    self.messagesCollectionView.reloadData()
//                    self.messagesCollectionView.scrollToBottom()
//                }
//            }
//        }
//
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        messagesCollectionView.messageCellDelegate = self
//        messageInputBar.delegate = self
//
//        messageInputBar.sendButton.tintColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
//        scrollsToBottomOnKeybordBeginsEditing = true // default false
//        maintainPositionOnKeyboardFrameChanged = true // default false
//
//        messagesCollectionView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(ConversationViewController.loadMoreMessages), for: .valueChanged)
//
//        navigationItem.rightBarButtonItems = [
//            UIBarButtonItem(image: UIImage(named: "ic_keyboard"),
//                            style: .plain,
//                            target: self,
//                            action: #selector(ConversationViewController.handleKeyboardButton)),
//            UIBarButtonItem(image: UIImage(named: "ic_typing"),
//                            style: .plain,
//                            target: self,
//                            action: #selector(ConversationViewController.handleTyping))
//        ]
//    }
    
    func createConsultation(message: String, title: String, childId: Int32) {
        Lookup.shared.addConsultation(message: message, title: title, childId: childId, context: app.handler.moc, success: { [weak self] (consultation) in
            try! consultation.messages.first?.managedObjectContext?.save()
            
            guard let `self` = self else {
                return
            }
            
            if self.consultation == nil {
                self.initializeFetchedResultsController(consultation: consultation)
                self.messagesCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    func addReply(_ message: String, for consultation: Consultation){
        Lookup.shared.addConsultationReply(message: message, consultationId: consultation.id, context: app.handler.moc, success: {[weak self] (reply) in
        
        }) { (error) in
            //Handle Error
        }
    }
}

extension ConsultationDetailsViweController: MessagesDataSource {
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
//        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController?.sections?[0].numberOfObjects ?? 0
    }
    func currentSender() -> Sender {
        return _currentSender
    }
    
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
//    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return fetchedResultsController.object(at: IndexPath(item: indexPath.section, section: 0)).message
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = message.sentDate.displayed ?? ""
        return NSAttributedString(string: dateString, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

extension ConsultationDetailsViweController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    
    private func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section % 3 == 0 {
            return 10
        }
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
}
extension ConsultationDetailsViweController: MessagesDisplayDelegate {
    
}
extension ConsultationDetailsViweController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        // Each NSTextAttachment that contains an image will count as one empty character in the text: String
        
        for component in inputBar.inputTextView.components {
            
            if let text = component as? String {
                
                let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.blue])
                
                if let consultation = consultation {
                    addReply(text, for: consultation)
                }else {
                    createConsultation(message: text, title: title ?? "consultation".localized(), childId: childId)
                }
            
            }
        }
        
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom()
    }

}
extension ConsultationDetailsViweController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        messagesCollectionView.reloadData()
    }
}
