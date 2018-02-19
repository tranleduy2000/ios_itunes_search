//
//  APIControllerProtocol.swift
//  TableView
//
//  Created by Duy on 2/19/18.
//  Copyright © 2018 Duy. All rights reserved.
//

import Foundation

protocol  APIControllerProtocol  {
    //array of apps
    func didReceiveApiResults(results: Array<Dictionary<String, String>>)
}
