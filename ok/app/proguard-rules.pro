-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
# prevent Crashlytics obfuscation
-keep class com.crashlytics.** { *; }
-keep class androidx.lifecycle.DefaultLifecycleObserver
-dontwarn com.crashlytics.**