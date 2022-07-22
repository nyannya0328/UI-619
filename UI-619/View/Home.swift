//
//  Home.swift
//  UI-619
//
//  Created by nyannyan0328 on 2022/07/22.
//

import SwiftUI

struct Home: View {
    @State var headerHeight : CGFloat = 0
    @State var hederOffet : CGFloat = 0
    @State var lastHederOffset : CGFloat = 0
    @State var direction : Direction = .none
    
    @State var shiftOffset : CGFloat = 0
  
    
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
        ThamnailView()
                .padding(.top,headerHeight)
                .offsetY { previous, current in
                    
                    if previous > current{
                        
                        if direction != .up && current < 0{
                            
                            shiftOffset = current - hederOffet
                            direction = .up
                            lastHederOffset = hederOffet
                            
                        }
                        let offset = current < 0 ? (current - shiftOffset) : 0
                        
                        hederOffet = (-offset < headerHeight ? (offset < 0 ? offset : 0) : -headerHeight)
                        
                    }
                    else{
                        
                        if direction != .down{
                            
                            shiftOffset = current
                            direction = .down
                            lastHederOffset = hederOffet
                        }
                        
                        let offset = hederOffet + (current - shiftOffset)
                        hederOffet = (offset > 0 ? 0 : offset)
                        
                    }
                    
            
                }
            
            
            
            
        }
       
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment : .top) {
            
            TopHederView()
                .anchorPreference(key : HeaderBounsKey.self, value: .bounds) {$0
                
                    
                 
                }
                .overlayPreferenceValue(HeaderBounsKey.self) { value in
                    GeometryReader{proxy in
                        
                        if let anchor = value{
                            
                            
                            Color.clear
                                .onAppear{
                                    
                                    headerHeight = proxy[anchor].height
                                }
                        }
                        
                    }
                    
                }
                .offset(y:-hederOffet < headerHeight ? hederOffet : (hederOffet < 0 ? hederOffet : 0))
            
            
        }
        .ignoresSafeArea(.all,edges: .top)
        
    }
    
    @ViewBuilder
    func TopHederView()->some View{
        
        
        VStack{
            VStack(spacing:10){
                
                HStack{
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                         .frame(width: 60,height: 60)
                    
                    
                    
                    HStack{
                        let topName : [String] = ["Notifications","Search","Shareplay"]
                        
                        
                        ForEach(topName,id:\.self){name in
                            
                            Image(name)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30,height: 30)
                            
                            
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Image("Pic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                             .frame(width: 30,height: 30)
                             .clipShape(Circle())
                        }

                        
                        
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    
                    
                  
                    
                    
                    
                }
                Divider()
                    .padding(.horizontal,-15)
                    
                
                
                
                
                
            }
            .padding([.horizontal,.top])
            
           TagView()
            
        }
        .padding(.top,getSafeArea().top)
        .background{
            Color.white
        }
        .padding(.bottom,20)
        
        
    }
    
    @ViewBuilder
    func TagView()->some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            
            HStack(spacing:16){
                
                let tags = ["All","iJustine","Kavsoft","Apple","SwiftUI","Programming","Technology"]
          
                
                ForEach(tags,id:\.self){tagname in
                    
                    Text(tagname)
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.gray)
                        .padding(.vertical,12)
                        .padding(.horizontal,12)
                        .background{
                         
                           Capsule()
                                .fill(.ultraThinMaterial)
                        }
                    
                    
                }
                
            }
        }
        .padding(.horizontal,15)
        
    }
    
    @ViewBuilder
    func ThamnailView()->some View{
        
        VStack(spacing:16){
            
            ForEach(0...10,id:\.self){index in
                
                GeometryReader{proxy in
                    
                     let size = proxy.size
                    Image("Image\((index % 5) + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .clipped()
                   
                }
                .frame(height:250)
                .padding(.horizontal)
                
                
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum Direction{
    
    case up
    case down
    case none
}
