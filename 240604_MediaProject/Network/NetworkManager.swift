//
//  NetworkManager.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/22/24.
//

import Foundation
import Alamofire


final class NetworkManager{
    
    static let shared = NetworkManager()
    private init(){}

    func callRequest<T: Decodable>(api:TrendingAPI, model:T.Type, completionHandler:@escaping (T?, String?)-> Void){
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: model) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value, nil)
                
            case .failure(let error):
                print(error)
                completionHandler(nil, "네트워크 에러")
            }
        }
    }
    
}


