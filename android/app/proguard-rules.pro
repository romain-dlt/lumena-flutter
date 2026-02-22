# RevenueCat ProGuard Rules
-keep class com.revenuecat.purchases.** { *; }
-keep interface com.revenuecat.purchases.** { *; }

# Keep all public classes and their public and protected fields and methods
-keep public class com.revenuecat.** { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Don't obfuscate RevenueCat classes
-keepnames class com.revenuecat.purchases.** { *; }

# Keep Google Play Billing classes
-keep class com.android.billingclient.api.** { *; }

# Keep Google Play Core classes (required by Flutter)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep all Kotlin Metadata
-keep class kotlin.Metadata { *; }

# Keep JSON serialization classes (if using Gson/Moshi)
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
