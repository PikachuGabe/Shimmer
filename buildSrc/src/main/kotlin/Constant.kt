import org.gradle.api.Project
import java.util.*

//Mod options
const val mod_name = "Shimmer"
const val mod_author = "KilaBash"
const val mod_id = "shimmer"

//Common
const val minecraft_version = "1.19.4"
const val parchment_version = "1.19.3:2023.03.12"
const val enabled_platforms = "fabric,forge"

//Fabric
val fabric_loader_version = "0.15.11"
val fabric_api_version = "0.87.2+$minecraft_version"
val cloth_config_version = "10.0.96"

//Forge
val forge_version = "$minecraft_version-45.3.0"
val modernui_version = "3.6.1.115"

//Project
val version_major = 0.2
val version_patch = 5
val semantics_version = "$minecraft_version-$version_major.$version_patch"
val maven_path = "snapshots"
val maven_group = "com.lowdragmc.shimmer"

private val mixinExtra = "io.github.llamalad7:mixinextras"
private val mixinExtraVersion = "0.3.6"
val mixinExtraCommon = "$mixinExtra-common:$mixinExtraVersion"
val mixinExtraForge = "$mixinExtra-forge:$mixinExtraVersion"
val mixinExtraFabric = "$mixinExtra-fabric:$mixinExtraVersion"

const val flywheel_version = "0.6.7-8"// FIXME

val Project.archiveBaseName get() = "$mod_name-${project.name.lowercase(Locale.getDefault())}"
