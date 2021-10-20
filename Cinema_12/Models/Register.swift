//
//  Register.swift
//  Cinema_12
//
//  Created by Преподаватель on 20.10.2021.
//

import Foundation


// Регистрация
class Registration{
    
    // Регистрация
    func register(email: String, password: String, firstName: String, lastName: String) -> Bool?{
        var result = ""
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\",\n  \"firstName\": \"\(firstName)\",\n  \"lastName\": \"\(lastName)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://cinema.areas.su/auth/register")!,timeoutInterval: 5)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            result = String(data: data, encoding: .utf8)!
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        if result == "Успешная регистрация"{
            return true
        }
        
        return false
    }
    
}
