import SwiftUI
struct SideMenu: View {
    
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        ZStack(alignment: .leading){
            Color("panelColor")
                .edgesIgnoringSafeArea(.all)
                .frame(width: 330)
            Color(.brown.opacity(0.05))
                .edgesIgnoringSafeArea(.all)
                .frame(width: 330)
            VStack(alignment: .leading) {
                
                HStack{
                    ZStack {
                        // placeholder logo
                        Image(systemName:"pawprint.fill")
                            .font(.system( size: 20))
                            .fontWeight(.regular)
                            .foregroundColor(Color("titleColor").opacity(0.8))
                        Image(systemName: "pawprint")
                            .font(.system( size: 20))
                            .fontWeight(.regular)
                            .foregroundColor(Color("AccentColor"))
                    }
                    Text("Dog Localization Project")
                        .font(.custom("TrebuchetMS", size: 20))
                        .fontWeight(.bold)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.top, 5)
                
                HStack{
                    Image(systemName: "house")
                        .font(.system( size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("AccentColor"))
                    Text("Home")
                        .font(.custom("TrebuchetMS", size: 16))
                }.padding(.vertical)
                
                HStack{
                    Image(systemName: "rectangle.stack")
                        .font(.system( size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("AccentColor"))
                    Text("My photos")
                        .font(.custom("TrebuchetMS", size: 16))
                }.padding(.bottom)
                
                HStack{
                    Image(systemName: "gear")
                        .font(.system( size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("AccentColor"))
                    Text("Settings")
                        .font(.custom("TrebuchetMS", size: 16))
                }.padding(.bottom)
                
                HStack{
                    Image(systemName: "questionmark.circle")
                        .font(.system( size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("AccentColor"))
                    Text("Help")
                        .font(.custom("TrebuchetMS", size: 16))
                }.padding(.bottom)
                
                Spacer()
            }.offset(y: 20)
            .frame(width: 300)
            .foregroundColor(Color("AccentColor"))
            .padding(.horizontal)
            
            Button(action: {
                            withAnimation {
                                isMenuOpen = false
                            }
                        }) {
                            HStack{
                                Image(systemName:"xmark")
                                    .foregroundColor(Color("AccentColor"))
                                    .fontWeight(.bold)
                                    .font(.system(size: 16))
                                    .offset(y: 2)
                                Text("close")
                                    .font(.custom("TrebuchetMS", size: 18))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                        }.offset(x: 220, y: 380)
            
        }.offset(x: -30)

    }

}
