//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Marquis on 16/1/31.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation

public class CurrentViewModel {

    weak var delegate: CurrentViewDelegate?
    var current : Current?
    //Mark: - Initialization
    init(delegate: CurrentViewDelegate, weatherDictionary: NSDictionary){
        self.delegate = delegate
    }
    
    func initData(){}
}

protocol CurrentViewDelegate: class{

}

