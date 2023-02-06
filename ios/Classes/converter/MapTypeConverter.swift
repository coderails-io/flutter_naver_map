import NMapsMap


/*
  --- Objects ---
*/
func asLatLng(_ v: Any) -> NMGLatLng {
    let d = asDict(v, valueCaster: asDouble)
    return NMGLatLng(lat: d["lat"]!, lng: d["lng"]!)
}

extension NMGLatLng {
    func toDict() -> Dictionary<String, Any> {
        ["lat": lat, "lng": lng]
    }
}

func asLatLngBounds(_ v: Any) -> NMGLatLngBounds {
    let d = asDict(v, valueCaster: asLatLng)
    return NMGLatLngBounds.init(
            southWest: d["southWest"]!,
            northEast: d["northEast"]!
    )
}

extension NMGLatLngBounds {
    func toDict() -> Dictionary<String, Any> {
        [
            "southWest": southWest.toDict(),
            "northEast": northEast.toDict()
        ]
    }
}

func asCameraPosition(_ v: Any) -> NMFCameraPosition {
    let d = asDict(v)
    return NMFCameraPosition.init(
            asLatLng(d["target"]!),
            zoom: asDouble(d["zoom"]!),
            tilt: asDouble(d["tilt"]!),
            heading: asDouble(d["bearing"]!)
    )
}

extension NMFCameraPosition {
    func toDict() -> Dictionary<String, Any> {
        [
            "target": target.toDict(),
            "zoom": zoom,
            "tilt": tilt,
            "bearing": heading
        ]
    }
}

extension NMFSymbol {
    func toDict() -> Dictionary<String, Any> {
        [
            "caption": caption ?? "",
            "position": position.toDict(),
            "hashCode": hash
        ]
    }
}

extension NMFIndoorSelection {
    func toDict() -> Dictionary<String, Any> {
        [
            "levelIndex": levelIndex,
            "zoneIndex": zoneIndex,
            "region": region.toDict()
        ]
    }
}

extension NMFIndoorRegion {
    func toDict() -> Dictionary<String, Any> {
        [
            "zones": zones.map { (zone) in
                zone.toDict()
            },
        ]
    }
}

extension NMFIndoorZone {
    func toDict() -> Dictionary<String, Any> {
        [
            "id": zoneId,
            "defaultLevelIndex": defaultLevelIndex,
            "levels": levels.map { (level) in
                level.toDict()
            },
        ]
    }
}

extension NMFIndoorLevel {
    func toDict() -> Dictionary<String, Any> {
        [
            "name": name,
            "hashCode": hash
        ]
    }
}

func asNMGLineString(rawArr: Any) -> NMGLineString<AnyObject> {
    let points = asArr(rawArr, elementCaster: asLatLng)
    return NMGLineString(points: points)
}

extension NMGLineString<AnyObject> {
    var latLngPoints: Array<NMGLatLng> {
        get {
            (self as! NMGLineString<NMGPointable>).points.map { (point: NMGPointable) in
                point.toLatLng!()
            }
        }
    }
}

/*
  --- Enums ---
*/

func asCameraAnimation(_ v: Any) -> NMFCameraUpdateAnimation {
    switch asString(v) {
    case "easing": return .easeIn
    case "fly": return .fly
    case "linear": return .linear
    default: return .none
    }
}

func asMapType(_ v: Any) -> NMFMapType {
    switch asString(v) {
    case "basic": return .basic
    case "hybrid": return .hybrid
    case "navi": return .navi
    case "satellite": return .satellite
    case "terrain": return .terrain
    default: return .none
    }
}

func asLocationTrackingMode(_ v: Any) -> NMFMyPositionMode {
    switch asString(v) {
    case "face": return .compass
    case "follow": return .direction
    case "noFollow": return .normal
    default: return .disabled
    }
}

extension NMFMyPositionMode {
    func toMessageableString() -> String {
        switch self {
        case .compass: return "face"
        case .direction: return "follow"
        case .normal: return "noFollow"
        case .disabled: return "none"
        @unknown default: return "none"
        }
    }
}

func asAlign(_ v: Any) throws -> NMFAlignType {
    switch asString(v) {
    case "center": return .center
    case "left": return .left
    case "right": return .right
    case "top": return .top
    case "bottom": return .bottom
    case "topLeft": return .topLeft
    case "topRight": return .topRight
    case "bottomLeft": return .bottomLeft
    case "bottomRight": return .bottomRight
    default: throw NSError()
    }
}

extension NMFAlignType {
    func toMessageableString() -> String {
        switch self {
        case .center: return "center"
        case .left: return "left"
        case .right: return "right"
        case .top: return "top"
        case .bottom: return "bottom"
        case .topLeft: return "topLeft"
        case .topRight: return "topRight"
        case .bottomRight: return "bottomLeft"
        case .bottomLeft: return "bottomRight"
        default: return "center"
        }
    }
}

func asLogoAlign(_ v: Any) -> NMFLogoAlign {
    switch asString(v) {
    case "leftBottom": return .leftBottom
    case "rightBottom": return .rightBottom
    case "leftTop": return .leftTop
    case "rightTop": return .rightTop
    default: return .leftBottom
    }
}

func asLineCap(_ v: Any) -> NMFOverlayLineCap {
    switch asString(v) {
    case "butt": return .butt
    case "round": return .round
    case "square": return .square
    default: return .butt
    }
}

extension NMFOverlayLineCap {
    func toMessageableString() -> String {
        switch self {
        case .butt: return "butt"
        case .round: return "round"
        case .square: return "square"
        @unknown default: return "butt"
        }
    }
}

func asLineJoin(_ v: Any) -> NMFOverlayLineJoin {
    switch asString(v) {
    case "bevel": return .bevel
    case "miter": return .miter
    case "round": return .round
    default: return .bevel
    }
}

extension NMFOverlayLineJoin {
    func toMessageableString() -> String {
        switch self {
        case .bevel: return "bevel"
        case .miter: return "miter"
        case .round: return "round"
        @unknown default: return "bevel"
        }
    }
}

/*
  --- Color ---
*/

func asUIColor(_ v: Any) -> UIColor {
    UIColor(argb: asInt(v))
}

extension UIColor {
    convenience init(argb: Int) {
        let a = CGFloat((argb >> 24) & 0xff) / 255.0
        let r = CGFloat((argb >> 16) & 0xff) / 255.0
        let g = CGFloat((argb >> 8) & 0xff) / 255.0
        let b = CGFloat(argb & 0xff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    func toInt() -> Int {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return Int(a * 255) << 24 | Int(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255)
    }
}