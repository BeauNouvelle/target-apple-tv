//
//  URLRequest+TargetHeaders.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation

extension URLRequest {

    func requestWithTargetHeaders() -> URLRequest {
        var updatedRequest = self
        updatedRequest.setValue("application/json, application/vnd.targetaustralia.v1+json", forHTTPHeaderField: "Accept")
        updatedRequest.setValue("mobile-app", forHTTPHeaderField: "x-target")
        updatedRequest.setValue((Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "", forHTTPHeaderField: "x-app-Version")
        return updatedRequest
    }

}
