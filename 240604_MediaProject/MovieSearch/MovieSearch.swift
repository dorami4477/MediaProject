//
//  MovieSearch.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/11/24.
//

import Foundation

struct MovieSearch:Decodable{
    let page: Int
    var results: [SearchResult]
    let total_pages: Int
    let total_results: Int
}

struct SearchResult:Decodable{
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity:Double
    let poster_path: String?
    let release_date: String
    let title: String
    let vote_average:Double
    let vote_count: Int
}
