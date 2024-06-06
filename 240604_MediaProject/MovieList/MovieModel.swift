//
//  MovieModel.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/5/24.
//

import Foundation

// MARK: - Welcome10
struct MovieModel : Codable{
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult : Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList : Codable{
    let rank:String
    let openDt:String
    let movieNm:String
}




