//
//  Film.swift
//  Cinema_12
//
//  Created by Преподаватель on 22.10.2021.
//

import Foundation

class Film{
    
    enum filmcCtegory: String{
        case new = "filmcCtegory";
        case inTrend = "inTrend";
        case forMe = "forMe"
    }
    
    func getAllFilms(filter: filmcCtegory = .inTrend) -> [FilmModel]? {
        var films: [FilmModel]?
        
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies?filter=\(filter)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            films = try? JSONDecoder().decode([FilmModel].self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return films
    }
    
}
