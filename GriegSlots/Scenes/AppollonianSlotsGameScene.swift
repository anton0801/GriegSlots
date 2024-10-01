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

#Preview {
    VStack {
        SpriteView(scene: AppollonianSlotsGameScene())
            .ignoresSafeArea()
    }
}
