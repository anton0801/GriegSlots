import SwiftUI
import SpriteKit

class BaseSlotScene: SKScene {
    
    var slotName: String = "hera"
    
    var userBalance = UserDefaults.standard.integer(forKey: Keys.userCoins) {
        didSet {
            UserDefaults.standard.set(userBalance, forKey: Keys.userCoins)
            userBalanceLabel.text = "\(userBalance)"
        }
    }
    private var userBalanceLabel: SKLabelNode!
    
    private var totalWin = 0 {
        didSet {
            totalWinLabel.text = "\(totalWin)"
        }
    }
    private var totalWinLabel: SKLabelNode!
    
    private var totalBet = 100 {
        didSet {
            totalBetLabel.text = "\(totalBet)"
        }
    }
    private var totalBetLabel: SKLabelNode!
    
    private var autoSpin: SKSpriteNode!
    private var autoSpinEnabled = false {
        didSet {
            if autoSpinEnabled {
                autoSpin.run(SKAction.fadeAlpha(to: 0.8, duration: 0.2))
            } else {
                autoSpin.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
            }
        }
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 2400, height: 2048)
        
        createBackground()
        
        createUIElements()
        
        createSlots()
    }
    
    private var slotBaraban1: SlotItemBarabanNode!
    private var slotBaraban2: SlotItemBarabanNode!
    private var slotBaraban3: SlotItemBarabanNode!
    private var slotBaraban4: SlotItemBarabanNode!
    private var slotBaraban5: SlotItemBarabanNode!
    
    open func createBackground() { }
    
    private func createUIElements() {
        let balanceBackground = SKSpriteNode(imageNamed: "balance_background")
        balanceBackground.position = CGPoint(x: size.width - 300, y: size.height - 250)
        balanceBackground.size = CGSize(width: 400, height: 300)
        addChild(balanceBackground)
        
        userBalanceLabel = .init(text: "\(userBalance)")
        userBalanceLabel.position = CGPoint(x: size.width - 300, y: size.height - 280)
        userBalanceLabel.fontName = "RammettoOne-Regular"
        userBalanceLabel.fontSize = 72
        userBalanceLabel.fontColor = UIColor.init(red: 230/255, green: 184/255, blue: 69/255, alpha: 1)
        addChild(userBalanceLabel)
        
        let home = SKSpriteNode(imageNamed: "home")
        home.name = "home"
        home.position = CGPoint(x: 200, y: 400)
        home.size = CGSize(width: home.size.width, height: 470)
        addChild(home)
        
        let spin = SKSpriteNode(imageNamed: "spin_btn")
        spin.name = "spin"
        spin.position = CGPoint(x: size.width / 2, y: 370)
        spin.size = CGSize(width: 250, height: 400)
        addChild(spin)
        
        let maxBet = SKSpriteNode(imageNamed: "max_bet")
        maxBet.name = "max_bet"
        maxBet.position = CGPoint(x: size.width / 2 - 280, y: 370)
        maxBet.size = CGSize(width: 200, height: 320)
        addChild(maxBet)
        
        autoSpin = SKSpriteNode(imageNamed: "auto_spin")
        autoSpin.name = "auto_spin"
        autoSpin.position = CGPoint(x: size.width / 2 + 280, y: 370)
        autoSpin.size = CGSize(width: 200, height: 320)
        addChild(autoSpin)
        
        let info = SKSpriteNode(imageNamed: "info")
        info.name = "info"
        info.position = CGPoint(x: size.width - 200, y: 400)
        info.size = CGSize(width: home.size.width, height: 470)
        addChild(info)
        
        let totalBetBackground = SKSpriteNode(imageNamed: "total_bet")
        totalBetBackground.position = CGPoint(x: 570, y: 370)
        totalBetBackground.size = CGSize(width: 430, height: 300)
        addChild(totalBetBackground)
        
        totalBetLabel = .init(text: "\(totalBet)")
        totalBetLabel.position = CGPoint(x: 570, y: 310)
        totalBetLabel.fontName = "RammettoOne-Regular"
        totalBetLabel.fontSize = 52
        totalBetLabel.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        addChild(totalBetLabel)
        
        let betPlus = SKLabelNode(text: "+")
        betPlus.position = CGPoint(x: 730, y: 305)
        betPlus.fontName = "RammettoOne-Regular"
        betPlus.fontSize = 72
        betPlus.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        betPlus.name = "bet_plus"
        addChild(betPlus)
        
        let betMinus = SKLabelNode(text: "-")
        betMinus.position = CGPoint(x: 410, y: 305)
        betMinus.fontName = "RammettoOne-Regular"
        betMinus.fontSize = 72
        betMinus.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        betMinus.name = "bet_minus"
        addChild(betMinus)
        
        let totalWinBackground = SKSpriteNode(imageNamed: "total_win")
        totalWinBackground.position = CGPoint(x: size.width - 570, y: 370)
        totalWinBackground.size = CGSize(width: 430, height: 300)
        addChild(totalWinBackground)
        
        totalWinLabel = .init(text: "\(totalWin)")
        totalWinLabel.position = CGPoint(x: size.width - 570, y: 310)
        totalWinLabel.fontName = "RammettoOne-Regular"
        totalWinLabel.fontSize = 52
        totalWinLabel.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        addChild(totalWinLabel)
        
        let slotBackground = SKSpriteNode(imageNamed: "slot_background")
        slotBackground.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        slotBackground.size = CGSize(width: 1200, height: 1100)
        addChild(slotBackground)
        
        let starsCounter = SKSpriteNode(imageNamed: "stars_counter_bg")
        starsCounter.position = CGPoint(x: 300, y: size.height - 250)
        starsCounter.size = CGSize(width: starsCounter.size.width, height: 300)
        addChild(starsCounter)
    }
    
    open func getSlotSymbols() -> [String] {
        [
            "\(slotName)_symbol_1",
            "\(slotName)_symbol_2",
            "\(slotName)_symbol_3",
            "\(slotName)_symbol_4",
            "\(slotName)_symbol_5",
            "\(slotName)_symbol_6",
            "\(slotName)_symbol_7",
            "\(slotName)_symbol_8",
            "\(slotName)_symbol_9",
            "\(slotName)_symbol_10",
            "\(slotName)_symbol_11",
        ]
    }
    
    private func createSlots() {
        slotBaraban1 = SlotItemBarabanNode(slotName: slotName, slotSymbols: getSlotSymbols(), size: CGSize(width: 250, height: 1000), endScroll: nil)
        slotBaraban1.position = CGPoint(x: size.width / 2 - 400, y: size.height / 2 + 160)
        
        
        slotBaraban2 = SlotItemBarabanNode(slotName: slotName, slotSymbols: getSlotSymbols(), size: CGSize(width: 250, height: 1000), endScroll: nil)
        slotBaraban2.position = CGPoint(x: size.width / 2 - 200, y: size.height / 2 + 160)       
        
        slotBaraban3 = SlotItemBarabanNode(slotName: slotName, slotSymbols: getSlotSymbols(), size: CGSize(width: 250, height: 1000), endScroll: nil)
        slotBaraban3.position = CGPoint(x: size.width / 2, y: size.height / 2 + 160)
        
        slotBaraban4 = SlotItemBarabanNode(slotName: slotName, slotSymbols: getSlotSymbols(), size: CGSize(width: 250, height: 1000), endScroll: nil)
        slotBaraban4.position = CGPoint(x: size.width / 2 + 210, y: size.height / 2 + 160)
        
        slotBaraban5 = SlotItemBarabanNode(slotName: slotName, slotSymbols: getSlotSymbols(), size: CGSize(width: 250, height: 1000), endScroll: {
            if self.autoSpinEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.spinSlots()
                }
            }
        })
        slotBaraban5.position = CGPoint(x: size.width / 2 + 410, y: size.height / 2 + 160)
        
        addChild(slotBaraban1)
        addChild(slotBaraban2)
        addChild(slotBaraban3)
        addChild(slotBaraban4)
        addChild(slotBaraban5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let touchedObject = atPoint(t.location(in: self))
            
            if touchedObject.name == "auto_spin" {
                if touchedObject.alpha == 1 {
                    autoSpinEnabled = true
                } else {
                    autoSpinEnabled = false
                }
                spinSlots()
            }
            
            if touchedObject.name == "bet_plus" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                if totalBet < 10000 {
                    totalBet += 100
                }
            }
            
            if touchedObject.name == "bet_minus" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                if totalBet > 100 {
                    totalBet -= 100
                }
            }
            
            if touchedObject.name == "max_bet" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                totalBet = 10000
            }
            
            if touchedObject.name == "home" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                NotificationCenter.default.post(name: Notification.Name("go_home"), object: nil)
            }
            
            if touchedObject.name == "info" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                NotificationCenter.default.post(name: Notification.Name("go_info"), object: nil)
            }
            
            if touchedObject.name == "spin" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                spinSlots()
            }
        }
    }
    
    private func spinSlots() {
        if userBalance >= totalBet {
            userBalance -= totalBet
            slotBaraban1.spinBaraban()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.slotBaraban2.spinBaraban()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.slotBaraban3.spinBaraban()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.slotBaraban4.spinBaraban()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.slotBaraban5.spinBaraban()
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("user_balance_low"), object: nil)
        }
    }
    
}

