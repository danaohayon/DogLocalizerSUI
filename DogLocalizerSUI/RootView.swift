import SwiftUI

struct RootView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack {
                    // Main content based on current page
                    switch navigationManager.currentPage {
                    case "home":
                        HomePage()
                    case "about":
                        About()
                    default:
                        HomePage()
                    }
                    
                    // Side Menu
                    if navigationManager.isSideMenuOpen {
                        SideMenu()
                            .transition(.move(edge: .leading)) // Smooth transition for the menu
                            .environmentObject(navigationManager) // Pass the NavigationManager down
                    }

                }
    }
}
