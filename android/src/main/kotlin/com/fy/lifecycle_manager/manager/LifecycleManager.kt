package com.fy.lifecycle_manager.manager

import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ProcessLifecycleOwner
import com.fy.lifecycle_manager.model.Lifecycle
import io.flutter.Log

object LifecycleManager: DefaultLifecycleObserver {

    private const val TAG: String = "LifecycleManager"

    private var appLifecycle = Lifecycle.AppKilled;
    private var isForeground = false;
    private var hasStarted: Boolean = false;

    fun getAppLifecycle(): Lifecycle {
        return appLifecycle
    }

    fun startListeners() {
        if (hasStarted) return
        hasStarted = true

        ProcessLifecycleOwner.get().lifecycle.addObserver(this)

        Log.d(TAG, "Lifecycle listeners started")

    }

    fun stopListeners() {
        if (!hasStarted) return
        hasStarted = false

        ProcessLifecycleOwner.get().lifecycle.removeObserver(this)

        Log.d(TAG, "Lifecycle listeners stopped")
    }

    fun updateLifecycle(lifecycle: Lifecycle) {
        if (appLifecycle == lifecycle) {
            return
        }

        isForeground = isForeground || appLifecycle == Lifecycle.AppKilled

        appLifecycle = lifecycle

        Log.d(TAG, "App current lifecycle: $appLifecycle")
    }

    override fun onCreate(owner: LifecycleOwner) {
        super.onCreate(owner)

        val currentLifecycle = if (isForeground) Lifecycle.Background else Lifecycle.Background

        updateLifecycle(currentLifecycle)
    }

    override fun onStart(owner: LifecycleOwner) {
        super.onStart(owner)

        val currentLifecycle = if (isForeground) Lifecycle.Background else Lifecycle.Background

        updateLifecycle(currentLifecycle)
    }

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)

        updateLifecycle(Lifecycle.Foreground)
    }

    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)

        updateLifecycle(Lifecycle.Foreground)
    }

    override fun onStop(owner: LifecycleOwner) {
        super.onStop(owner)

        updateLifecycle(Lifecycle.Background)
    }

    override fun onDestroy(owner: LifecycleOwner) {
        super.onDestroy(owner)

        updateLifecycle(Lifecycle.AppKilled)
    }

}