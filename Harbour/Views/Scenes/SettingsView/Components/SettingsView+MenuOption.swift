//
//  SettingsView+MenuOption.swift
//  Harbour
//
//  Created by royal on 09/06/2023.
//

import SwiftUI

internal extension SettingsView {
	struct MenuOption<Content: View>: View {
		let label: LocalizedStringResource
		let iconSymbolName: String
		let menuView: () -> Content

		init(_ label: LocalizedStringResource, iconSymbolName: String, menuView: @escaping () -> Content) {
			self.label = label
			self.iconSymbolName = iconSymbolName
			self.menuView = menuView
		}

		var body: some View {
			HStack {
				OptionIcon(symbolName: iconSymbolName)

				Text(label)
					.font(labelFontHeadline)

				Spacer()

				menuView()
			}
			.frame(minHeight: SettingsView.minimumCellHeight)
		}
	}
}