//
//  UsersViewModel.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import Foundation

class UsersViewModel {
    private var apiService = ApiService()
    var users = [Data]()    
    
    func fetchUserData(page: Int, per_page : Int,  completion: @escaping (Users) -> Void) {
        apiService.getData(page: page, per_page: per_page) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.users = listOf.data
                completion(listOf)
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if users.count != 0 {
            return users.count
        }
        return 0
    }
    func cellForRowAt (indexPath : IndexPath) -> Data {
        return users[indexPath.row]
    }
}
