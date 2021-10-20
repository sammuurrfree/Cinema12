//
//  Authorization.swift
//  Cinema_12
//
//  Created by Преподаватель on 20.10.2021.
//

import Foundation

// Модель для авторизации
struct AuthModel: Decodable{
    let token: Int
}

//Авторизация
class Authorization{
    
    //Авторизация
    func login(email: String, password: String) -> String{
        var result = ""
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/login")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            
            let authModel = try? JSONDecoder().decode(AuthModel.self, from: data)
            
            if authModel == nil{
                result = String(data: data, encoding: .utf8)!
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return result
    }
    
}
