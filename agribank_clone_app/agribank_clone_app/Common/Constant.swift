

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let APP_DELEGATE = UIApplication.shared.delegate as? AppDelegate
let RATIO_HEIGHT = SCREEN_HEIGHT / 844
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let MAX_IMAGE_SIZE: Float = 10
let MAX_VIDEO_SIZE: Float = 150
let TERM = URL(string: "https://hokenbox.com/term")
let POLICY = URL(string: "https://hokenbox.com/privacy")

