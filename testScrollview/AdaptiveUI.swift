//
//  AdaptiveUI.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 11/09/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case notifications = "Notifications"
    case profile = "Profile"

    var symbolImage: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .notifications: return "bell"
        case .profile: return "person.crop.circle"
        }
    }
}

struct AdaptiveUI: View {
    @State private var tabSelect: Tab = .home
    @State private var offset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    
    var body: some View {
        AdaptiveLayout { size, isLandScape in
            let sizeBarWidth: CGFloat = 250
            let layout = isLandScape ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(ZStackLayout(alignment: .leading))

            layout {
                SideBarView().frame(width: sizeBarWidth)
                    .offset(x: isLandScape ? 0 : offset - sizeBarWidth)
                
                TabView(selection: $tabSelect) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        AllView().tabItem {
                            Image(systemName: tab.symbolImage)
                            Text(tab.rawValue).fontWeight(.bold)
                        }.tag(tab)
                    }
                }.tabBarAppearance()
                .accentColor(.white)
                .overlay {
                    if !isLandScape {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .ignoresSafeArea()
                            .opacity(progress)
                    }
                }
                .offset(x: isLandScape ? 0 : offset)
            }
            .gesture(dragGesture(sizeBarWidth))
        }
    }
    
    private func dragGesture(_ sizeBarWidth: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { valueChange in
                let translation = valueChange.translation.width + lastDragOffset
                offset = max(min(translation, sizeBarWidth), 0)
                progress = offset / sizeBarWidth
            }
            .onEnded { valueEnd in
                let velocity = valueEnd.translation.width / 3
                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                    if (velocity + offset) > (sizeBarWidth * 0.3) {
                        offset = sizeBarWidth
                    } else {
                        offset = 0
                    }
                    progress = offset / sizeBarWidth
                }
                lastDragOffset = offset
            }
    }
}

struct AllView: View {
    var body: some View {
        ZStack { Color.white.ignoresSafeArea() }
    }
}

struct SideBarView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 6) {
                Image(uiImage: UIImage(named: "V4_DefaultUserAvater")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                Text("ThanhNQ")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text("@ThanhNQ")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                ForEach(SideBarAction.allCases, id: \.rawValue) { action in
                    sideBarActionButton(value: action)
                }
            }
            .padding(.leading, 20)
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    private func sideBarActionButton(value: SideBarAction) -> some View {
        Button(action: {
            // Define action here
        }) {
            HStack(spacing: 10) {
                Image(systemName: value.symbolImage)
                    .font(.title3)
                    .symbolRenderingMode(.monochrome)
                Text(value.rawValue)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical, 10)
            .contentShape(Rectangle())
        }
    }
}

enum SideBarAction: String, CaseIterable {
    case profile = "Profile"
    case premium = "Premium"
    case bookmark = "Bookmark"
    case job = "Job"
    case listTodo = "List To Do"
    case spaces = "Spaces"
    case makeMoney = "Make Money"
    
    var symbolImage: String {
        switch self {
        case .profile: return "person.crop.circle"
        case .premium: return "star.circle"
        case .bookmark: return "bookmark"
        case .job: return "briefcase"
        case .listTodo: return "checklist"
        case .spaces: return "square.grid.3x3"
        case .makeMoney: return "dollarsign.circle"
        }
    }
}

#Preview {
    AdaptiveUI()
}

struct AdaptiveLayout<Content: View>: View {
    @ViewBuilder var content: (CGSize, Bool) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let isLandScape = size.width > size.height
            content(size, isLandScape)
        }
    }
}
struct TabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(TabBarAppearance())
    }
}

struct TabBarAppearance: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.systemGray6
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = false
         return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension View {
    func tabBarAppearance() -> some View {
        self.modifier(TabBarModifier())
    }
}
