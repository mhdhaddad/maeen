//
//  Lookup.swift
//  Maeen
//
//  Created by yahya alshaar on 6/29/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

enum LookupError: Error {
    case invalidData
    case networkIssue
}

class Lookup {
    class var host: String {
        return "maeen.org"
    }
    
    static let shared = Lookup()
    
    class var headers: HTTPHeaders {
        return [
            "Authorization": app.account.token ?? "",
            "X-Requested-With": "XMLHttpRequest",
            "platform": "iphone 1.1.1"
        ]
    }
    
    class func create(path: String) -> String {
        return "https://www.\(Lookup.host)/api/v3/\(path)"
    }
    
    enum APIError: Error {
        case invalidResponse
    }
    
}
extension Lookup: ConsultationAPI {
    func addConsultationReply(message: String, consultationId: Int32, context: NSManagedObjectContext?, success: @escaping ((ConsultationReply) -> Void), failure: @escaping NetworkFailureCompletion) {
        
        let parameters: Parameters = [
            "message": message,
            "consultation_id": consultationId
        ]
        
        
        Alamofire.request(Lookup.create(path: "consultation/reply"), method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any], let reply = ConsultationReply(attributes: attributes, insertInto: context) else {
                    return
                }
                success(reply)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func addConsultation(message: String, title: String, childId: Int32, context: NSManagedObjectContext?, success: @escaping ((Consultation) -> Void), failure: @escaping NetworkFailureCompletion) {
        
        let parameters: Parameters = [
            "title": title,
            "message": message,
            "child_id": childId
        ]

        
        Alamofire.request(Lookup.create(path: "consultation/create"), method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any], let reply = Consultation(attributes: attributes, insertInto: context) else {
                    return
                }
                success(reply)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func consultationReplies(context: NSManagedObjectContext?, consultationId: Int32, success: @escaping (([ConsultationReply]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "consultation/\(consultationId)"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                if let data = value as? [[AnyHashable:Any]] {
                    var replies: [ConsultationReply] = []
                    replies.reserveCapacity(data.count)
                    
                    for attributes in data {
                        if let reply = ConsultationReply(attributes: attributes, insertInto: context) {
                            replies.append(reply)
                        }
                    }
                    
                    success(replies)
                }else {
                    success([])
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}

extension Lookup: AccountAPI {
    func contact(subject: String, message: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        let parameters = [
            "subject": subject,
            "message": message,
            "email": app.account.user?.email ?? "",
            "phone": app.account.user?.phone ?? "",
            "full_name": app.account.user?.name ?? ""
            
        ]
        Alamofire.request(Lookup.create(path: "contact"), method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(_ ):
                success()
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func resetPassword(current: String, new: String, confirmed: String, success: @escaping (() -> Void), failure: @escaping NetworkFailureCompletion) {
        let parameters = [
            "password": new,
            "password_confirmation": confirmed,
            "current_password": current]
        
        Alamofire.request(Lookup.create(path: "profile/password"), method: .post, parameters: parameters, headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success( _):
                success()
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func profile(context: NSManagedObjectContext?, success: @escaping ((User) -> Void), failure: @escaping NetworkFailureCompletion) {
        Alamofire.request(Lookup.create(path: "profile"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any], let user = User(attributes: attributes, insertInto: app.handler.moc) else  {
                    failure(LookupError.invalidData)
                    return
                }
                success(user)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func register(email: String, password: String, firstName: String, lastName: String, success: @escaping (([AnyHashable: Any]) -> Void), failure: @escaping ((Error) -> Void)) {
        let parameters = [
            "name": "\(firstName) \(lastName)",
            "email": email,
            "password": password
        ]
        
        Alamofire.request(Lookup.create(path: "registration"), method: .post, parameters: parameters, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any] else {
                    failure(APIError.invalidResponse)
                    return
                }
                success(attributes)
            case .failure(let error):
                guard let json = response.value as? [AnyHashable: Any], let object = json["error"] as? [AnyHashable: Any], let message = object["message"] as? String else {
                    failure(error)
                    return
                }
                let error = NSError(domain: message, code: 0, userInfo: nil)
                failure(error)
            }
        }
    }
    
    func resetBy(mobile: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "password/mobile"), method: .post, parameters: ["mobile": mobile], encoding: JSONEncoding(options: []), headers: nil).validate().responseJSON { (response) in
            
        }
    }
    
    func resetBy(email: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "password/email"), method: .post, parameters: ["email": email], encoding: JSONEncoding(options: []), headers: nil).validate().responseJSON { (response) in
            
        }
    }
    
    func auth(username: String, password: String, success: @escaping (([AnyHashable: Any]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "authentication"), method: .post, parameters: ["username": username, "password": password], headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any] else {
                    failure(APIError.invalidResponse)
                    return
                }
                success(attributes)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}

extension Lookup: IndexAPI {
    func advices(context: NSManagedObjectContext?, success: @escaping (([Advice], MetaResponseContext) -> Void), failure: @escaping NetworkFailureCompletion) {
        Alamofire.request(Lookup.create(path: "advice"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [AnyHashable: Any], let data = json["data"] as? [[AnyHashable: Any]] else {
                    failure(LookupError.invalidData)
                    return
                }
                var advices: [Advice] = []
                advices.reserveCapacity(data.count)
                
                for attributes in data {
                    if let advice = Advice(attributes: attributes, insertInto: context) {
                        advices.append(advice)
                    }
                }
                success(advices, MetaResponseContext(attributes: json))
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func consultations(context: NSManagedObjectContext?, success: @escaping (([Consultation], MetaResponseContext) -> Void), failure: @escaping NetworkFailureCompletion) {
        Alamofire.request(Lookup.create(path: "consultation"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [AnyHashable: Any], let data = json["data"] as? [[AnyHashable: Any]] else {
                    failure(LookupError.invalidData)
                    return
                }
                
                var consultations: [Consultation] = []
                consultations.reserveCapacity(data.count)
                
                for attributes in data {
                    if let consultation = Consultation(attributes: attributes, insertInto: context) {
                        consultations.append(consultation)
                    }
                }
                
                success(consultations, MetaResponseContext(attributes: json))
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func subscriptions(context: NSManagedObjectContext?, success: @escaping (([Subscription]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "subscription"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let data = value as? [[AnyHashable: Any]] else {
                    success([])
                    return
                }
                
                var subscriptions: [Subscription] = []
                subscriptions.reserveCapacity(data.count)
                
                for attributes in data {
                    if let package = Subscription(attributes: attributes, insertInto: context) {
                        subscriptions.append(package)
                    }
                }
                success(subscriptions)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func payments(context: NSManagedObjectContext?, success: @escaping (([Payment]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "payment"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let data = value as? [[AnyHashable: Any]] else {
                    success([])
                    return
                }
                
                var payments: [Payment] = []
                payments.reserveCapacity(data.count)
                
                for attributes in data {
                    if let payment = Payment(attributes: attributes, insertInto: context) {
                        payments.append(payment)
                    }
                }
                
                success(payments)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func packages(context: NSManagedObjectContext?,success: @escaping (([Package]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "package"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let data = value as? [[AnyHashable: Any]] else {
                    success([])
                    return
                }
                
                var packages: [Package] = []
                packages.reserveCapacity(data.count)
                
                for attributes in data {
                    if let package = Package(attributes: attributes, insertInto: context) {
                        packages.append(package)
                    }
                }
                success(packages)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
    func childs(context: NSManagedObjectContext?, success: @escaping (([Child]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "child"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [AnyHashable: Any], let data = json["data"] as? [[AnyHashable: Any]] else {
                    success([])
                    return
                }
                
                var childs: [Child] = []
                childs.reserveCapacity(childs.count)
                
                for attributes in data {
                    if let child = Child(attributes: attributes, insertInto: context) {
                        childs.append(child)
                    }
                }
                
                success(childs)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func advices(id: Int32, childId: Int32, success: @escaping (([AnyHashable : Any]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "advice/\(id)/child/\(childId)"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any] else {
                    success([:])
                    return
                }
                success(attributes)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
extension Lookup: CheckoutAPI {
    func paymentInformation(trackId: String, success: @escaping ((Payment) -> Void), failure: @escaping NetworkFailureCompletion) {
        Alamofire.request(Lookup.create(path: "subscription/\(trackId)"), method: .get, parameters: nil, encoding: JSONEncoding(options: []), headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any], let payment = Payment(attributes: attributes, insertInto: app.handler.moc) else {
                    failure(LookupError.invalidData)
                    return
                    
                }
                success(payment)
            case .failure(let error):
                
                failure(error)
            }
        }
    }
    
    //    func paymentInformation(trackId: Int32, success: @escaping ((Payment) -> Void), failure: @escaping ((Error) -> Void)) throws {
    //
    //    }
    
    
    func subscribe(packageId: Int32, childIds: [Int32], gateway: String, success: @escaping ((Gateway) -> Void), failure: @escaping ((Error) -> Void)) {
        let param: Parameters = [
            "package_id": packageId,
            "gateway": gateway,
            "child_ids[]": childIds
        ]
        
        Alamofire.request(Lookup.create(path: "subscription"), method: .post, parameters: param, headers: Lookup.headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any], let gateway = Gateway(attributes: attributes) else {
                    failure(LookupError.invalidData)
                    return
                }
                
                success(gateway)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func subsecriptionInformation(packageId: Int32, gateway: String, childIds: [Int32], success: @escaping (([AnyHashable : Any]) -> Void), failure: @escaping ((Error) -> Void)) {
        let param: Parameters = [
            "package_id": packageId,
            "gateway": gateway,
            "child_ids[]": childIds
        ]
        
        Alamofire.request(Lookup.create(path: "subscription/price"), method: .post, parameters: param, headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let attributes = value as? [AnyHashable: Any] else {
                    success([:])
                    return
                }
                success(attributes)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
extension Lookup: ChildAPI {
    func addChild(attributes: Parameters, success: @escaping ((Child) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(Lookup.create(path: "child"), method: .post, parameters: attributes, headers: Lookup.headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [AnyHashable: Any], let child = Child(attributes: json, insertInto: app.handler.moc) else {
                    failure(LookupError.invalidData)
                    return
                }
                success(child)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}
