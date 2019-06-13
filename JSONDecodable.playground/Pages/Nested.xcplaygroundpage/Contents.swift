//: [Basic](@previous)

import Foundation

let jsonString = """
{
"taskName": "Solor",
"taskNumber": 100105,
"startDate": "05-30-2019",
"isAssigned": false,
"task_mission": "this is to do something",
"taskCondition": {
"load": 5000,
"temperature": 50,
"pressure": 1200
}
}
"""
var jsonData = jsonString.data(using: .utf8)!



var task = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)

if let taskdic = task as? Dictionary<String, Any> {
    taskdic["taskName"]
}

struct ZZHCondition {
    let load: Int
    let temperature: Int
    let pressure: Int
}
extension ZZHCondition: Decodable {
    
}

struct ZZHTask {
    let taskName: String
    let taskNumber: Int
    let startDate: Date
    let isAssigned: Bool
    let taskMission: String
    let taskCondition: ZZHCondition
}

extension ZZHTask: Decodable {
    enum CodingKeys: String, CodingKey {
        case taskName
        case taskNumber
        case startDate
        case isAssigned
        case taskMission = "task_mission"
        case taskCondition 
    }
}

extension DateFormatter {
    static let customerFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.customerFormat)
task = try decoder.decode(ZZHTask.self, from: jsonData)
print("task : \(task)")
//: [Next](@next)
