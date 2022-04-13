//
//  MoyaAdapter.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import Foundation
import Moya

enum RequestType {
    case getAll
    case task(rover: String, camera: String, date: String, page: Int) // строка полученная после проверки всех элементов тюпла
}
extension RequestType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.nasa.gov/")!
    }
    var path: String {
        switch self {
        case .getAll:
            return "mars-photos/api/v1/rovers"
        case .task(let rover, _, _, _):
            return "mars-photos/api/v1/rovers/\(rover)/photos"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        var parameters = [String:Any]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        parameters["api_key"] = "SHCnTPB1IkATYOP5E4F57sIE6aNSu53fJP4CeVgr"
        switch self {
        case .getAll:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .task(_, let camera, let date, let page):
            if date != "all" {
                parameters["earth_date"] = date
            }
            parameters["page"] = page
            if camera != "all" {
                parameters["camera"] = camera
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

