//
//  EnvironmentValues+.swift
//  Harbour
//
//  Created by royal on 21/10/2021.
//

import SwiftUI
import Indicators

extension EnvironmentValues {
	// MARK: SceneErrorHandler
	private struct SceneErrorHandler: EnvironmentKey {
		static let defaultValue: SceneState.ErrorHandler? = nil
	}
	
	var sceneErrorHandler: SceneState.ErrorHandler? {
		get { self[SceneErrorHandler.self] }
		set { self[SceneErrorHandler.self] = newValue }
	}
	
	// MARK: UseContainerGridView
	private struct UseContainerGridView: EnvironmentKey {
		static let defaultValue: Bool = false
	}
	
	var useContainerGridView: Bool {
		get { self[UseContainerGridView.self] }
		set { self[UseContainerGridView.self] = newValue }
	}
	
	// MARK: UseColoredCOntainerCells
	private struct UseColoredContainerCells: EnvironmentKey {
		static let defaultValue: Bool = false
	}
	
	var useColoredContainerCells: Bool {
		get { self[UseColoredContainerCells.self] }
		set { self[UseColoredContainerCells.self] = newValue }
	}
}