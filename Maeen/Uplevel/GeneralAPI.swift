//
//  GeneralAPI.swift
//  Maeen
//
//  Created by yahya alshaar on 6/29/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

typealias NetworkFailureCompletion = ((Error) -> Swift.Void)
protocol ConsultationAPI {
    func consultationReplies(context: NSManagedObjectContext?, consultationId: Int32, success: @escaping (([ConsultationReply]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func addConsultationReply(message: String, consultationId: Int32, context: NSManagedObjectContext?,success: @escaping ((ConsultationReply) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func addConsultation(message: String, title: String, childId:Int32, context: NSManagedObjectContext?, success: @escaping ((Consultation) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
}

protocol AccountAPI {
    func auth(username: String, password: String, success: @escaping (([AnyHashable: Any]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func resetBy(mobile: String, success: @escaping (() -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func resetBy(email: String, success: @escaping (() -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func register(email: String, password: String, firstName: String, lastName: String, success: @escaping (([AnyHashable: Any]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func profile(context: NSManagedObjectContext?, success: @escaping ((User) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func resetPassword(current: String, new: String, confirmed: String, success: @escaping (() -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func contact(subject: String, message: String, success: @escaping (() -> Swift.Void), failure: @escaping ((Error) -> Swift.Void))
}

protocol CheckoutAPI {
    func subsecriptionInformation(packageId: Int32, gateway: String, childIds: [Int32], success: @escaping (([AnyHashable: Any]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func subscribe(packageId: Int32, childIds: [Int32], gateway: String, success: @escaping ((Gateway) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func paymentInformation(trackId: String, success: @escaping ((Payment) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
}
protocol IndexAPI {
    func advices(context: NSManagedObjectContext?, success: @escaping (([Advice], MetaResponseContext) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func advices(id: Int32, childId: Int32, success: @escaping (([AnyHashable: Any]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func childs(context: NSManagedObjectContext?, success: @escaping (([Child]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func subscriptions(context: NSManagedObjectContext?, success: @escaping (([Subscription]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func packages(context: NSManagedObjectContext?, success: @escaping (([Package]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func payments(context: NSManagedObjectContext?, success: @escaping (([Payment]) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
    func consultations(context: NSManagedObjectContext?, success: @escaping (([Consultation], MetaResponseContext) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
}

protocol ChildAPI {
    func addChild(attributes: Parameters, success: @escaping ((Child) -> Swift.Void), failure: @escaping ((Error) -> Swift.Void))
}

//    func profile(success: @escaping ((Profile) -> Swift.Void), failure: @escaping NetworkFailureCompletion)
