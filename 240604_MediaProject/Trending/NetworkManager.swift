//
//  NetworkManager.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/22/24.
//

import Foundation
import Alamofire


class NetworkManager{
    
    static let shared = NetworkManager()
    private init(){}
    
    func fetchTrending(completionHandler:@escaping (Movie) -> Void){
        let url = APIUrl.trending
        
        let header:HTTPHeaders = ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Movie.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestCredit(id:Int, completionHandler:@escaping (Credit)-> Void){
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        let header:HTTPHeaders = ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Credit.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}


