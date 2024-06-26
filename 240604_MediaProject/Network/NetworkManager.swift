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
    

    func fetchTrending(api:TrendingAPI, completionHandler:@escaping (Movie?, String?) -> Void){
        AF.request(api.endPoint,
                   method: api.method,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: Movie.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, "네트워크 에러")
            }
        }
    }
    
    func requestCredit(api:TrendingAPI, completionHandler:@escaping (Credit?, String?)-> Void){
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: Credit.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value, nil)
                
            case .failure(let error):
                print(error)
                completionHandler(nil, "네트워크 에러")
            }
        }
    }
    
    func requestSearch(api:TrendingAPI, completionHandler:@escaping (MovieSearch?, String?)-> Void){
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: MovieSearch.self) { response in
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


