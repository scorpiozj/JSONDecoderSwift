import UIKit

let jsonString = """
{
"taskName": "Solor",
"taskNumber": 100105,
"startDate": "05-30-2019",
"isAssigned": false,
"task_mission": "this is to do something"
}
"""
var jsonData = jsonString.data(using: .utf8)!



var task = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)

if let taskdic = task as? Dictionary<String, Any> {
    taskdic["taskName"]
}

struct ZZHTask {
    let taskName: String
    let taskNumber: Int
    let startDate: Date
    let isAssigned: Bool
    let taskMission: String
}

extension ZZHTask: Decodable {
    enum CodingKeys: String, CodingKey {
        case taskName
        case taskNumber
        case startDate
        case isAssigned
        case taskMission = "task_mission"
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
//: [Next](@next)
