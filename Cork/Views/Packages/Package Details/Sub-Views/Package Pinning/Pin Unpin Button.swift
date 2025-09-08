//
//  Pin Unpin Button.swift
//  Cork
//
//  Created by David Bureš - P on 09.07.2025.
//

import SwiftUI
import ButtonKit

struct PinUnpinButton: View
{
    @Environment(AppState.self) var appState: AppState
    @Environment(BrewPackagesTracker.self) var brewPackagesTracker: BrewPackagesTracker
    
    var package: BrewPackage
    
    var body: some View
    {
        if package.type == .formula
        {
            AsyncButton
            {
                await package.performPinnedStatusChangeAction(appState: appState, brewPackagesTracker: brewPackagesTracker)
            } label: {
                var buttonText: LocalizedStringKey
                {
                    return package.isPinned ? "package-details.action.unpin-version-\(package.versions.formatted(.list(type: .and)))" : "package-details.action.pin-version-\(package.versions.formatted(.list(type: .and)))"
                }
                
                var buttonIcon: String
                {
                    return package.isPinned ? "pin.slash" : "pin"
                }
                
                Label(buttonText, systemImage: buttonIcon)
            }
            .asyncButtonStyle(.leading)
            .disabledWhenLoading()
        }
    }
}
