package com.example.the_last_daydream

import android.service.dreams.DreamService
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.view.FlutterMain


class TheLastDaydream : DreamService() {
    private var flutterFragment: FlutterFragment? = null
    override fun onDreamingStarted() {
        super.onDreamingStarted()
        // set content view as one big FlutterFragment
//        setContentView(R.layout.niceyyydaydream_layout)
//        flutterFragment =

        val flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterMain.findAppBundlePath(), "main"
            )
        )
        setContentView(R.layout.the_last_daydream)
        val view = findViewById<FlutterView>(R.id.flutter_view)
        view.attachToFlutterEngine(flutterEngine)
        isFullscreen = true
        isInteractive = false
        isScreenBright = false

        flutterEngine.lifecycleChannel.appIsResumed()
    }
}
