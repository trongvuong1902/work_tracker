# WorkManager's internal WorkDatabase (and any other Room database pulled in
# transitively) is instantiated via reflection at runtime. androidx.work's
# bundled consumer rules don't cover it, so without this keep rule R8 strips
# the generated *_Impl class's no-arg constructor as apparently unused,
# crashing release builds on startup with:
#   NoSuchMethodException: androidx.work.impl.WorkDatabase_Impl.<init> []
-keep class * extends androidx.room.RoomDatabase { *; }
