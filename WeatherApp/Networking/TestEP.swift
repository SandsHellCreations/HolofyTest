//
//  TestEP.swift
//  TechAlchemy
//
//  Created by Sandeep Kumar on 16/07/21.
//

import Foundation
import Moya

enum TestEP {
    case getAllEvents
    case getEventDetail(id: Int?)
    case checkout(id: Int?)
    case purchase(id: Int?, dateTime: String?, purchaseAmount: Double?, paymentMethod: String?)
}

extension TestEP: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL.init(string: APIConstants.basepath)!
    }
    
    var path: String {
        switch self {
        case .getAllEvents:
            return APIConstants.allEvents
        case .getEventDetail:
            return APIConstants.eventDetails
        case .checkout:
            return APIConstants.checkout
        case .purchase:
            return APIConstants.purchase
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllEvents,
             .getEventDetail,
             .checkout:
            return .get
        case .purchase:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllEvents,
             .getEventDetail,
             .checkout:
            return Task.requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.queryString)
        case .purchase:
            return Task.requestParameters(parameters: parameters ?? [:], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json",
                "Authorization" : "Bearer \(APIConstants.authToken)"]
    }
    
    private var parameters: [String: Any]? {
        switch self {
        case .getAllEvents:
            return [:]
        case .getEventDetail(let id), .checkout(let id):
            return ["id" : /id]
        case .purchase(let id, let dateTime, let purchaseAmount, let paymentMethod):
            let inputs = ["eventId" : /id, "dateTime" : /dateTime, "purchaseAmount" : /purchaseAmount, "paymentMethodType" : /paymentMethod] as [String : Any]
            return ["purchase": inputs]
        }
    }
}
