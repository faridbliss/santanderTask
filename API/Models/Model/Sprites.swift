//
//  Sprites.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct Sprites: Codable {
    public let frontDefault: String?
    public let front_shiny: String?
    public let front_female: String?
    public let front_shiny_female: String?
    public let back_default: String?
    public let back_shiny: String?
    public let back_female: String?
    public let back_shiny_female: String?
    public let other: Other?
    public let versions: Versions?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case front_shiny = "front_shiny"
        case front_female = "front_female"
        case front_shiny_female = "front_shiny_female"
        case back_default = "back_default"
        case back_shiny = "back_shiny"
        case back_female = "back_female"
        case back_shiny_female = "back_shiny_female"
        case other = "other"
        case versions = "versions"
    }
}

public struct Other: Codable {
    public let dreamWorld: DreamWorld?
    public let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

public struct DreamWorld: Codable {
    public let front_default: String?
    public let front_female: String?

    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
        case front_female = "front_female"
    }
}

public struct OfficialArtwork: Codable {
    public let front_female: String?

    enum CodingKeys: String, CodingKey {
        case front_female = "front_female"
    }
}

public struct Versions: Codable {
    public let generationi: GenerationI?
    public let generationii: GenerationII?
    public let generationiii: GenerationIII?
    public let generationiv: GenerationIV?
    public let generationv: GenerationV?
    public let generationvi: GenerationVI?
    public let generationvii: GenerationVII?
    public let generationviii: GenerationVIII?

    enum CodingKeys: String, CodingKey {
        case generationi = "generation-i"
        case generationii = "generation-ii"
        case generationiii = "generation-iii"
        case generationiv = "generation-iv"
        case generationv = "generation-v"
        case generationvi = "generation-vi"
        case generationvii = "generation-vii"
        case generationviii = "generation-viii"
    }
}
public struct GenerationI: Codable {
    public let redBlue: GenerationIModel?
    public let yellow: GenerationIModel?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow = "yellow"
    }
}
public struct GenerationII: Codable {
    public let crystal: GenerationIIModel?
    public let gold: GenerationIIModel?
    public let silver: GenerationIIModel?

    enum CodingKeys: String, CodingKey {
        case crystal = "crystal"
        case gold = "gold"
        case silver = "silver"
    }
}
public struct GenerationIII: Codable {
    public let emerald: GenerationIIIModel?
    public let fireredLeafgreen: GenerationIIModel?
    public let rubySapphire: GenerationIIModel?

    enum CodingKeys: String, CodingKey {
        case emerald = "emerald"
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}
public struct GenerationIV: Codable {
    public let diamondPearl: FrontBack?
    public let heartgoldSoulsilver: FrontBack?
    public let platinum: FrontBack?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum = "platinum"
    }
}
public struct GenerationV: Codable {
    public let blackWhite: BlackWhite?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}
public struct GenerationVI: Codable {
    public let omegarubyAlphasapphire: Front?
    public let xY: Front?

    enum CodingKeys: String, CodingKey {
        case omegarubyAlphasapphire = "omegaruby-alphasapphire"
        case xY = "x-y"
    }
}
public struct GenerationVII: Codable {
    public let icons: GenerationIVModel?
    public let ultraSunUltraMoon: GenerationIVModel?

    enum CodingKeys: String, CodingKey {
        case icons = "icons"
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}
public struct GenerationVIII: Codable {
    public let icons: GenerationIVModel?

    enum CodingKeys: String, CodingKey {
        case icons = "icons"
    }
}

public struct GenerationIModel: Codable {
    public let back_default: String?
    public let back_gray: String?
    public let front_default: String?
    public let front_gray: String?
}
public struct GenerationIIModel: Codable {
    public let back_default: String?
    public let back_shiny: String?
    public let front_default: String?
    public let front_shiny: String?
}
public struct GenerationIIIModel: Codable {
    public let front_default: String?
    public let front_shiny: String?
}
public struct GenerationIVModel: Codable {
    public let front_default: String?
    public let front_female: String?
}
public struct FrontBack: Codable {
    public let front_default: String?
    public let front_shiny: String?
    public let front_female: String?
    public let front_shiny_female: String?
    public let back_default: String?
    public let back_shiny: String?
    public let back_female: String?
    public let back_shiny_female: String?

}
public struct Front: Codable {
    public let front_default: String?
    public let front_shiny: String?
    public let front_female: String?
    public let front_shiny_female: String?

}
public struct BlackWhite: Codable {
    public let animated: FrontBack?
    public let front_default: String?
    public let front_shiny: String?
    public let front_female: String?
    public let front_shiny_female: String?
    public let back_default: String?
    public let back_shiny: String?
    public let back_female: String?
    public let back_shiny_female: String?
}


