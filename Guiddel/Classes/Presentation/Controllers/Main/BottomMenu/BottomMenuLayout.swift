//
//  BottomMenuLayout.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FloatingPanel

public class BottomMenuLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .half]
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 19.0
        case .half: return 250.0
        default: return nil
        }
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}

