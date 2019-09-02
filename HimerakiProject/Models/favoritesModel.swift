//
//  favoritesModel.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 02/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation

struct Favorite: Decodable {
    let date: Date
    let categories: [Category]
}

struct Category: Decodable {
    let name: String
    let prompt: String
}
