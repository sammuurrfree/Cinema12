//
//  Cover.swift
//  Cinema_12
//
//  Created by Преподаватель on 22.10.2021.
//

import Foundation

class Cover {
    
    func getCover() -> CoverModel?{
        var returnData: CoverModel?
        let semaphore = DispatchSemaphore (value: 0)
        
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/movies/cover")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            returnData = try? JSONDecoder().decode(CoverModel.self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return returnData
    }
    
}
