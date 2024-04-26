import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentPage: String = "home"
    @Published var isSideMenuOpen: Bool = false
}
