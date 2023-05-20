//
//  TopView.swift
//  ToDoApp
//
//  Created by ibaikaa on 19/5/23.
//

import SwiftUI

struct TopView: View {
    @State private var showInfoAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                // Настраиваем заголовок
                Text("Мои задачи")
                    .font(.system(size: 24))
                    .background(.white)
                
                Spacer()
                
                // Настраиваем кнопку с информацией
                Button {
                    showInfoAlert = true
                } label: {
                    // Устанавливаем кнопке картинку
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding()
            
            Divider()
                .frame(height: 2)
                .overlay { Color.gray }
                .padding(.bottom, 0)
        }
        // Задаем фоновый цвет (белый)
        .background(.white)
        
        // Настраиваем окно с ошибкой
        .alert(isPresented: $showInfoAlert) {
            Alert(
                title: Text("Информация ℹ️"),
                message: Text("После добавления новой задачи, потяните список вниз для его обновления.")
            )
        }
    }
    
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView().previewLayout(.sizeThatFits)
    }
}
