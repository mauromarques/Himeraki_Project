//
//  favoritesModel.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 02/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let date: Date
    let categories: [Category]
}

struct Category: Codable {
    let name: String
    let prompt: String
}

struct CategoryData: Decodable {
    let name: String
    let prompt: [String]
}

var categoryNature = CategoryData(name: "Landscape", prompt: ["Forest", "Woods", "Lake", "Mountain"])
//var categoryAnimals = CategoryData(name: "Animals", prompt: ["Rat", "Horse", "Cow", "Dog"])
//var categoryFlowers = CategoryData(name: "Flowers", prompt: ["Daisy", "Rose", "Begonia", "Tulip"])
//var categoryWeather = CategoryData(name: "Weather", prompt: ["Sunny", "Rainy", "Cloudy", "Snow"])
//var categoryFantasy = CategoryData(name: "Fantasy", prompt: ["Mage", "Healer", "Warrior", "Summoner"])
//var categoryWeapon = CategoryData(name: "Weapon", prompt: ["Axe", "Magic wand", "Staff", "Sword"])
//var categoryLocation = CategoryData(name: "Location", prompt: ["Castle", "Throne room", "Enchanted woods", "Fairy domain"])
//var categoryElement = CategoryData(name: "Element", prompt: ["Light", "Darkness", "Fire", "Wind"])
//var categoryRace = CategoryData(name: "Race", prompt: ["Elf", "Human", "Troll", "Beast"])
//var categoryColor = CategoryData(name: "Color", prompt: ["Monochromatic", "Neon", "Black & white", "Warm colors"])
//var categoryOrientation = CategoryData(name: "Orientation", prompt: ["Portrait", "Landscape"])
//var categoryFrame = CategoryData(name: "Frame shape", prompt: ["Square", "Triangle", "Circle", "Oval"])
//var categoryArtStyle = CategoryData(name: "Art style", prompt: ["Manga", "Realism", "Chibi", "Cartoon"])
//var categoryFeeling = CategoryData(name: "Feelings", prompt: ["Depressive", "Heartwarming", "Happy", "Motivational"])
//var categoryFood = CategoryData(name: "Food", prompt: ["Spaghetti", "Lasagna", "French fries", "Burguer"])
//var categoryOccupation = CategoryData(name: "Occupation", prompt: ["Student", "Singer", "Dentist", "Dancer"])
//var categoryObject = CategoryData(name: "Object", prompt: ["Knife", "Plate", "Computer", "Vase"])
//var categoryFamily = CategoryData(name: "Family", prompt: ["Brother", "Grandma", "Husband", "Wife"])
//var categoryAction = CategoryData(name: "Action", prompt: ["Skating", "Talking", "Punching", "Teaching"])
//var categoryPersonality = CategoryData(name: "Personality", prompt: ["Rude", "Stressed", "Shy", "Happy"])
//var categorySkin = CategoryData(name: "Skin color", prompt: ["Dark", "Light brown", "Pale white", "Purple"])
//var categoryHair = CategoryData(name: "Hair style", prompt: ["Curly", "Wavy", "Short", "Straight"])
//var categoryFashion = CategoryData(name: "Fashion style", prompt: ["Cute", "Rocker", "Emo", "Girly"])
//var categoryHeight = CategoryData(name: "Height", prompt: ["Tall", "Short", "Midget", "Avatar"])
//var categoryAge = CategoryData(name: "Age", prompt: ["Newborn", "Baby", "Elder", "Teen"])

//var categoriesToGetPrompt = [categoryNature, categoryAnimals, categoryFlowers, categoryWeather, categoryFantasy, categoryWeapon, categoryLocation, categoryElement, categoryRace, categoryColor,categoryOrientation,categoryFrame,categoryArtStyle,categoryFeeling,categoryFood,categoryOccupation,categoryObject,categoryFamily,categoryAction,categoryPersonality,categorySkin,categoryHair,categoryFashion,categoryHeight,categoryAge]
var categoriesToGetPrompt = [categoryNature]

var categoriesToGenerate = [categoryNature]
