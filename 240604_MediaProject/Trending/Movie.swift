//
//  Movie.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import Foundation

struct Movie:Decodable{
    let page : Int
    let results : [MovieList]
}

struct MovieList:Decodable{
    let backdrop_path:String
    let id:Int
    let title :String
    let original_language:String
    let original_title:String
    let overview:String
    let poster_path:String
    let media_type:String
    let genre_ids:[Int]
    let popularity:Double
    let release_date:String
    let video:Bool
    let vote_average:Double
    let vote_count:Int
    
    var releaseDateString:String{
        let stringFormat = "yyyy-MM-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.locale = Locale(identifier: "ko")
        guard let tempDate = formatter.date(from: release_date) else {
            return ""
        }
        formatter.dateFormat = "yy/MM/dd"
        
        return formatter.string(from: tempDate)
    }
}
