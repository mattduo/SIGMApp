//
//  Exercise.swift
//  SIGMA
//
//  Created by Matt on 3/6/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ExerciseData: Codable {
    var exercises: [Exercise]?
    
}

// MARK: - Exercise
struct Exercise: Codable {
    let bodyPart: BodyPart
    let equipment: Equipment
    let gifURL: String
    let id, name: String
    let target: Target

    enum CodingKeys: String, CodingKey {
        case bodyPart, equipment
        case gifURL = "gifUrl"
        case id, name, target
    }
}

enum BodyPart: String, Codable {
    case back = "back"
    case cardio = "cardio"
    case chest = "chest"
    case lowerArms = "lower arms"
    case lowerLegs = "lower legs"
    case neck = "neck"
    case shoulders = "shoulders"
    case upperArms = "upper arms"
    case upperLegs = "upper legs"
    case waist = "waist"
}

enum Equipment: String, Codable {
    case assisted = "assisted"
    case band = "band"
    case barbell = "barbell"
    case bodyWeight = "body weight"
    case bosuBall = "bosu ball"
    case cable = "cable"
    case dumbbell = "dumbbell"
    case ellipticalMachine = "elliptical machine"
    case ezBarbell = "ez barbell"
    case hammer = "hammer"
    case kettlebell = "kettlebell"
    case leverageMachine = "leverage machine"
    case medicineBall = "medicine ball"
    case olympicBarbell = "olympic barbell"
    case resistanceBand = "resistance band"
    case roller = "roller"
    case rope = "rope"
    case skiergMachine = "skierg machine"
    case sledMachine = "sled machine"
    case smithMachine = "smith machine"
    case stabilityBall = "stability ball"
    case stationaryBike = "stationary bike"
    case stepmillMachine = "stepmill machine"
    case tire = "tire"
    case trapBar = "trap bar"
    case upperBodyErgometer = "upper body ergometer"
    case weighted = "weighted"
    case wheelRoller = "wheel roller"
}

enum Target: String, Codable {
    case abductors = "abductors"
    case abs = "abs"
    case adductors = "adductors"
    case biceps = "biceps"
    case calves = "calves"
    case cardiovascularSystem = "cardiovascular system"
    case delts = "delts"
    case forearms = "forearms"
    case glutes = "glutes"
    case hamstrings = "hamstrings"
    case lats = "lats"
    case levatorScapulae = "levator scapulae"
    case pectorals = "pectorals"
    case quads = "quads"
    case serratusAnterior = "serratus anterior"
    case spine = "spine"
    case traps = "traps"
    case triceps = "triceps"
    case upperBack = "upper back"
}
