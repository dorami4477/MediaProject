//
//  TrendingAPI.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/26/24.
//

import Foundation
import Alamofire

enum TrendingAPI{
    case trending
    case search(query:String, page:Int)
    case credit(id:Int)
    case video(id:Int)
    
    var baseURL:String{
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint:URL{
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/day")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .credit(let id):
            return URL(string: baseURL + "movie/\(id)/credits")!
        case .video(let id):
            return URL(string: baseURL + "movie/\(id)/videos")!
        }
    }
    
    var header:HTTPHeaders{
        return ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    var parameter:Parameters{
        switch self {
        case .trending:
            return ["language":"ko-KR"]
        case .search(let query, let page):
            return ["language":"ko", "query": query, "page": page]
        case .credit:
            return [:]
        case .video(id: let id):
            return ["language":"ko"]
        }
    }
}
