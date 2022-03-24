//
//  Resource.swift
//  Pagination
//
//  Created by cemal tüysüz on 24.03.2022.
//

import Foundation

class Resource<T : Codable> {
        
    func fetchData(urlString: String, completion: @escaping (Result<T,Error>) -> Void){
        
        let urlBuilder = URLComponents(string: urlString)
         guard let url = urlBuilder?.url else { return }

         var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Token.getToken, forHTTPHeaderField: "Authorization")
        
        // or throw an errorc
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { completion(.failure(error)); return }
            completion( Result{ try JSONDecoder().decode(T.self, from: data!) })
        }.resume()
    }
}
