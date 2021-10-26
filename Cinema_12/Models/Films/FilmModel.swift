//
//  FilmModel.swift
//  Cinema_12
//
//  Created by Преподаватель on 22.10.2021.
//

import Foundation


struct FilmModel: Decodable{
    
    let movieId: String
    let name: String
    let description: String
    let age: String
    let images: [String]?
    let poster: String
    let tags: [Tag]
    
}

struct Tag: Decodable{
    let idTags: String
    let tagName: String
}
