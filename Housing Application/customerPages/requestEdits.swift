//
//  requestEdits.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//

//What allows customers to edit the information, here customers can
//make a request to update something in particular. This gets added
//to the property, which then can be seen by staff who can confirm it
//or delete it.


import SwiftUI

struct requestEdits: View {
   
    @State private var showButton = false
    @State var presentEditOrderSheet = false
    var house: House
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Request Changes")
                .foregroundColor(.black)
        }
    }

    var body: some View {
      
        Text("Property Details")
            .font(.headline)
            .font(.system(size: 16, weight: .regular))
        
        
            Image("Logo")
                       .resizable()
                       
                        .frame(width: 350.0, height: 200.0)
                    
            HStack{
           
            Text(house.price)
                    .font(.system(size: 40))
            .font(.headline)
            
            .padding()
                Spacer()
                
                Image(systemName: "heart")
                .symbolRenderingMode(.monochrome)
                .foregroundColor(Color.red)
                .font(.system(size: 16, weight: .regular))
                
                .padding()
            
            }
            
         
            
            HStack{
                
              
                Text(house.streetName)
                    .font(.headline)
                .padding()
               
              
                
                Text(house.postCode)
                    .font(.headline)
                .padding()
                
                Spacer()
            }
           

         
              
                      
            VStack(alignment: .leading)
            {
                Divider()
                HStack{
                 
                    Image(systemName: "house.circle")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 20, weight: .regular))
                    
                    .padding(.bottom, 50)
                    
                    .padding()
                    
       
                    
                  
                Text("Property type")
                .font(.headline)
                .padding(.bottom, 50)
                    
                    Text(house.flatNumber)
                .font(.subheadline)
                    
                .padding(.bottom, 50)

                  Spacer()
                    Image(systemName: "bed.double")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 16, weight: .regular))
                    
                    .padding(.bottom, 50)
                    
                Text("City     ")
                .font(.headline)
                .padding(.bottom, 50)
                    Text(house.city)
                .font(.subheadline)
                .padding(.bottom, 50)
                .padding()
                    
        }
                
              
                 
            }
        
                
            VStack(alignment: .leading)
            {
                HStack{
                    
                    Image(systemName: "sterlingsign.circle.fill")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.bottom, 50)
                    .padding()
                    
                    
                    Text("Price")
                .font(.headline)
                .padding(.bottom, 50)
                    
               
                    
                    Text(house.flatNumber)
                .font(.subheadline)
                .padding(.bottom, 50)
                    
                    Spacer()
                
                    Image(systemName: "sterlingsign.circle.fill")
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.bottom, 50)
                    
                    
                   
                    
                Text("Bedrooms")
                .font(.headline)
                .padding(.bottom, 50)
                    Text(house.price)
                .font(.subheadline)
                    
                .padding(.bottom, 50)
                .padding()
            
        }
              
                
                Divider()
                
            }
   
         

            Spacer()
      
            .navigationBarItems(trailing: editButton {
                self.presentEditOrderSheet.toggle()
            })
        
     
      
        
            .onAppear() {
                print("houseDetailsView.onAppear() for \(self.house.title)")
            }
            .onDisappear() {
                print("houseDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditOrderSheet) {
              requestingEdits(viewModel: HouseViewModel(house: house), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {

                    }
                }
            }
        }
    
     //   .edgesIgnoringSafeArea(.top)
        
//        .navigationViewStyle(StackNavigationViewStyle())
    }



struct requestEdits_Previews: PreviewProvider {
    static var previews: some View {
        let house = House(id: "",title: "",houseNumber: "",flatNumber: "",streetName: "",city: "",postCode:"",editInfo: "",price: "", UserGender: "")
        return
            NavigationView {
               requestEdits(house: house)
            }
    }
}
