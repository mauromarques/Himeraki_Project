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

struct CategoryData: Decodable {
    let name: String
    let prompt: [String]
}
var categoryCharacter = CategoryData(name: "Character", prompt: ["Asta", "Yuno", "Noelle", "Charmy"])
var categoryAnimal = CategoryData(name: "Animal", prompt: ["Giraffe", "Bear", "Cat", "Dog"])
var categoryColors = CategoryData(name: "Colors", prompt: ["Blue", "Yellow", "Red", "Pink"])
var categoryActions = CategoryData(name: "Actions", prompt: ["Eating", "Catwalking", "Snapping", "Smilling"])
var categoryClothes = CategoryData(name: "Clothes", prompt: ["Dress", "Skirt", "Shirt", "High heels"])
var categoryFlowers = CategoryData(name: "Flowers", prompt: ["Daisy", "Roses", "Sunflower", "Tulip"])
var categoryWeapons = CategoryData(name: "Weapons", prompt: ["Whip", "Sword", "Shield", "Axe"])
var categoryScenarios = CategoryData(name: "Scenarios", prompt: ["Waterfall", "Woods", "City", "Lake"])

var categoriesToGetPrompt = [categoryAnimal, categoryColors, categoryActions, categoryClothes, categoryFlowers, categoryWeapons, categoryCharacter, categoryScenarios]
var categoriesToGenerate = [categoryAnimal]
