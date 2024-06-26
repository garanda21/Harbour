//
//  EnvironmentValues+.swift
//  Harbour
//
//  Created by royal on 23/07/2022.
//  Copyright © 2023 shameful. All rights reserved.
//

import IndicatorsKit
import KeychainKit
import OSLog
import PortainerKit
import SwiftUI

// MARK: - ErrorHandler

extension EnvironmentValues {
	private struct ErrorHandlerEnvironmentKey: EnvironmentKey {
		static let defaultValue: ErrorHandler = .init { error in
//			assertionFailure("`errorHandler` has been called, but none is attached!")
			os_log(.error, log: .default, "Error: \(error, privacy: .public)")
		}
	}

	/// An action that can handle provided error.
	var errorHandler: ErrorHandler {
		get { self[ErrorHandlerEnvironmentKey.self] }
		set { self[ErrorHandlerEnvironmentKey.self] = newValue }
	}
}

// MARK: - ShowIndicator

extension EnvironmentValues {
	private struct ShowIndicatorEnvironmentKey: EnvironmentKey {
		static let defaultValue: IndicatorPresentable.PresentIndicatorAction = { indicator in
			assertionFailure("`showIndicator` has been called, but none is attached! Indicator: \(indicator)")
		}
	}

	/// An action that presents a provided indicator.
	var presentIndicator: IndicatorPresentable.PresentIndicatorAction {
		get { self[ShowIndicatorEnvironmentKey.self] }
		set { self[ShowIndicatorEnvironmentKey.self] = newValue }
	}
}

// MARK: - Logger

extension EnvironmentValues {
	private struct LoggerEnvironmentKey: EnvironmentKey {
		static let defaultValue = Logger(.app)
	}

	/// Logging subsystem attached to this view.
	var logger: Logger {
		get { self[LoggerEnvironmentKey.self] }
		set { self[LoggerEnvironmentKey.self] = newValue }
	}
}

// MARK: - PortainerServerURL

extension EnvironmentValues {
	var portainerServerURL: URL? {
		PortainerStore.shared.serverURL
	}
}

// MARK: - PortainerSelectedEndpoint

extension EnvironmentValues {
	var portainerSelectedEndpoint: Endpoint? {
		PortainerStore.shared.selectedEndpoint
	}
}

// MARK: - ParentShape

extension EnvironmentValues {
	private struct ParentShapeEnvironmentKey: EnvironmentKey {
		static let defaultValue: AnyShape? = nil
	}

	/// Shape of the parent view.
	var parentShape: AnyShape? {
		get { self[ParentShapeEnvironmentKey.self] }
		set { self[ParentShapeEnvironmentKey.self] = newValue }
	}
}

// MARK: - NavigationPath

extension EnvironmentValues {
	private struct NavigationPathEnvironmentKey: EnvironmentKey {
		static let defaultValue = NavigationPath()
	}

	/// `NavigationPath` for this view stack.
	var navigationPath: NavigationPath {
		get { self[NavigationPathEnvironmentKey.self] }
		set { self[NavigationPathEnvironmentKey.self] = newValue }
	}
}
