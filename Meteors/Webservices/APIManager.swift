//
//  APIClient.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    func webservice(url: String, method: HTTPMethod, encoding: ParameterEncoding, parameters: Parameters? = nil, headers:HTTPHeaders? = nil, completionHandler: @escaping (AFDataResponse<Data?>) -> Void) {
        let nasaAPIURL = "\(url)?$$app_token=U3NvS3mj2HV9kAXVJXc40sB1L"
        AF.request(nasaAPIURL, method: method,parameters: parameters, encoding: encoding, headers: headers).response (completionHandler: { (response) in
            completionHandler(response)
        })
    }
    
}
