import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Google Maps API key, read from the gitignored `android/local.properties`
// (populated locally by the engineer/CI) rather than committed to git. See
// docs/leave_reminder_setup.md.
val localProperties =
    Properties().apply {
        val localPropertiesFile = rootProject.file("local.properties")
        if (localPropertiesFile.exists()) {
            localPropertiesFile.inputStream().use { load(it) }
        }
    }
val googleMapsApiKey: String = localProperties.getProperty("GOOGLE_MAPS_API_KEY", "")

// The `dev` flavor ships under a different applicationId
// (`io.fury.workTracker.dev`), so a prod key restricted by Android
// application restrictions (package name + SHA-1) won't authorize it.
// Falls back to the prod key when unset, so dev builds keep working until a
// real, separately-restricted dev key is provisioned.
val googleMapsApiKeyDev: String =
    localProperties.getProperty("GOOGLE_MAPS_API_KEY_DEV", "").ifBlank { googleMapsApiKey }

// Release signing config, read from env vars (see docs/play_store_setup.md).
// Falls back to the debug keystore when unset, so `flutter run --release`
// keeps working locally with no keystore provisioned.
val androidKeystoreFilepath: String? = System.getenv("ANDROID_KEYSTORE_FILEPATH")
val androidKeystorePassword: String? = System.getenv("ANDROID_KEYSTORE_PASSWORD")
val androidKeyAlias: String? = System.getenv("ANDROID_KEY_ALIAS")
val androidKeyPassword: String? = System.getenv("ANDROID_KEY_PASSWORD")
val hasReleaseSigningConfig =
    !androidKeystoreFilepath.isNullOrBlank() &&
        !androidKeystorePassword.isNullOrBlank() &&
        !androidKeyAlias.isNullOrBlank() &&
        !androidKeyPassword.isNullOrBlank()

android {
    namespace = "io.fury.workTracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Required by flutter_local_notifications for scheduled notifications.
        isCoreLibraryDesugaringEnabled = true
    }

    // Required for the `resValue("string", "app_name", ...)` calls in the
    // dev/prod product flavors below - AGP disables resValues by default.
    buildFeatures {
        resValues = true
    }

    defaultConfig {
        applicationId = "io.fury.workTracker"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKey
    }

    flavorDimensions += "environment"

    productFlavors {
        create("prod") {
            dimension = "environment"
            applicationId = "io.fury.workTracker"
            resValue("string", "app_name", "WorkTracker")
        }
        create("dev") {
            dimension = "environment"
            applicationId = "io.fury.workTracker.dev"
            resValue("string", "app_name", "WorkTracker Dev")
            manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKeyDev
        }
    }

    signingConfigs {
        if (hasReleaseSigningConfig) {
            create("release") {
                storeFile = file(androidKeystoreFilepath!!)
                storePassword = androidKeystorePassword
                keyAlias = androidKeyAlias
                keyPassword = androidKeyPassword
            }
        }
    }

    buildTypes {
        release {
            signingConfig =
                if (hasReleaseSigningConfig) {
                    signingConfigs.getByName("release")
                } else {
                    signingConfigs.getByName("debug")
                }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
