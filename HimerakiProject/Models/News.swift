//
//  News.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 4/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import UIKit

struct News: Decodable {
    var topTitle: String?
    var pictureUrl: String?
    var title: String?
    var subtitle: String?
    var instaLink: String?
}

