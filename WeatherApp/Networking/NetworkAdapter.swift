//
//  NetworkAdapter.swift
//  TechAlchemy
//
//  Created by Sandeep Kumar on 16/07/21.
//

import Foundation
import Moya

extension TargetType {
    func provider<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    }
    
    func request(success successCallBack: @escaping (Any?) -> Void, error errorCallBack: ((String?) -> Void)? = nil) {
        
        provider().request(self) { (result) in
            
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200, 201:
                    let model = self.parseModel(data: response.data)
                    successCallBack(model)
                case 401: // Session Expire
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        errorCallBack?(/(json?["message"] as? String))
                    } catch {
                        errorCallBack?(error.localizedDescription)
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                default:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        errorCallBack?(/(json?["message"] as? String))
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        
                    } catch {
                        errorCallBack?(error.localizedDescription)
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                }
            case .failure(let error):
                Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                errorCallBack?(error.localizedDescription)
            }
        }
        
    }
}
