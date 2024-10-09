import SwiftUI
import SpriteKit

class AppollonianSlotsGameScene: BaseSlotScene {
    
     override func didMove(to view: SKView) {
        slotName = "appollonian"
        super.didMove(to: view)
    }
    
    override func createBackground() {
        let backgroundNode = SKSpriteNode(imageNamed: "appollonian_background_image")
        backgroundNode.size = size
        backgroundNode.zPosition = -1
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(backgroundNode)
    }
    
}



struct SlotShopItem: Codable {
    let id: Int
    let icon: String
    let price: Int
    let coins: Int
}

struct SlotShopCoinsResponse: Codable {
    let clientID: String
    let response: String?

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case response
    }
}

struct SlotShopResponse: Codable {
    let shopResults: [SlotShopItem]
    let shopResponseData: String?
    
    enum CodingKeys: String, CodingKey {
        case shopResults = "results"
        case shopResponseData = "response"
    }
}

struct SlotInfoResponse: Codable {
    let results: [SlotInfoItem]
}

struct SlotInfoItem: Codable {
    let id: Int
    let name: String
    let previewImage: String
    let available: Bool
}

#Preview {
    VStack {
        SpriteView(scene: AppollonianSlotsGameScene())
            .ignoresSafeArea()
    }
}
