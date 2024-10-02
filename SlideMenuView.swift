////
////  SlideMenuView.swift
////  testScrollview
////
////  Created by IT-17426-THANH on 12/09/2024.
////
//
//import SwiftUI
//
//struct SlideMenuView: View {
//    var body: some View {
//        GeometryReader {
//                 SlideMenu()  // Slide menu ở phía trên
//
//                 TabView {
//                     Text("Home View")
//                         .tabItem {
//                             Image(systemName: "house")
//                             Text("Home")
//                         }
//                     Text("Search View")
//                         .tabItem {
//                             Image(systemName: "magnifyingglass")
//                             Text("Search")
//                         }
//                 }
//             }
//         }
//    }
//
//
//#Preview {
//    SlideMenuView()
//}
//struct SideBarView: View {
//    var body: some View {
//        ScrollView(.vertical) {
//            LazyVStack(alignment: .leading, spacing: 6) {
//                // Ảnh đại diện người dùng
//                Image(uiImage: UIImage(named: "V4_DefaultUserAvater")!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 60, height: 60)
//                    .clipShape(Circle())
//                
//                // Tên người dùng và @username
//                Text("ThanhNQ")
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.black)
//                
//                Text("@ThanhNQ")
//                    .font(.caption2)
//                    .foregroundStyle(.gray)
//                
//                // Các mục trong menu
//                ForEach(SideBarAction.allCases, id: \.rawValue) { action in
//                    sideBarActionButton(value: action)
//                }
//            }
//            .padding(.leading, 20)
//        }
//        .background(Color.white) // Đặt nền cho menu
//    }
//    
//    // Hàm tạo nút cho từng mục trong menu
//    @ViewBuilder
//    private func sideBarActionButton(value: SideBarAction) -> some View {
//        Button(action: {
//            // Định nghĩa hành động khi nhấn nút ở đây
//        }) {
//            HStack(spacing: 10) {
//                Image(systemName: value.symbolImage)  // Icon của hành động
//                    .font(.title3)
//                Text(value.rawValue)  // Tên hành động
//                    .fontWeight(.semibold)
//                Spacer()
//            }
//            .padding(.vertical, 10)  // Khoảng cách trên dưới
//            .contentShape(Rectangle())  // Tạo vùng nhấn cho nút
//        }
//    }
//}
//struct SlideMenu: View {
//    @State private var offset: CGFloat = 0
//    @State private var lastDragOffset: CGFloat = 0
//    @State private var progress: CGFloat = 0
//    let menuWidth: CGFloat = 250
//    
//    var body: some View {
//        ZStack {
//            // Menu
//            SideBarView()
//                .frame(width: menuWidth)
//                .offset(x: offset - menuWidth)
//                .background(Color.white)
//            
//            // Overlay tối mờ khi menu được mở
//            Rectangle()
//                .fill(Color.black.opacity(progress * 0.4))
//                .ignoresSafeArea()
//                .onTapGesture {
//                    closeMenu()  // Đóng menu khi nhấn vào phần tối
//                }
//                .opacity(progress)
//        }
//        .gesture(dragGesture())  // Thêm cử chỉ kéo để mở/đóng menu
//    }
//    
//    // Cử chỉ kéo menu
//    private func dragGesture() -> some Gesture {
//        DragGesture()
//            .onChanged { value in
//                let translation = value.translation.width + lastDragOffset
//                offset = max(min(translation, menuWidth), 0)  // Kiểm soát giới hạn kéo
//                progress = offset / menuWidth  // Tính toán mức độ mở của menu
//            }
//            .onEnded { _ in
//                withAnimation(.easeOut) {
//                    if offset > menuWidth / 2 {
//                        openMenu()  // Mở menu nếu kéo quá nửa
//                    } else {
//                        closeMenu()  // Đóng menu nếu kéo chưa đủ xa
//                    }
//                }
//            }
//    }
//    
//    // Hàm mở menu
//    private func openMenu() {
//        withAnimation {
//            offset = menuWidth
//            progress = 1
//            lastDragOffset = offset
//        }
//    }
//    
//    // Hàm đóng menu
//    private func closeMenu() {
//        withAnimation {
//            offset = 0
//            progress = 0
//            lastDragOffset = offset
//        }
//    }
//}
