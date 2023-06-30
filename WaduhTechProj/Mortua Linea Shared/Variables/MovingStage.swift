//
//  MovingVariables.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 26/06/23.
//

import Foundation
import SwiftUI

protocol MovingStage: AnyObject {
    func stageTransition(_ stage: Int)
}
