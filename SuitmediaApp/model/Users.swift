//
//  Users.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import Foundation

// MARK: - Welcome
struct Users: Codable {
    let page, perPage, total, totalPages: Int
    let data: [Data]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Data: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
    let latLng : [LatLng] = [LatLng]()

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct LatLng {
    let latitude : Double
    let longide : Double
}


// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