#Preview {
    SpriteView(scene: BaseSlotScene())
        .ignoresSafeArea()
}

class SlotItemBarabanNode: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var griegSlotSymbols: [String]
    var revScrollBaraban = false
    var slotName: String
    
    init(slotName: String, slotSymbols: [String], size: CGSize, endScroll: (() -> Void)?) {
        self.slotName = slotName
        self.griegSlotSymbols = slotSymbols
        self.croppedNode = SKCropNode()
        self.slotsParentNode = SKNode()
        self.endScrollCallback = endScroll
        
        super.init(texture: nil, color: .clear, size: size)
        addSymbols()
    }
    
    private func addSymbols() {
        croppedNode.position = CGPoint(x: 0, y: 0)
        let maskedNode = SKSpriteNode(color: .black, size: size)
        maskedNode.position = CGPoint(x: 0, y: 0)
        croppedNode.maskNode = maskedNode
        addChild(croppedNode)
        croppedNode.addChild(slotsParentNode)
        if Bool.random() && Bool.random() {
            self.griegSlotSymbols.append("\(slotName)_symbol_scatter")
        }
        let shuffledSymbols = griegSlotSymbols.shuffled()
        for i in 0..<griegSlotSymbols.count * 8 {
            let nameSymbol = shuffledSymbols[i % griegSlotSymbols.count]
            let symbol = SKSpriteNode(imageNamed: nameSymbol)
            symbol.size = CGSize(width: 130, height: 240)
            symbol.zPosition = 1
            symbol.name = nameSymbol
            symbol.position = CGPoint(x: 0, y: size.height - CGFloat(i) * 340.5)
            slotsParentNode.addChild(symbol)
        }
        slotsParentNode.run(SKAction.moveBy(x: 0, y: 340.5 * CGFloat(griegSlotSymbols.count * 3), duration: 0.0))
    }
    
    private let slotsParentNode: SKNode
    var endScrollCallback: (() -> Void)?
    private let croppedNode: SKCropNode
    
    func spinBaraban() {
        if revScrollBaraban {
            let spinAction = SKAction.moveBy(x: 0, y: -(340.5 * CGFloat(Int.random(in: 4...6))), duration: 0.5)
            revScrollBaraban = false
            slotsParentNode.run(spinAction) {
                self.endScrollCallback?()
            }
        } else {
            let spinAction = SKAction.moveBy(x: 0, y: 340.5 * CGFloat(Int.random(in: 4...6)), duration: 0.5)
            revScrollBaraban = true
            slotsParentNode.run(spinAction) {
                self.endScrollCallback?()
            }
        }
    }
    
}
