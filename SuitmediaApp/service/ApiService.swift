

//
//  ApiService.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import Foundation

class ApiService {
    private var dataTask : URLSessionDataTask?
    func getData(page : Int,per_page : Int, completion : @escaping (Result<Users, Error>) -> Void) {
        let dataGameUrl = "https://reqres.in/api/users?page=\(page)&per_page=\(per_page)"
        let newUrl = dataGameUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let url = URL(string: newUrl!) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(Users.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
