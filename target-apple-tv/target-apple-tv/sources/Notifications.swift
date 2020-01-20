//
//  Notifications.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation


public let ApplicationDidUpdateConfigFromAPI = NSNotification.Name("ApplicationDidUpdateConfigFromAPI")
public let NetworkDidBecomeReachable = NSNotification.Name("NetworkDidBecomeReachable")

public let TargetWebRequestDidFailToLoadCSS = NSNotification.Name("TargetWebRequestDidFailToLoadCSS")
public let TargetWebRequestDidFailToLoadJS = NSNotification.Name("TargetWebRequestDidFailToLoadJS")
public let TargetWebRequestDidLoadXMLHttpRequest = NSNotification.Name("TargetWebRequestDidLoadXMLHttpRequest")
public let TargetWebRequestDidFailWithHTTPError = NSNotification.Name("TargetWebRequestDidFailWithHTTPError")
