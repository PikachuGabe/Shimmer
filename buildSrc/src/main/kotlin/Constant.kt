import org.gradle.api.Project
import java.util.*

//Mod options
val mod_name = "Shimmer"
val mod_author = "KilaBash"
val mod_id = "shimmer"

//Common
val minecraft_version = "1.19.2"
val parchment_version = "1.19.2:2022.10.09"
val enabled_platforms = "fabric,forge"

//Archiitectury
val architectury_version = "4.8.79"

//Fabric
val fabric_loader_version = "0.15.11"
val fabric_api_version = "0.77.0+$minecraft_version"
val cloth_config_version = "8.2.88"

//Forge
val forge_version = "$minecraft_version-43.3.7"
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

val flywheel_version = "0.6.7-8"

val Project.archiveBaseName get() = "$mod_name-${project.name.lowercase(Locale.getDefault())}"
