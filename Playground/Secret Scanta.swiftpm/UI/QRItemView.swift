import SwiftUI

struct QRItemView : View {
    var item : SecretSantaItem
    
    var body: some View {
        HStack {
            Spacer()
            //Rectangle()
            VStack {
                Spacer(minLength: 25)
                Text(item.name).font(.headline)
                if let image = item.image {
                    Image(uiImage:image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)                    
                }
                Spacer(minLength: 25)
            }
            .foregroundColor(.blue)
            Spacer()
            //Rectangle()
        }
    }
}

struct QRItemView_Previews: PreviewProvider {
    static var previews: some View {
        QRItemView(item: SecretSantaItem( name: "Scott", message: "https://stury.github.io/SecretScanta/?target=Joan" ))
    }
}
