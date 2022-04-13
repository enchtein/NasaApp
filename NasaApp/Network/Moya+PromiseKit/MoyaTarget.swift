//
//  MoyaTarget.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import Foundation
import PromiseKit
import Moya


struct Provider {
    static private let provider = MoyaProvider<RequestType>()
    
    static func performReguest(rover: String, camera: String, date: String, page: Int) -> Promise<PhotoInfo> {
        return Promise { seal in
            provider.request(.task(rover: rover, camera: camera, date: date, page: page)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let resp = try JSONDecoder().decode(PhotoInfo.self, from: moyaResponse.data)
                        seal.fulfill(resp)
                    } catch let error {
                        print(error)
                        seal.reject(error)
                    }
                // you can also have some logic and call reject() here
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
    
    static func performRequestAll() -> Promise<AllRoversInfo> {
        return Promise { seal in
            provider.request(.getAll) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let resp = try JSONDecoder().decode(AllRoversInfo.self, from: moyaResponse.data)
                        seal.fulfill(resp)
                    } catch let error {
                        print(error)
                        seal.reject(error)
                    }
                // you can also have some logic and call reject() here
                case let .failure(error):
                    seal.reject(error)
                }
            }
            
        }
    }
}
