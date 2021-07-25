//
//  DataParser.swift
//  TechAlchemy
//
//  Created by Sandeep Kumar on 16/07/21.
//

import Foundation
import Moya

extension TargetType {
    
    func parseModel(data: Data) -> Any? {
        switch self {
        case is TestEP:
            let endPoint = self as! TestEP
            switch endPoint {
            case .getAllEvents, .getEventDetail, .checkout:
                return JSONHelper<EventsData>().getCodableModel(data: data)
            case .purchase:
                return nil
            }
        default:
            return nil
        }
    }
}
